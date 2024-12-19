python utils/dataset_utils/gen_fastmri_data_info.py \
    --data_dir /home/alvinbk/project/EECE571/datasets/m4raw/multicoil_train \
    --data_info_dir data/m4raw \
    --num_files -1 \
    --acquisitions AXT1 AXT2 AXFLAIR \
    --data_info_file_name train_info

python utils/dataset_utils/gen_fastmri_data_info.py \
    --data_dir /home/alvinbk/project/EECE571/datasets/m4raw/multicoil_val \
    --data_info_dir data/m4raw \
    --num_files -1 \
    --acquisitions AXT1 AXT2 AXFLAIR \
    --data_info_file_name val_info

python utils/dataset_utils/gen_fastmri_data_info.py \
    --data_dir /home/alvinbk/project/EECE571/datasets/m4raw/multicoil_test \
    --data_info_dir data/m4raw \
    --num_files -1 \
    --acquisitions AXT1 AXT2 AXFLAIR \
    --data_info_file_name test_info