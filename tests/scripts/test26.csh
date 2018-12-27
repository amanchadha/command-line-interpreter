#! /bin/csh -f

echo "  cal  ;;; ; pwd; ;;; ;;  who ;; ;;   " > in.txt

echo "  cal  ;;; ; pwd; ;;; ;;  who ;; ;;   " > results/26.out
cal >> results/26.out
pwd >> results/26.out
who >> results/26.out

rm -f results/26.err
touch results/26.err
echo 0 > results/26.status

./537sh in.txt
