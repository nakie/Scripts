###################################################
# Nathan Crews
# 05/03/2012
#
# This file should download the the most recent
#  copy of Scripts from GitHub.
##################################################

echo "Getting Files from GitHub"
curl -L https://github.com/nakie/Scripts/tarball/master | tar zx
