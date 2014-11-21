# $Id: mkpagelist.sh,v 2.10 2004/05/28 19:21:57 o Exp $
if [ -s pagemarks.numeric ]
then
    tail -1 pagemarks.numeric > $1
else
    echo 0 > $1
fi
cat pagemarks.alpha >> $1
