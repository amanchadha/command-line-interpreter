#! /bin/csh -f

# set tmpFile = `mktemp`
#echo tmpFile

set resultDir = results/
set test = 18

echo "cal|sorted" > in.txt
echo "cal|sorted" > ${resultDir}/${test}.out

rm -f ${resultDir}/${test}.err
echo "An error has occurred" > ${resultDir}/${test}.err
echo 0 > ${resultDir}/${test}.status

./537sh in.txt
