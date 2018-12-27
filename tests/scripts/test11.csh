#! /bin/csh -f

# set tmpFile = `mktemp`
#echo tmpFile

set resultDir = results/
set test = 11

rm -rf out.tmp
echo "ls -la > out.tmp" > in.txt
echo "cat out.tmp" >> in.txt

echo "ls -la > out.tmp" >${resultDir}/${test}.out
echo "cat out.tmp" >> ${resultDir}/${test}.out

ls -la > out.tmp
cat out.tmp >> ${resultDir}/${test}.out
rm -rf out.tmp

rm -f ${resultDir}/${test}.err
touch ${resultDir}/${test}.err

echo 0 > ${resultDir}/${test}.status

./537sh in.txt

rm -rf out.tmp
