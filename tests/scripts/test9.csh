#! /bin/csh -f

# set tmpFile = `mktemp`
#echo tmpFile

set tmpFile = fileout
set test = 9

echo "ls -la /bin | sort" > in.txt

echo "ls -la /bin | sort" > results/${test}.out

ls -la /bin | sort >> results/${test}.out

rm -f results/${test}.err
touch results/${test}.err
echo 0 > results/${test}.status

./537sh in.txt
