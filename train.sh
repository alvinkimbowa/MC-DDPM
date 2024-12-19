#!/bin/bash

SOCKEYE=0

if [ $SOCKEYE -eq 1 ]; then
    data_dir=/home/alvinbk/project/EECE571/datasets/m4raw
    source ~/.bashrc
    conda activate promptmr
else
    data_dir=/home/alvin/UltrAi/Datasets/raw_datasets/m4raw/
    source venv/bin/activate
    export CUDA_VISIBLE_DEVICES=0
fi

acceleration=4

torchrun --nproc_per_node=1 train.py \
    --method_type mcddpm \
    --log_dir logs/m4raw/acc_${acceleration} \
    --dataset fastmri \
    --data_dir ${data_dir}/multicoil_train \
    --data_info_list_path data/m4raw/train_info.pkl \
    --batch_size 8 \
    --acceleration 4 \
    --num_workers 1 \
    --microbatch 2 \
    --log_interval 10 \
    --save_interval 5000 \
    --max_step 35000 \
    --model_save_dir logs/m4raw/acc_${acceleration}/checkpoints