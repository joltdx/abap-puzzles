"! <p class="shorttext synchronized" lang="en">ABAP Puzzles: FizzBuzz</p>
"! <p>Fizz Buzz is alledgedly originally a childrens game to practice division, with some simple rules.<br>
"! The first player starts by saying the number 1 and players then take turn counting upwards one number at a time, but:
"! <ul><li>If a number is evenly divisable by 3, the player instead says 'Fuzz'</li>
"! <li>If a number is evenly divisable by 5, the player instead says 'Buzz'</li>
"! <li>If a number is evenly divisable by both 3 and 5, the player says 'FizzBuzz'</li></ul>
"! So, it would start like this:
"! 1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, Fizz Buzz, 16, 17, Fizz, 19, Buzz, Fizz, 22, 23, Fizz
"! </p>
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
    "! <li>Both division by 3 and division by 5 is checked again and <em>this_turn_output</em> will be
    "! set to 'FizzBuzz'.
    "! </ol>
    "! <h1>ABAP Language Used</h1>
    "! <h2>DO</h2>
    "! <p>The DO 100 Times statment performs the statements inside the block (down until the ENDDO statement)
    "! 100 times.<br>
    "! The system variable <em>sy-index</em> is set to the number of the current loop pass, so we use that to
    "! count from 1 to 100.</p>
    "! <h2>IF</h2>
    "! Conditional control structure
    "! <h2>MOD</h2>
    "! <p>MOD is an arithmetic operator that gives us the remainder of a division. If the remainder is 0, then
    "! the division between the left operand by the right was even</p>
    "! <h2>String templates</h2>
    "! <p>The string template &#124;&#123; output &#125;\n&#123; this_turn_output &#125;&#124; is adding a
    "! newline \n and the <em>this_turn_output</em> to the total output variable</p>
    "! <h2>cl_demo_output</h2>
    "! <p>The demo class cl_demo_output is used to display the output result in a convenient window.<br>
    "! This is, I believe, the most convenient way to have the differnt demo solutions easily run and output
    "! data on an on-premise SAP system.</p>
    METHODS fizzbuzz_1.

    "! <p class="shorttext synchronized" lang="en">Solution 2</p>
    "! <p>Compared to {@link zcl_puzzle_fizzbuzz.METH:fizzbuzz_1}, this solution only checks each condition once.<br>
    "! Also, the check for even division by both 3 and 5 is replaced by a check for their lowest common
    "! denominator 15.<br>
    "! By using IF, ELSEIF and ENDIF, as soon as one of the conditions are met, no other calculations of checks
    "! are made. This also required us to switch the order of the checks to the opposite of the first solution.
    METHODS fizzbuzz_2.

    "! <p class="shorttext synchronized" lang="en">Solution 3</p>
    "! <p>Here's another way of solving this and lowering the number of comparisons.<br>
    "! <ol>
    "! <li>We start each pass in the DO block by clearing the <em>this_turn_output</em> variable.</li>
    "! <li>Next we check if the number is evenly divisible by 3 and set <em>this_turn_output</em> to 'Fizz' if so.</li>
    "! <li>Next we check if the number is evenly divisible by 5. If it is we <strong>add</strong> the word 'Buzz' to
    "! <em>this_turn_output</em>. This means that if the number was NOT evenly divisible by three, we will have
    "! 'Buzz' now. If, however, it WAS evenly divisible by 3 we would already have 'Fizz' and then adding 'Buzz'
    "! gets us 'FizzBuzz'.</li>
    "! <li>Now instead we need a new comparison the see if we have set anything in the <em>this_turn_output</em>.
    "! If we have not, then we put the current turn number in there.
    "! </ol>
    METHODS fizzbuzz_3.

    "! <p class="shorttext synchronized" lang="en">Solution 4</p>
    "! Here we start by using DO/ENDDO to create a table containing the number 1-100.
    "! Next, we use the VALUE construcor expression to create a new table containing our total output.<br>
    "! FOR turn IN turns takes each line in the turns table (number 1-100) and puts it in the new table based
    "! according to what we specify inside.<br>
    "! The COND conditional expression is determining the new line content based on the current number and the
    "! calculations. This is basically comparable to the IF/ELSEIF/ELSEIF/ELSE we used in
    "! {@link zcl_puzzle_fizzbuzz.METH:fizzbuzz_2}
    "! <h1>Additional ABAP language used</h1>
    "! <h2>VALUE</h2>
    "! The VALUE operator is a constructor extpression that can create structures or tables
    "! <h2>COND</h2>
    "! A conditional expression with a result based on a logic expression
    METHODS fizzbuzz_4.

    "! <p class="shorttext synchronized" lang="en">Solution 5</p>
    "! Let's move the whole COND expression into a method of its own called get_turn_output, taking the turn number
    "! as input and returning the desired output for that turn.<br>
    "! We call that method in the VALUE expression instead of the COND itself.
    METHODS fizzbuzz_5.

    "! <p class="shorttext synchronized" lang="en">Solution 6</p>
    "! Haha, well, in this solution there is again the DO/ENDDO creating a table containing the numbers 1-100 but
    "! in the format of strings.
    "! Next, to set the Fizz, Buzz and FizzBuzz where relevant, we take a backwards approach and determine beforehand
    "! which turns should be changed.<br>
    "! Starting with FizzBuzz we create a range of the values to be replaced by 'FizzBuzz'. This is every fiftenth
    "! number. Use of the MODIFY statement will then change the contents of those lines to 'FizzBuzz'.<br>
    "! We clear that range and then fill it with every fifth number, and replace those lines with 'Buzz'.<br>
    "! And finally we repeat this once more, replacing every third number with 'Fizz'.<br><br>
    "! The order is important here, if we start by replacing every third number, these will no longer be found as
    "! matches when comparing for every 15th number, as they will say 'Fizz' instead.
    "! <h1>Additional ABAP language used</h1>
    "! <h2>INSERT</h2>
    "! Used here to insert lines into an internal table
    "! <h2>MODIFY</h2>
    "! Modifying lines of the internal table
    METHODS fizzbuzz_6.

    "! <p class="shorttext synchronized" lang="en">Solution 7</p>
    "! In {@link zcl_puzzle_fizzbuzz.METH:fizzbuzz_4} we used DO/ENDDO to first create a table with the numbers 1-100
    "! and then use the VALUE operator. It is possible to do the same kind of solution, without that table, like in
    "! this solution.<br>
    "! We use the FOR/UNTIL instead of the FOR/IN here and the iteration expression will count up from 1 to 100 for
    "! us here, as specified.
    METHODS fizzbuzz_7.

    "! <p class="shorttext synchronized" lang="en">Solution 8</p>
    "! Compared to {@link zcl_puzzle_fizzbuzz.METH:fizzbuzz_7} where the VALUE operator created a table with the
    "! turns, here we use the REDUCE operator to create a string instead.<br>.
    "! In INIT, we initialize our output variable, the FOR specifies which cases to iterate, and NEXT is adding the
    "! output for the current turn to the total output, using the same COND as we've used before.
    "! <h1>Additional ABAP language used</h1>
    "! <h2>REDUCE</h2>
    "! The reduction operator REDUCE here helps us convert the table into a single result in form of a string
    METHODS fizzbuzz_8.

  PROTECTED SECTION.

  PRIVATE SECTION.
    METHODS get_turn_output
      IMPORTING
        turn          TYPE i
      RETURNING
        VALUE(result) TYPE string.
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

  METHOD fizzbuzz_7.
    DATA output TYPE STANDARD TABLE OF string WITH EMPTY KEY.

    output = VALUE #( FOR turn = 1 UNTIL turn > 100
                      ( get_turn_output( turn ) ) ).

    cl_demo_output=>display( output ).
  ENDMETHOD.

  METHOD fizzbuzz_8.
    DATA(output) = REDUCE string( INIT out = ||
                                  FOR turn = 1 UNTIL turn > 100
                                  NEXT out = |{ out }{ get_turn_output( turn ) }\n| ).

    cl_demo_output=>display( output ).
  ENDMETHOD.

  METHOD get_turn_output.
    result = COND #( WHEN turn MOD 15 = 0 THEN |FizzBuzz|
                     WHEN turn MOD 5 = 0 THEN |Buzz|
                     WHEN turn MOD 3 = 0 THEN |Fizz|
                     ELSE turn ).
  ENDMETHOD.

ENDCLASS.
