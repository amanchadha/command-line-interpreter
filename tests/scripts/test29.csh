#! /bin/csh -f

#echo "para 2 | sort+para 1 | sort+para 0 | sort" > in.txt

#echo "para 2 | sort+para 1 | sort+para 0 | sort" > results/29.out
#echo "1" >> results/29.out
#echo "this message should appear  FIRST" >> results/29.out
#echo "2" >> results/29.out
#echo "this message should appear  SECOND" >> results/29.out
#echo "3" >> results/29.out
#echo "this message should appear  THIRD" >> results/29.out

echo "echo dog > 1.tmp+echo zebra > 2.tmp+echo giraffe> 3.tmp+echo catfish > 4.tmp" > in.txt
echo "echo dog > 1.tmp+echo zebra > 2.tmp+echo giraffe> 3.tmp+echo catfish > 4.tmp" > results/29.out 

echo "cat 1.tmp 2.tmp 3.tmp 4.tmp > result.tmp" >> in.txt
echo "cat 1.tmp 2.tmp 3.tmp 4.tmp > result.tmp" >> results/29.out

echo "sort result.tmp" >> in.txt
echo "sort result.tmp" >> results/29.out 
echo "catfish" >> results/29.out
echo "dog" >> results/29.out
echo "giraffe" >> results/29.out
echo "zebra" >> results/29.out

rm -f results/29.err
touch results/29.err
echo 0 > results/29.status

./537sh in.txt

rm -rf *.tmp
