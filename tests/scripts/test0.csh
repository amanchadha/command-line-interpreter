#! /bin/csh -f

echo "An error has occurred" > results/0.err
touch results/0.out
echo 1 > results/0.status


#touch in.txt
./537sh in.txt bar.txt

