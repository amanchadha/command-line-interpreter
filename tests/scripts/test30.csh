#! /bin/csh -f

echo "para 1+exit+para 0" > in.txt

echo "para 1+exit+para 0" > results/30.out
echo "this message should appear  FIRST" >> results/30.out
echo "1" >> results/30.out
echo "this message should appear  SECOND" >> results/30.out
echo "2" >> results/30.out

rm -f results/30.err
touch results/30.err
echo 0 > results/30.status

./537sh in.txt


