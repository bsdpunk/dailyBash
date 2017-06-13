#!/bin/bash - 
#===============================================================================
#
#          FILE: sort.sh
# 
#         USAGE: ./sort.sh 
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: YOUR NAME (), 
#  ORGANIZATION: 
#       CREATED: 05/25/2017 22:48
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error
mv *.csv ~/ml/data/
mv *.tsv ~/ml/data/
mv *.mp4 ~/mp4/
mv *.jpg ~/jpg/
mv *.gif ~/jpg/
mv *.png ~/jpg/
#rm -rf *.zip
#rm -rf *.tar.gz
#rm -rf *.tz
#rm -rf *.tgz
#rm -rf *.app
#rm -rf *.dmg
#rm -rf *.bz2
