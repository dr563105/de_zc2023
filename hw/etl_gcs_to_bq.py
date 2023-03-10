from pathlib import Path
import pandas as pd
from prefect import flow, task
from prefect_gcp.cloud_storage import GcsBucket
from prefect_gcp import GcpCredentials


@task(retries=3, log_prints=True)
def extract_from_gcs(color: str, year: int, month: int) -> Path:
    """Download trip data from GCS"""
    gcs_path = f"data/{color}/{color}_tripdata_{year}-{month:02}.parquet"
    gcs_block = GcsBucket.load("prefect-to-gcp-storage")
    gcs_block.get_directory(from_path=gcs_path, local_path=f"../input_data/")
    return Path(f"../input_data/{gcs_path}")


@task(log_prints=True)
def write_bq(df: pd.DataFrame) -> None:
    """Write DataFrame to BiqQuery"""

    gcp_credentials_block = GcpCredentials.load("prefect-gcp-creds")

    df.to_gbq(
        destination_table="nyc_taxi_trips.rides",
        project_id="nyc-taxi-river-dynamo-375819",
        credentials=gcp_credentials_block.get_credentials_from_service_account(),
        chunksize=500_000,
        if_exists="append",
    )


@flow(log_prints=True)
def etl_gcs_to_bq():
    """Main ETL flow to load data into Big Query"""
    color = "yellow"
    year = 2019
    month = 3

    path = extract_from_gcs(color, year, month)
    df = pd.read_parquet(path)
    print(df.head())
    write_bq(df)


if __name__ == "__main__":
    etl_gcs_to_bq()