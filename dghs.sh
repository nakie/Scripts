###################################################
# Nathan Crews
# 05/03/2012
#
# This file should download the the most recent
#  copy of Scripts from GitHub.
##################################################

echo "Getting Files from GitHub"
curl -L https://github.com/nakie/Scripts/tarball/master | tar zx

# Get single file form Scripts Repository.
# wget https://github.com/nakie/Scripts/raw/master/file
# chmod +x file

