#! /bin/csh -f

echo "para 1+exit+para 0" > in.txt

echo "para 1+exit+para 0" > results/17.out
echo "this message should appear  FIRST" >> results/17.out
echo "1" >> results/17.out
echo "this message should appear  SECOND" >> results/17.out
echo "2" >> results/17.out

rm -f results/17.err
touch results/17.err
echo 0 > results/17.status

./537sh in.txt


