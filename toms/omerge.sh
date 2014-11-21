# $Id: omerge.sh,v 2.10 2004/05/28 19:22:13 o Exp $

batch=$1
outfile=$2

rm -f $outfile; 

while read tag rest
do
    cat $batch"/header."$tag >> $outfile

    for object in page p1 p2 p3 parag
    do
	cat $batch"/objects."$object"."$tag >> $outfile;
    done
done

