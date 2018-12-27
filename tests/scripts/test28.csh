#! /bin/csh -f

# set tmpFile = `mktemp`
#echo tmpFile

set resultDir = results/
set test = 28

echo "cal | sort -r" > in.txt
echo "cal | sort -r" > ${resultDir}/${test}.out

cal | sort -r >> ${resultDir}/${test}.out

rm -f ${resultDir}/${test}.err
touch ${resultDir}/${test}.err

echo 0 > ${resultDir}/${test}.status

./537sh in.txt
