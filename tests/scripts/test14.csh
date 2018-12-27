#! /bin/csh -f

echo "+" > in.txt

echo "+" > results/14.out
rm -f results/14.err
touch results/14.err
echo 0 > results/14.status

./537sh in.txt
