#! /bin/csh -f

echo -n "537sh% " > results/34.out
ls -la /bin >> results/34.out
echo -n "537sh% " >> results/34.out
pwd >> results/34.out
echo -n "537sh% " >> results/34.out
rm -f results/34.err
touch results/34.err
echo 0 > results/34.status

./537sh <<EOF
ls -la /bin
pwd
exit

