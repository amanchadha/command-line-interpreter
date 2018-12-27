#! /bin/csh -f


echo "this command is nonexecutable" > in.txt
echo "this command is nonexecutable" > results/20.out

rm -f results/20.err
echo "An error has occurred" > results/20.err
echo 0 > results/20.status


./537sh in.txt
