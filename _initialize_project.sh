#!/bin/sh

set -eu

CURDIR=$(cd $(dirname $0); pwd)
ORGNAME=$(basename $(dirname ${CURDIR}))
PROJNAME=$(basename ${CURDIR})
DRYRUN=no
DELETE=no

while getopts dno:p: OPT ; do
  case $OPT in
    d)
      DELETE=yes
      ;;
    n)
      DRYRUN=yes
      ;;
    o)
      ORGNAME="$OPTARG"
      ;;
    p)
      PROJNAME="$OPTARG"
      ;;
  esac
done

if [ "$DRYRUN" = "yes" ] ; then
  echo ORGNAME:  $ORGNAME
  echo PROJNAME: $PROJNAME
  echo DELETE:   $DELETE
  exit 1
fi

#name=$1 ; shift

grep -lr '{{\.\(Name\|Org\)}}' . | xargs sed -i.bak \
  -e "s/{{\.Name}}/${PROJNAME}/g" \
  -e "s/{{\.Org}}/${ORGNAME}/g" 
find . -type f -name \*.bak | xargs rm

if [ "$DELETE" = "yes" ] ; then
  rm -f $0
  rm -rf .git
fi
