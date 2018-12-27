#! /bin/csh -f

echo "cd" > in.txt
echo "pwd" >> in.txt

echo "cd" > results/4.out
echo "pwd" >> results/4.out
echo /afs/cs.wisc.edu$HOME >> results/4.out
rm -f results/4.err
touch results/4.err
echo 0 > results/4.status

#(./myprog in.txt > results/7.out) >& results/7.err
#echo $status > results/7.status

./537sh in.txt
