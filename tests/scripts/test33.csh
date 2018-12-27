#! /bin/csh -f

# set tmpFile = `mktemp`
#echo tmpFile

set resultDir = results/
set test = 33

echo "   +++   +   ++ ++  " > in.txt
echo "   +++   +   ++ ++  " > ${resultDir}/${test}.out


rm -f ${resultDir}/${test}.err
touch ${resultDir}/${test}.err

echo 0 > ${resultDir}/${test}.status

./537sh in.txt
