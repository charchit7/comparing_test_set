# make the imagenet directory
mkdir imagenet
#extract the training data
# Create train directory; move .tar file; change directory
mkdir imagenet/train && mv ILSVRC2012_img_train.tar imagenet/train/ && cd imagenet/train
# Extract training set; remove compressed file
tar -xvf ILSVRC2012_img_train.tar && rm -f ILSVRC2012_img_train.tar

# For each .tar file: 
#   1. create directory with same name as .tar file
#   2. extract and copy contents of .tar file into directory
#   3. remove .tar file
find . -name "*.tar" | while read NAME ; do mkdir -p "${NAME%.tar}"; tar -xvf "${NAME}" -C "${NAME%.tar}"; rm -f "${NAME}"; done

# This results in a training directory like so:
#
#  imagenet/train/
#  ├── n01440764
#  │   ├── n01440764_10026.JPEG
#  │   ├── n01440764_10027.JPEG
#  │   ├── ......
#  ├── ......
#
# Change back to original directory
cd ../..

mkdir imagenet/val && mv ILSVRC2012_img_val.tar imagenet/val/ && cd imagenet/val && tar -xvf ILSVRC2012_img_val.tar && rm -f ILSVRC2012_img_val.tar
# this script sends the 25k images to their respective class folders.
wget -qO- https://raw.githubusercontent.com/charchit7/comparing_test_set/main/new_split_val.sh | bash

mkdir test_set
# this sends the 25k images to test_set
wget -qO- https://raw.githubusercontent.com/charchit7/comparing_test_set/main/create_split_folder.sh | bash

mv test_set ../
cd ../
cd test_set

#this sends those reminaing 25k iamges to respective class folders.
wget -qO- https://raw.githubusercontent.com/charchit7/comparing_test_set/main/new_split_test.sh | bash
