#!/bin/sh

set -eu

CURDIR=$(cd $(dirname $0); pwd)
ORGNAME=$(basename $(dirname ${CURDIR}))
PROJNAME=$(basename ${CURDIR})

#name=$1 ; shift

grep -lr '{{\.\(Name\|Org\)}}' . | xargs sed -i.bak \
  -e "s/{{\.Name}}/${PROJNAME}/g" \
  -e "s/{{\.Org}}/${ORGNAME}/g" 
find . -type f -name \*.bak | xargs rm

#rm -f $0
