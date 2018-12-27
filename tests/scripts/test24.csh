#! /bin/csh -f

echo "cd /bin" > in.txt
echo "pwd" >> in.txt

echo "cd /bin" > results/24.out
echo "pwd" >> results/24.out
echo "/bin" >> results/24.out

rm -f results/24.err
touch results/24.err
echo 0 > results/24.status

./537sh in.txt
