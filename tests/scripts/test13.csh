#! /bin/csh -f

# set tmpFile = `mktemp`
#echo tmpFile

set resultDir = results/
set test = 13

rm -rf out.tmp
echo "pwd ; ls -la /bin > out.tmp" > in.txt
echo "cat out.tmp" >> in.txt

echo "pwd ; ls -la /bin > out.tmp" > ${resultDir}/${test}.out
pwd >> ${resultDir}/${test}.out
echo "cat out.tmp" >> ${resultDir}/${test}.out

ls -la /bin > out.tmp
cat out.tmp >> ${resultDir}/${test}.out
rm -rf out.tmp

rm -f ${resultDir}/${test}.err
touch ${resultDir}/${test}.err

echo 0 > ${resultDir}/${test}.status

./537sh in.txt

rm -rf out.tmp
