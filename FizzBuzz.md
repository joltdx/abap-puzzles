# FizzBuzz
Fizz Buzz is alledgedly originally a childrens game to practice division, with some simple rules.\
The first player starts by saying the number 1 and players then take turn counting upwards one number at a time, but: 
* If a number is evenly divisable by 3, the player instead says 'Fuzz'
* If a number is evenly divisable by 5, the player instead says 'Buzz'
* If a number is evenly divisable by both 3 and 5, the player says 'FizzBuzz'

So, it would start like this:\
1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, Fizz Buzz, 16, 17, Fizz, 19, Buzz, Fizz, 22, 23, Fizz 

## As a programming puzzle
Implementing this in programming as 'Output the first 100 rounds of the FizzBuzz game' is a common programming puzzle so let's look at a couple of solutions in ABAP.\
Solutions are in class [src/zcl_puzzle_fizzbuzz.clas.abap](src/zcl_puzzle_fizzbuzz.clas.abap)

## Solution 1
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

## Solution 2
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

## Solution 3
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

## Solution 4
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

## Solution 5
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

## Solution 6
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

## Solution 7
```abap
  METHOD fizzbuzz_7.
    DATA output TYPE STANDARD TABLE OF string WITH EMPTY KEY.

    output = VALUE #( FOR turn = 1 UNTIL turn > 100
                      ( get_turn_output( turn ) ) ).

    cl_demo_output=>display( output ).
  ENDMETHOD.
```

## Solution 8
```abap
  METHOD fizzbuzz_8.
    DATA(output) = REDUCE string( INIT out = ||
                                  FOR turn = 1 UNTIL turn > 100
                                  NEXT out = |{ out }{ get_turn_output( turn ) }\n| ).

    cl_demo_output=>display( output ).
  ENDMETHOD.
```
