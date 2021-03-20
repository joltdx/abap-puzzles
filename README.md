# abap-puzzles
Programming puzzles and challenges, with example solutions in ABAP

My intention here is to demonstrate different ways of solving these puzzles and challenges in ABAP, using the many aspects of the ABAP language, while giving some ideas on how to solve <em>real</em> problems in ABAP. :)

Hopefully I will be able to shed some light om similarities and differences of ABAP approaches, and maybe even the odds and ends of the ABAP language. 

This page contains explanations of the different puzzles/challanges with links to example solutions and explanations. If you want to try for yourself before seing any example solutions first, then stay in this file. 


If you want me to attack a certain puzzle or challenge, please let me know by issue, email, telnet or fax, whichever is most convenient for you. And please also share additional solutions and comments!

## FizzBuzz
Fizz Buzz is allegedly originally a childrens game to practice division, with some simple rules.\
The first player starts by saying the number 1 and players then take turn counting upwards one number at a time, but: 
* If a number is evenly divisable by 3, the player instead says 'Fizz'
* If a number is evenly divisable by 5, the player instead says 'Buzz'
* If a number is evenly divisable by both 3 and 5, the player says 'FizzBuzz'

So, it would start like this:\
1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, Fizz Buzz, 16, 17, Fizz, 19, Buzz, Fizz, 22, 23, Fizz 

The challenge here is to implement this in ABAP to output the first 100 rounds of the FizzBuzz game.

[Example solutions and explanations to FizzBuzz](https://github.com/joltdx/abap-puzzles/blob/main/FizzBuzz.md)

## Narcissistic numbers, or Arnold numbers
In number theory, a narcissistic number is a number where the sum of each of its digits raised to the power of the total number of digits equals the number itself.\
This is the case for instance for the number 153. It has 3 digits, so when each digit is raised to the power 3, then the sum equals 153.\
1^3 + 5^3 + 3^3 = 1 + 125 + 27 = 153\

Narcissistic number are also known as Armstrong numbers or plus perfect numbers

The task is to implement a program that lists all narcissistic numbers with 5 or less digits, i.e. between 0 and 99999.\
These are, for reference 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 153, 370, 371, 407, 1634, 8208, 9474, 54748, 92727 and 93084\

[Example solutions and explanations to Narcissistic numbers](Narcissistic_numbers.md)
