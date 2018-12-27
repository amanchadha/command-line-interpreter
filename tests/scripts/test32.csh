#! /bin/csh -f

echo "cal;pwddd;who" > in.txt

echo "cal;pwddd;who" > results/32.out
cal >> results/32.out
who >> results/32.out

rm -f results/32.err
echo "An error has occurred" > results/32.err
echo 0 > results/32.status

./537sh in.txt


