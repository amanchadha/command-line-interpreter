#! /bin/csh -f

echo "  cal   ; pwd;   who    " > in.txt

echo "  cal   ; pwd;   who    " > results/8.out
cal >> results/8.out
pwd >> results/8.out
who >> results/8.out

rm -f results/8.err
touch results/8.err
echo 0 > results/8.status

./537sh in.txt
