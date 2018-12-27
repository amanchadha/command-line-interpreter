#! /bin/csh -f

echo "ls -la /bin;exit;who" > in.txt

echo "ls -la /bin;exit;who" > results/19.out
ls -la /bin >> results/19.out

rm -f results/19.err
touch results/19.err
echo 0 > results/19.status
#echo $status > results/19.status

./537sh in.txt


