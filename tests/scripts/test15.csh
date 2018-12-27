#! /bin/csh -f

echo "para 2+para 1+para 0" > in.txt

echo "para 2+para 1+para 0" > results/15.out
echo "this message should appear  FIRST" >> results/15.out
echo "1" >> results/15.out
echo "this message should appear  SECOND" >> results/15.out
echo "2" >> results/15.out
echo "this message should appear  THIRD" >> results/15.out
echo "3" >> results/15.out

rm -f results/15.err
touch results/15.err
echo 0 > results/15.status

./537sh in.txt


