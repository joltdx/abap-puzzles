"! <p class="shorttext synchronized" lang="en">ABAP Puzzles: FizzBuzz</p>
"! <p>Fizz Buzz is alledgedly originally a childrens game to practice division, with some simple rules.<br>
"! The first player starts by saying the number 1 and players then take turn counting upwards one number at a time, but:
"! <ul><li>If a number is evenly divisable by 3, the player instead says 'Fuzz'</li>
"! <li>If a number is evenly divisable by 5, the player instead says 'Buzz'</li>
"! <li>If a number is evenly divisable by both 3 and five, the player says 'Fizz Buzz'</li></ul>
"! So, it would start like this:
"! 1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, Fizz Buzz, 16, 17, Fizz, 19, Buzz, Fizz, 22, 23, Fizz</p>
"! <h1>As a programming puzzle</h1>
"! <p>Implementing this in programming as 'Output the first 100 rounds of the FizzBuzz game' is a common
"! programming puzzle so let's look at a couple of solutions in ABAP</p>
CLASS zcl_puzzle_fizzbuzz DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    "! <p class="shorttext synchronized" lang="en">Solution 1</p>
    "! <p>This solution is the most basic, simple and straigt-forward solution I could think of.<br>
    "! We build up the overall result in the <em>output</em> variable by determining the
    "! <em>this_turn_output</em> variable inside the DO 100 TIMES/ENDDO block.<br>
    "! For each turn performs these operations:
    "! <ol>
    "! <li>Set <em>this_turn_output</em> to the current iteration number from the DO statement.
    "! This is given to us from the system variable <em>sy-index</em>.</li>
    "! <li>Check if the current turn number is evenly divisible by three and, if so,
    "! change <em>this_turn_output</em> to 'Fizz'.</li>
    "! <li>Check if the current turn number is evenly divisible by five and, if so,
    "! change <em>this_turn_output</em> to 'Buzz'.</li>
    "! <li>Check if the current turn number is evenly divisible by both three and five and, if so,
    "! change <em>this_turn_output</em> to 'FizzBuzz'.</li>
    "! <li>Add <em>this_turn_output</em> to the total <em>output</em>
    "! </ol>
    "! </p>
    "! <p>This approach is not very optimized as it always checks all the conditions and divisions.<br>
    "! This is especially apparent for numbers that are evenly divisible by both 3 and 5. Example for number 15:
    "! <ol>
    "! <li><em>this_turn_output</em> will be set to 15.</li>
    "! <li>Division by 3 is checked and <em>this_turn_output</em> will be changed to 'Fizz'.
    "! <li>Division by 5 is checked and <em>this_turn_output</em> will be changed to 'Buzz'.
    "! <li>Both division by 3 and division by 5 is checked again and <em>this_turn_output</em> will be set to 'FizzBuzz'.
    "! </ol>
    "! <h1>ABAP Language Used</h1>
    "! <h2>DO</h2>
    "! <p>The DO 100 Times statment performs the statements inside the block (down until the ENDDO statement) 100 times.<br>
    "! The system variable <em>sy-index</em> is set to the number of the current loop pass, so we use that to count from 1 to 100.</p>
    "! <h2>MOD</h2>
    "! <p>MOD is an arithmetic operator that gives us the remainder of a division. If the remainder is 0, then
    "! the division between the left operand by the right was even</p>
    "! <h2>String templates</h2>
    "! <p>The string template &#124;&#123; output &#125;\n&#123; this_turn_output &#125;&#124; is adding a
    "! newline \n and the <em>this_turn_output</em> to the total output variable</p>
    "! <h2>cl_demo_output</h2>
    "! <p>The demo class cl_demo_output is used to display the output result in a convenient window.</p>
    METHODS fizzbuzz_1.

    "! <p class="shorttext synchronized" lang="en">Solution 2</p>
    "! <p>Compared to {@link zcl_puzzle_fizzbuzz.METH:fizzbuzz_1}, this solution only checks each condition once.<br>
    "! Also, the check for even division by both 3 and 5 is replaced by a check for their lowest common denominator 15.<br>
    "! By using IF, ELSEIF and ENDIF, as soon as one of the conditions are met, no other calculations of checks are made.
    "! This also required us to switch the order of the checks to the opposite of the first solution.
    METHODS fizzbuzz_2.

    "! <p class="shorttext synchronized" lang="en">Solution 3</p>
    "! <p>Here's another way of solving this and lowering the number of comparisons.<br>
    "! <ol>
    "! <li>We start each pass in the DO block by clearing the <em>this_turn_output</em> variable.</li>
    "! <li>Next we check if the number is evenly divisible by 3 and set <em>this_turn_output</em> to 'Fizz' if so.</li>
    "! <li>Next we check if the number is evenly divisible by 5. If it is we <strong>add</strong> the word 'Buzz' to
    "! <em>this_turn_output</em>. This means that if the number was NOT evenly divisible by three, we will have 'Buzz' now.
    "! If, however, it WAS evenly divisible by 3 we would already have 'Fizz' and then adding 'Buzz' gets us 'FizzBuzz'.</li>
    "! <li>Now instead we need a new comparison the see if we have set anything in the <em>this_turn_output</em>. If we have
    "! not, then we put the current turn number in there.
    "! </ol>
    METHODS fizzbuzz_3.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_puzzle_fizzbuzz IMPLEMENTATION.

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

ENDCLASS.
