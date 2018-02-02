#!/bin/bash - 
#===============================================================================
#
#          FILE: posix2nfs.sh
# 
#         USAGE: ./posix2nfs.sh 
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: Dusty Carver, 
#  ORGANIZATION: 
#       CREATED: 01/19/2018 07:56
#      REVISION:  ---
#===============================================================================

#set -o nounset                              # Treat unset variables as an error

FILE=$1
READ=0
WRITE=0
XCUTE=0
READ=0
WRITE=0
XCUTE=0
R=''
W=''
X=''
t=''
T=''
d=''
A=''

FULLPERMS=''

function applyPerms() {

    FULLPERMS=''
    READ=0
    WRITE=0
    XCUTE=0
    READ=0
    WRITE=0
    XCUTE=0
    R=''
    W=''
    X=''
    t=''
    T=''
    d=''
    A=''


    case $1 in
        *r*)
            READ=4
            R="r"
            t="t"
            ;;&
        *w*)
            WRITE=2
            W="w"
            T="T"
            d="d"
            ;;&
        *x*)
            XCUTE=1
            X="x"
            A='a'
            ;;
    esac

    FULLPERMS="${R}${W}${A}${t}${T}${d}${X}"
}

OWNER=$(getfacl $FILE | grep 'owner' | awk -F: '{print $2}')
GROUP=$(getfacl $FILE | grep 'group' | head -n1 | awk -F: '{print $2}')
USERPERM=$(getfacl $FILE | grep 'user::' | awk -F: '{print $3}')
GROUPPERM=$(getfacl $FILE | grep 'group::' |  awk -F: '{print $3}')
EVERYONE=$(getfacl $FILE | grep 'other:' | tail -n1 |  awk -F: '{print $2}')
EXPERM=$(getfacl $FILE |grep 'user:'| grep -v 'user::')
EXGPERM=$(getfacl $FILE |grep '^group:'| grep -v 'group::')

applyPerms $USERPERM 

echo "nfs4_setfacl -a A::OWNER@:${FULLPERMS} $FILE"

applyPerms $GROUPPERM 

echo "nfs4_setfacl -a A::GROUP@:${FULLPERMS} $FILE"

applyPerms $EVERYONE

echo "nfs4_setfacl -a A::EVERYONE@:${FULLPERMS} $FILE"


for i in $( echo $EXPERM )
do

    PERMS=$( echo $i | awk -F: '{ print $3 }' )
    USER=$( echo $i | awk -F: '{ print $2 }' )
    applyPerms $PERMS
    echo "nfs4_setfacl -a A::${USER}:${FULLPERMS} $FILE"

done



for i in $( echo $EXGPERM )
do

    PERMS=$( echo $i | awk -F: '{ print $3 }' )
    USER=$( echo $i | awk -F: '{ print $2 }' )
    applyPerms $PERMS
    echo "nfs4_setfacl -a A:g:${USER}:${FULLPERMS} $FILE"

done
