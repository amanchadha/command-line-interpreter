#! /bin/csh -f

# set tmpFile = `mktemp`
#echo tmpFile

set resultDir = results/
set test = 12 

#rm -rf ${resultDir}/${test}.out
#rm -rf ${resultDir}/${test}.err
#rm -rf ${resultDir}/${test}.status

#touch ${resultDir}/${test}.out
#touch ${resultDir}/${test}.err
#touch ${resultDir}/${test}.status

echo "echo hello > /this/path/should/not/exist/out.tmp" > in.txt

echo "echo hello > /this/path/should/not/exist/out.tmp" > ${resultDir}/${test}.out
echo "An error has occurred" > ${resultDir}/${test}.err


echo 0 > ${resultDir}/${test}.status

./537sh in.txt

