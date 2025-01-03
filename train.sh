#!/bin/bash

### GPU batch job ###
#SBATCH --job-name=promptmr_all
#SBATCH --account=st-ilker-1-gpu
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=12
#SBATCH --gpus=1
#SBATCH --mem=32G
# #SBATCH --constraint=gpu_mem_32
#SBATCH --time=5-10:00:00
#SBATCH --output=outputs/%x-%j_output.txt
#SBATCH --error=outputs/%x-%j_error.txt
# #SBATCH --mail-user=alvinbk@student.ubc.ca
# #SBATCH --mail-type=ALL

#############################################################################

SOCKEYE=1

if [ $SOCKEYE -eq 1 ]; then
    data_dir=/home/alvinbk/project/EECE571/datasets/m4raw
    source ~/.bashrc
    conda activate promptmr
else
    data_dir=/home/alvin/UltrAi/Datasets/raw_datasets/m4raw/
    source venv/bin/activate
    export CUDA_VISIBLE_DEVICES=0
fi

acceleration=2
batch_size=32
microbatch=8

# resume_checkpoint=logs/m4raw/acc_${acceleration}/checkpoints/step_35000.pth

echo acceleration: $acceleration
echo batch_size: $batch_size
echo microbatch: $microbatch

torchrun --nproc_per_node=1 train.py \
    --method_type mcddpm \
    --log_dir logs/m4raw/acc_${acceleration} \
    --dataset fastmri \
    --data_dir ${data_dir}/multicoil_train \
    --data_info_list_path data/m4raw/train_info.pkl \
    --batch_size $batch_size \
    --acceleration $acceleration \
    --num_workers 1 \
    --microbatch $microbatch \
    --log_interval 10 \
    --save_interval 5000 \
    --max_step 35000 \
    --model_save_dir logs/m4raw/acc_${acceleration}/checkpoints