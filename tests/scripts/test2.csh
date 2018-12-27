#! /bin/csh -f

echo "pwd" > in.txt

echo "pwd" > results/2.out
pwd >> results/2.out

rm -f results/2.err
touch results/2.err

echo 0 > results/2.status


./537sh in.txt
