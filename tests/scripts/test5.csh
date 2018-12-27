#! /bin/csh -f

echo "ls -la /bin" > in.txt

echo "ls -la /bin" > results/5.out
ls -la /bin >> results/5.out
rm -f results/5.err
touch results/5.err
echo 0 > results/5.status

./537sh in.txt
