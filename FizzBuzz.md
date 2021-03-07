# FizzBuzz
Fizz Buzz is alledgedly originally a childrens game to practice division, with some simple rules.\
The first player starts by saying the number 1 and players then take turn counting upwards one number at a time, but: 
* If a number is evenly divisable by 3, the player instead says 'Fuzz'
* If a number is evenly divisable by 5, the player instead says 'Buzz'
* If a number is evenly divisable by both 3 and 5, the player says 'FizzBuzz'
So, it would start like this:\
1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, Fizz Buzz, 16, 17, Fizz, 19, Buzz, Fizz, 22, 23, Fizz 

##As a programming puzzle
Implementing this in programming as 'Output the first 100 rounds of the FizzBuzz game' is a common programming puzzle so let's look at a couple of solutions in ABAP

## Solution 1
This solution is the most basic, simple and straigt-forward solution I could think of.\
We build up the overall result in the output variable by determining the this_turn_output variable inside the DO 100 TIMES/ENDDO block.\
For each turn performs these operations: 
1. Set this_turn_output to the current iteration number from the DO statement. This is given to us from the system variable sy-index.
2. Check if the current turn number is evenly divisible by three and, if so, change this_turn_output to 'Fizz'.
3. Check if the current turn number is evenly divisible by five and, if so, change this_turn_output to 'Buzz'.
4. Check if the current turn number is evenly divisible by both three and five and, if so, change this_turn_output to 'FizzBuzz'.
5. Add this_turn_output to the total output 


This approach is not very optimized as it always checks all the conditions and divisions.\
This is especially apparent for numbers that are evenly divisible by both 3 and 5. Example for number 15: 
1. this_turn_output will be set to 15.
2. Division by 3 is checked and this_turn_output will be changed to 'Fizz'. 
3. Division by 5 is checked and this_turn_output will be changed to 'Buzz'. 
4. Both division by 3 and division by 5 is checked again and this_turn_output will be set to 'FizzBuzz'. 

### ABAP Language Used
#### DO
The DO 100 Times statment performs the statements inside the block (down until the ENDDO statement) 100 times.\
The system variable sy-index is set to the number of the current loop pass, so we use that to count from 1 to 100.
#### IF
Conditional control structure 
#### MOD
MOD is an arithmetic operator that gives us the remainder of a division. If the remainder is 0, then the division between the left operand by the right was even
#### String templates
The string template |{ output }\n{ this_turn_output }| is adding a newline \n and the this_turn_output to the total output variable
#### cl_demo_output
The demo class cl_demo_output is used to display the output result in a convenient window.\
This is, I believe, the most convenient way to have the differnt demo solutions run and output data on an on-premise SAP system.
