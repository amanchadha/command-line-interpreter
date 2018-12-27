#! /bin/csh -f

echo -n "537sh% " > results/22.out
ls -la /bin >> results/22.out
echo -n "537sh% " >> results/22.out
echo -n "537sh% " >> results/22.out
rm -f results/22.err
touch results/22.err
echo "An error has occurred" > results/22.err
echo 0 > results/22.status

./537sh <<EOF
ls -la /bin
pwdddd
exit


