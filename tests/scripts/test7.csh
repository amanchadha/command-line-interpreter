#! /bin/csh -f

echo "ls -la /bin;cal;who" > in.txt

echo "ls -la /bin;cal;who" > results/7.out
ls -la /bin >> results/7.out
cal >> results/7.out
who >> results/7.out

rm -f results/7.err
touch results/7.err
echo 0 > results/7.status

./537sh in.txt


