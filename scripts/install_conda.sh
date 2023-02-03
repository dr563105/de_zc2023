#!/bin/bash

cd ~
wget -q https://repo.anaconda.com/miniconda/Miniconda3-py39_4.12.0-Linux-x86_64.sh -O Miniconda3-py39_4.12.0-Linux-x86_64.sh
bash ~/Miniconda3-py39_4.12.0-Linux-x86_64.sh -b
~/miniconda3/bin/conda init $SHELL_NAME
rm Miniconda3-py39_4.12.0-Linux-x86_64.sh
cd ~/de_zc2023