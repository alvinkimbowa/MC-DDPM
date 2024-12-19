import os
import h5py
import numpy as np
import argparse
import pickle
from tqdm import tqdm


NUM_CUT_SLICES = 5


def create_argparser():
    parser = argparse.ArgumentParser()
    parser.add_argument("--data_dir", type=str)
    parser.add_argument("--data_info_dir", default="data/fastmri", type=str)
    parser.add_argument("--num_files", default=-1, type=int)
    parser.add_argument("--acquisitions", nargs="+", type=str)
    parser.add_argument("--data_info_file_name", type=str)
    return parser


def main():
    args = create_argparser().parse_args()
    file_list = []
    for entry in sorted(os.listdir(args.data_dir)):
        ext = entry.split(".")[-1]
        if "." in entry and ext == "h5":
            file_list.append(entry)
            if args.num_files == len(file_list):
                break

    data_info_list = []
    count = 0
    for file_name in tqdm(file_list):
        if count == args.num_files:
            break

        file_path = os.path.join(args.data_dir, file_name)
        data = h5py.File(file_path, mode="r")
        image_rss = np.array(data["reconstruction_rss"])
        acquisition = data.attrs["acquisition"]
        num_slice = len(image_rss)

        if acquisition in args.acquisitions:
            for i in range(NUM_CUT_SLICES, num_slice - NUM_CUT_SLICES):
                data_info_list.append((file_name, i))
            count += 1

    os.makedirs(args.data_info_dir, exist_ok=True)
    with open(os.path.join(args.data_info_dir, f"{args.data_info_file_name}.pkl"), "wb") as f:
        pickle.dump(data_info_list, f)
        print(f"{args.data_info_file_name}, num of slices: {len(data_info_list)}")


if __name__ == "__main__":
    main()
