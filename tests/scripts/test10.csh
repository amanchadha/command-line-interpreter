#! /bin/csh -f

# set tmpFile = `mktemp`
#echo tmpFile

set resultDir = results/
set test = 10

echo "cal|" > in.txt
echo "cal|" > ${resultDir}/${test}.out

rm -f ${resultDir}/${test}.err
echo "An error has occurred" > ${resultDir}/${test}.err
echo 0 > ${resultDir}/${test}.status

./537sh in.txt
