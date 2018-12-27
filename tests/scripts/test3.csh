#! /bin/csh -f

echo "exit" > in.txt

echo "exit" > results/3.out
touch results/3.err
echo 0 > results/3.status

#(./myprog in.txt > results/6.out) >& results/6.err
#echo $status > results/6.status

./537sh in.txt
 
