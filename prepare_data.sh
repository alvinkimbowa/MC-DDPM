SOCKEYE=0

if [ $SOCKEYE -eq 1 ]; then
    data_dir=/home/alvinbk/project/EECE571/datasets/m4raw
else
    data_dir=/home/alvin/UltrAi/Datasets/raw_datasets/m4raw/
fi

acquisitions="AXT1 AXT2 AXFLAIR"
data_info_dir=data/m4raw
num_files=-1

python utils/dataset_utils/gen_fastmri_data_info.py \
    --data_dir ${data_dir}/multicoil_train \
    --data_info_dir $data_info_dir \
    --num_files $num_files \
    --acquisitions $acquisitions \
    --data_info_file_name train_info

python utils/dataset_utils/gen_fastmri_data_info.py \
    --data_dir ${data_dir}/multicoil_val \
    --data_info_dir $data_info_dir \
    --num_files $num_files \
    --acquisitions $acquisitions \
    --data_info_file_name val_info

python utils/dataset_utils/gen_fastmri_data_info.py \
    --data_dir ${data_dir}/multicoil_test \
    --data_info_dir $data_info_dir \
    --num_files $num_files \
    --acquisitions $acquisitions \
    --data_info_file_name test_info