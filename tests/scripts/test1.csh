#! /bin/csh -f

echo "An error has occurred" > results/1.err
touch results/1.out
echo 1 > results/1.status

./537sh /this/file/is/inaccessible
