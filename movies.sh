#!/bin/bash - 
#===============================================================================
#
#          FILE: movies.sh
# 
#         USAGE: ./movies.sh 
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: Dusty Carver, BSDPunk 
#  ORGANIZATION: 
#       CREATED: 06/13/2017 14:40
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error

function findmovies () { printf "find $(pwd) -type f \\( -name \"*mpg\" $(cat filetypes | ggrep -P -o "A\'\*\w+" | gsed "s/A'\*\([a-z0-9]\+\)/\-o \-name \"\*\1\" /"| tr -d '\n')" | gsed 's/$/ \\) \-exec mpv {} +/'; }
function playmovies () { eval "$(findmovies)";  }

