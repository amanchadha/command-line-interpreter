#! /bin/csh -f

echo "pwd /my/favourite/dir" > in.txt

echo "An error has occurred" > results/23.err
echo "pwd /my/favourite/dir" > results/23.out
echo 0 > results/23.status

#(./myprog in.txt > results/23.out) >& results/5.err


#echo $status > results/23.status

./537sh in.txt
