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
