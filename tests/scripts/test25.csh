#! /bin/csh -f

echo ";;;;;;" > in.txt

echo ";;;;;;" > results/25.out
rm -f results/25.err
touch results/25.err
echo 0 > results/25.status

./537sh in.txt
