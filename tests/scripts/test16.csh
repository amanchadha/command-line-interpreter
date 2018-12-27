#! /bin/csh -f

echo "para 2 | sort+para 1 | sort+para 0 | sort" > in.txt

echo "para 2 | sort+para 1 | sort+para 0 | sort" > results/16.out
echo "1" >> results/16.out
echo "this message should appear  FIRST" >> results/16.out
echo "2" >> results/16.out
echo "this message should appear  SECOND" >> results/16.out
echo "3" >> results/16.out
echo "this message should appear  THIRD" >> results/16.out

rm -f results/16.err
touch results/16.err
echo 0 > results/16.status

./537sh in.txt


