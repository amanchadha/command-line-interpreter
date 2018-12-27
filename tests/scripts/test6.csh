#! /bin/csh -f

echo "This verifies one of the assumptions of this project, that your shell checks for a line of length 512 characters. Let's see whether your programs holds this basic assumption. What I do after this is to check the length of this line. Alas! it is well below 512 characters, only 181 characters. Now, I check again. This time the count is much better. It is 308 characters in length. So, how many more characters do I have to fill. By simple subtraction, it turns out to be 204. And I'm sure this additional junk will be good enough." > in.txt
echo "cal" >> in.txt

echo "This verifies one of the assumptions of this project, that your shell checks for a line of length 512 characters. Let's see whether your programs holds this basic assumption. What I do after this is to check the length of this line. Alas! it is well below 512 characters, only 181 characters. Now, I check again. This time the count is much better. It is 308 characters in length. So, how many more characters do I have to fill. By simple subtraction, it turns out to be 204. And I'm sure this additional junk will be good enough." > results/6.out
echo "cal" >> results/6.out
cal >> results/6.out

echo "An error has occurred" > results/6.err
echo 0 > results/6.status

./537sh in.txt
