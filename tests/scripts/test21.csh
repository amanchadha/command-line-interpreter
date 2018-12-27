#! /bin/csh -f

echo "ls -la /bin" > in.txt
echo "pwd" >> in.txt
echo "who" >> in.txt
echo "ls -la /bin" > results/21.out
ls -la /bin >> results/21.out
echo "pwd" >> results/21.out
pwd >> results/21.out
echo "who" >> results/21.out
who >> results/21.out
rm -f results/21.err
touch results/21.err
echo 0 > results/21.status

./537sh in.txt
