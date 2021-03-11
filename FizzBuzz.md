# FizzBuzz
Fizz Buzz is allededly originally a childrens game to practice division, with some simple rules.\
The first player starts by saying the number 1 and players then take turn counting upwards one number at a time, but: 
* If a number is evenly divisable by 3, the player instead says 'Fizz'
* If a number is evenly divisable by 5, the player instead says 'Buzz'
* If a number is evenly divisable by both 3 and 5, the player says 'FizzBuzz'

So, it would start like this:\
1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, Fizz Buzz, 16, 17, Fizz, 19, Buzz, Fizz, 22, 23, Fizz 

## As a programming puzzle
Implementing this in programming as 'Output the first 100 rounds of the FizzBuzz game' is a common programming puzzle so let's look at a couple of solutions in ABAP.\
Solutions are in class [src/zcl_puzzle_fizzbuzz.clas.abap](src/zcl_puzzle_fizzbuzz.clas.abap)


# Solution 1
```abap
  METHOD fizzbuzz_1.
    DATA output TYPE string.
    DATA this_turn_output TYPE string.

    DO 100 TIMES.
      this_turn_output = sy-index.

      IF sy-index MOD 3 = 0.
        this_turn_output = 'Fizz'.
      ENDIF.

      IF sy-index MOD 5 = 0.
        this_turn_output = 'Buzz'.
      ENDIF.

      IF sy-index MOD 3 = 0 AND
         sy-index MOD 5 = 0.
        this_turn_output = 'FizzBuzz'.
      ENDIF.

      output = |{ output }\n{ this_turn_output }|.
    ENDDO.

    cl_demo_output=>display( output ).
  ENDMETHOD.
```
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


# Solution 2
```abap
  METHOD fizzbuzz_2.
    DATA output TYPE string.
    DATA this_turn_output TYPE string.

    DO 100 TIMES.
      IF sy-index MOD 15 = 0.
        this_turn_output = 'FizzBuzz'.
      ELSEIF sy-index MOD 3 = 0.
        this_turn_output = 'Fizz'.
      ELSEIF sy-index MOD 5 = 0.
        this_turn_output = 'Buzz'.
      ELSE.
        this_turn_output = sy-index.
      ENDIF.

      output = |{ output }\n{ this_turn_output }|.
    ENDDO.

    cl_demo_output=>display( output ).
  ENDMETHOD.
```
Compared to solution 1, this solution only checks each condition once.\
Also, the check for even division by both 3 and 5 is replaced by a check for their lowest common denominator 15.\
By using IF, ELSEIF and ENDIF, as soon as one of the conditions are met, no other calculations of checks are made.
This also required us to switch the order of the checks to the opposite of the first solution.


# Solution 3
```abap
  METHOD fizzbuzz_3.
    DATA output TYPE string.
    DATA this_turn_output TYPE string.

    DO 100 TIMES.
      CLEAR this_turn_output.

      IF sy-index MOD 3 = 0.
        this_turn_output = 'Fizz'.
      ENDIF.

      IF sy-index MOD 5 = 0.
        this_turn_output = |{ this_turn_output }Buzz|.
      ENDIF.

      IF this_turn_output IS INITIAL.
        this_turn_output = sy-index.
      ENDIF.

      output = |{ output }\n{ this_turn_output }|.
    ENDDO.

    cl_demo_output=>display( output ).
  ENDMETHOD.
```
Here's another way of solving this and lowering the number of comparisons.

1.We start each pass in the DO block by clearing the this_turn_output variable.
2.Next we check if the number is evenly divisible by 3 and set this_turn_output to 'Fizz' if so.
3.Next we check if the number is evenly divisible by 5. If it is we add the word 'Buzz' to this_turn_output. This means that if the number was NOT evenly divisible by three, we will have 'Buzz' now. If, however, it WAS evenly divisible by 3 we would already have 'Fizz' and then adding 'Buzz' gets us 'FizzBuzz'.
4.Now instead we need a new comparison the see if we have set anything in the this_turn_output. If we have not, then we put the current turn number in there. 


# Solution 4
```abap
  METHOD fizzbuzz_4.
    DATA turns TYPE STANDARD TABLE OF i WITH EMPTY KEY.
    DATA output TYPE STANDARD TABLE OF string WITH EMPTY KEY.

    DO 100 TIMES.
      APPEND sy-index TO turns.
    ENDDO.

    output = VALUE #( FOR turn IN turns
                      ( COND #( WHEN turn MOD 15 = 0 THEN 'FizzBuzz'
                                WHEN turn MOD 5 = 0 THEN 'Buzz'
                                WHEN turn MOD 3 = 0 THEN 'Fizz'
                                ELSE turn ) ) ).

    cl_demo_output=>display( output ).
  ENDMETHOD.
```
Here we start by using DO/ENDDO to create a table containing the number 1-100. Next, we use the VALUE construcor expression to create a new table containing our total output.\
FOR turn IN turns takes each line in the turns table (number 1-100) and puts it in the new table based according to what we specify inside.\
The COND conditional expression is determining the new line content based on the current number and the calculations.
This is basically comparable to the IF/ELSEIF/ELSEIF/ELSE we used in fizzbuzz_2\

### Additional ABAP language used
#### VALUE
The VALUE operator is a constructor extpression that can create structures or tables 
#### COND
A conditional expression with a result based on a logic expression


# Solution 5
```abap
  METHOD fizzbuzz_5.
    DATA turns TYPE STANDARD TABLE OF i WITH EMPTY KEY.
    DATA output TYPE STANDARD TABLE OF string WITH EMPTY KEY.


    DO 100 TIMES.
      APPEND sy-index TO turns.
    ENDDO.


    output = VALUE #( FOR turn IN turns
                      ( get_turn_output( turn ) ) ).


    cl_demo_output=>display( output ).
  ENDMETHOD.
```
```abap
  METHOD get_turn_output.
    result = COND #( WHEN turn MOD 15 = 0 THEN |FizzBuzz|
                     WHEN turn MOD 5 = 0 THEN |Buzz|
                     WHEN turn MOD 3 = 0 THEN |Fizz|
                     ELSE turn ).
  ENDMETHOD.
```
Let's move the whole COND expression into a method of its own called get_turn_output, taking the turn number as input and returning the desired output for that turn.\
We call that method in the VALUE expression instead of the COND itself.


# Solution 6
```abap
  METHOD fizzbuzz_6.
    DATA output TYPE STANDARD TABLE OF string WITH EMPTY KEY.
    DATA special_cases TYPE RANGE OF string.

    DO 100 TIMES.
      APPEND |{ sy-index }| TO output.
    ENDDO.

    DO 100 / 15 TIMES.
      INSERT VALUE #( sign = 'I'
                      option = 'EQ'
                      low = |{ sy-index * 15 }| ) INTO TABLE special_cases.
    ENDDO.
    MODIFY output FROM |FizzBuzz| TRANSPORTING table_line WHERE table_line IN special_cases.

    CLEAR special_cases[].
    DO 100 / 5 TIMES.
      INSERT VALUE #( sign = 'I'
                      option = 'EQ'
                      low = |{ sy-index * 5 }| ) INTO TABLE special_cases.
    ENDDO.
    MODIFY output FROM |Buzz| TRANSPORTING table_line WHERE table_line IN special_cases.

    CLEAR special_cases[].
    DO 100 / 3 TIMES.
      INSERT VALUE #( sign = 'I'
                      option = 'EQ'
                      low = |{ sy-index * 3 }| ) INTO TABLE special_cases.
    ENDDO.
    MODIFY output FROM |Fizz| TRANSPORTING table_line WHERE table_line IN special_cases.

    cl_demo_output=>display( output ).
  ENDMETHOD.
```
Haha, well, in this solution there is again the DO/ENDDO creating a table containing the numbers 1-100 but in the format of strings. Next, to set the Fizz, Buzz and FizzBuzz where relevant, we take a backwards approach and determine beforehand which turns should be changed.\

Starting with FizzBuzz we create a range of the values to be replaced by 'FizzBuzz'. This is every fiftenth number. Use of the MODIFY statement will then change the contents of those lines to 'FizzBuzz'.\
We clear that range and then fill it with every fifth number, and replace those lines with 'Buzz'.\
And finally we repeat this once more, replacing every third number with 'Fizz'.\

The order is important here as well If we start by replacing every third number, these will no longer be found as matches when comparing for every 15th number, as they will say 'Fizz' instead...

### Additional ABAP language used
#### INSERT
Used here to insert lines into an internal table 
#### MODIFY
Modifying lines of the internal table


# Solution 7
```abap
  METHOD fizzbuzz_7.
    DATA output TYPE STANDARD TABLE OF string WITH EMPTY KEY.

    output = VALUE #( FOR turn = 1 UNTIL turn > 100
                      ( get_turn_output( turn ) ) ).

    cl_demo_output=>display( output ).
  ENDMETHOD.
```
In solutions 4 and 5, we used DO/ENDDO to first create a table with the numbers 1-100 and then use the VALUE operator. It is possible to do the same kind of solution, without that table, like in this solution.\
We use the FOR/UNTIL instead of the FOR/IN here and the iteration expression will count up from 1 to 100 for us here, as specified.


# Solution 8
```abap
  METHOD fizzbuzz_8.
    DATA(output) = REDUCE string( INIT out = ||
                                  FOR turn = 1 UNTIL turn > 100
                                  NEXT out = |{ out }{ get_turn_output( turn ) }\n| ).

    cl_demo_output=>display( output ).
  ENDMETHOD.
```
Compared to fizzbuzz_7 where the VALUE operator created a table with the turns, here we use the REDUCE operator to create a string instead.\
In INIT, we initialize our output variable, the FOR specifies which cases to iterate, and NEXT is adding the output for the current turn to the total output, using the same COND method that we've used before.

### Additional ABAP language used
#### REDUCE
The reduction operator REDUCE here helps us convert the table into a single result in form of a string
