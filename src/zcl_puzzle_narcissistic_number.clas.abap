"! <p class="shorttext synchronized" lang="en">ABAP Puzzles: Narcissistic numbers (Armstrong numbers)</p>
"!
"! <p>In number theory, a narcissistic number is a number that where the sum of each of its digits raised to the power
"! of the total number of digits, equals the number itself.<br>
"! This is the case for instance for the number 153. It has 3 digits, so when each digit is raised to the power 3,
"! then the sum equals 153.<br>
"! 1^3 + 5^3 + 3^3 = 1 + 125 + 27 = 153<br>
"! <br>
"! Narcissistic number are also known as Armstrong numbers or plus perfect numbers</p>
"! <h1>As a programming puzzle</h1>
"! <p>Implement a program that lists all narcissistic numbers with 5 or less digits, i.e. between 0 and 99999.
"! These are, for reference 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 153, 370, 371, 407, 1634, 8208, 9474, 54748, 92727 and
"! 93084<br>
"! <br>
"! Have fun!</p>
CLASS zcl_puzzle_narcissistic_number DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    "! <p class="shorttext synchronized" lang="en">Solution 1</p>
    "! <p>The solution tests all the numbers, in order, from 0 to 99999 to find the valid narcissistic numbers with
    "! the data only as integers and using arithmetic operators to do the calculations<br>
    "! <br>
    "! The first thing is to count the number of digits, by counting how many times the number can be divided by
    "! 10 and still have value left in the integer part.<br>
    "! <br>
    "! Next, the same procedure is used again, this time also keeping track of the remainder of the division by 10
    "! which will give us one digit at a time. This is raised to the number of digits found before, and added to a
    "! total sum</p>
    METHODS solution_1.
    "! <p class="shorttext synchronized" lang="en">Solution 2</p>
    "! <p>The solution test all the numbers, in order, from 0 to 99999 to find the valid narcissistic number by using
    "! both explicit and automatic type conversions in ABAP to be able to use the number in character format, to be
    "! able to split and choose in a simple way, and back to number format to perform calculations with the parts.<br>
    "! <br>
    "! By first using a string template to have the number as a string, we can use the length of the string to know
    "! the number of digits in the number.<br>
    "! <br>
    "! We then read the string character by character by using string offset and length, and rely on the automatic
    "! type conversion to be able to perform the necessary calculations.</p>
    METHODS solution_2.
    "! <p class="shorttext synchronized" lang="en">Solution 3</p>
    "! <p>The solution tests all the numbers, in order, from 0 to 99999 to find the valid narcissistic number with
    "! the data as integers in an internal table.<br>
    "! <br>
    "! We use division by 10 here and using the modulo, the remainder, as the digit to put in a table and then
    "! keeping the integer part of the division for a next round. While there is still value in the integer part,
    "! there are still digits, and we keep going.<br>
    "! <br>
    "! When done, we have the number of lines in the table as the number of digits in the number, and we can loop the
    "! table to calculate each digits power and add to a total sum
    METHODS solution_3.
    METHODS solution_4.
    METHODS solution_5.
    METHODS solution_6.
    METHODS solution_7.
  PROTECTED SECTION.
  PRIVATE SECTION.
    METHODS get_sum_of_powers_1
      IMPORTING
        number        TYPE i
      RETURNING
        VALUE(result) TYPE i.
    METHODS get_sum_of_powers_2
      IMPORTING
        number        TYPE i
      RETURNING
        VALUE(result) TYPE i.
    METHODS get_sum_of_powers_3
      IMPORTING
        number        TYPE i
      RETURNING
        VALUE(result) TYPE i.
    METHODS get_sum_of_powers_4
      IMPORTING
        i_num           TYPE i
      RETURNING
        value(r_result) TYPE i.
    METHODS get_sum_of_powers_5
      IMPORTING
        i_num           TYPE i
      RETURNING
        value(r_result) TYPE i.
    METHODS get_sum_of_powers_6
      IMPORTING
        i_num           TYPE i
      RETURNING
        value(r_result) TYPE i.
    METHODS get_sum_of_powers_7
      IMPORTING
        i_num           TYPE i
      RETURNING
        value(r_result) TYPE i.
ENDCLASS.

CLASS zcl_puzzle_narcissistic_number IMPLEMENTATION.

  METHOD solution_1.
    DATA output TYPE string.
    DATA number type i.

    DO 100000 TIMES.
      number = sy-index - 1.
      IF get_sum_of_powers_1( number ) = number.
        output = |{ output }{ number }\n|.
      ENDIF.
    ENDDO.

    cl_demo_output=>display( output ).
  ENDMETHOD.

  METHOD solution_2.
    DATA output TYPE string.
    DATA number type i.

    DO 100000 TIMES.
      number = sy-index - 1.
      IF get_sum_of_powers_2( number ) = number.
        output = |{ output }{ number }\n|.
      ENDIF.
    ENDDO.

    cl_demo_output=>display( output ).
  ENDMETHOD.

  METHOD solution_3.
    DATA output TYPE string.
    DATA number type i.

    DO 100000 TIMES.
      number = sy-index - 1.
      IF get_sum_of_powers_3( number ) = number.
        output = |{ output }{ number }\n|.
      ENDIF.
    ENDDO.

    cl_demo_output=>display( output ).
  ENDMETHOD.

  METHOD solution_4.
    DATA output TYPE string.
    DATA number type i.

    DO 100000 TIMES.
      number = sy-index - 1.
      IF get_sum_of_powers_4( number ) = number.
        output = |{ output }{ number }\n|.
      ENDIF.
    ENDDO.

    cl_demo_output=>display( output ).
  ENDMETHOD.

  METHOD solution_5.
    DATA output TYPE string.
    DATA number type i.

    DO 100000 TIMES.
      number = sy-index - 1.
      IF get_sum_of_powers_5( number ) = number.
        output = |{ output }{ number }\n|.
      ENDIF.
    ENDDO.

    cl_demo_output=>display( output ).
  ENDMETHOD.

  METHOD solution_6.
    DATA output TYPE string.
    DATA number type i.

    DO 100000 TIMES.
      number = sy-index - 1.
      IF get_sum_of_powers_6( number ) = number.
        output = |{ output }{ number }\n|.
      ENDIF.
    ENDDO.

    cl_demo_output=>display( output ).
  ENDMETHOD.

  METHOD solution_7.
    DATA output TYPE string.
    DATA number type i.

    DO 100000 TIMES.
      number = sy-index - 1.
      IF get_sum_of_powers_7( number ) = number.
        output = |{ output }{ number }\n|.
      ENDIF.
    ENDDO.

    cl_demo_output=>display( output ).
  ENDMETHOD.

  METHOD get_sum_of_powers_1.
    DATA number_of_digits TYPE i.
    DATA rest TYPE i.
    DATA remainder TYPE i.

    number_of_digits = 1.
    rest = number DIV 10.
    WHILE rest > 0.
      number_of_digits = number_of_digits + 1.
      rest = rest DIV 10.
    ENDWHILE.

    remainder = number MOD 10.
    rest = number.
    WHILE rest > 0.
      remainder = rest MOD 10.
      rest = rest DIV 10.
      result = result + ( remainder ** number_of_digits ).
    ENDWHILE.
  ENDMETHOD.

  METHOD get_sum_of_powers_2.
    DATA offset TYPE i.

    DATA(number_as_string) = |{ number }|.
    DATA(number_of_digits) = strlen( number_as_string ).

    DO number_of_digits TIMES.
      offset = sy-index - 1.
      result = result + ( number_as_string+offset(1) ** number_of_digits ).
    ENDDO.
  ENDMETHOD.

  METHOD get_sum_of_powers_3.
    DATA rest TYPE i.
    DATA digits TYPE STANDARD TABLE OF i WITH EMPTY KEY.

    rest = number.
    DO.
      INSERT rest MOD 10 INTO TABLE digits.
      rest = rest DIV 10.
      IF rest = 0.
        EXIT.
      ENDIF.
    ENDDO.

    DATA(number_of_digits) = lines( digits ).
    LOOP AT digits INTO DATA(digit).
      result = result + ( digit ** number_of_digits ).
    ENDLOOP.
  ENDMETHOD.

  METHOD get_sum_of_powers_4.

    ASSERT i_num GE 0.

    DATA(string) = condense( CONV string( i_num ) ).

    DATA(strl) = strlen( string ).

    DO strl TIMES.

      DATA(id) = sy-index - 1.

      r_result += ( string+id(1) ) ** strl.

    ENDDO.

  ENDMETHOD.

  METHOD get_sum_of_powers_5.

    ASSERT i_num GE 0.

    DATA(string) = condense( CONV string( i_num ) ).

    DATA(strl) = strlen( string ).



    r_result = REDUCE i(
      INIT ret = 0
      FOR i = 0 WHILE i < strl
      NEXT ret += ( string+i(1) ) ** strl
    ).

  ENDMETHOD.

  METHOD get_sum_of_powers_6.

    ASSERT i_num GE 0.

    r_result = REDUCE i(
      LET string = condense( CONV string( i_num ) )
          strl = strlen( string )
      IN INIT ret = 0
      FOR i = 0 WHILE i < strl
      NEXT ret += ( string+i(1) ) ** strl
    ).

  ENDMETHOD.

  METHOD get_sum_of_powers_7.

    ASSERT i_num GE 0.

    RETURN REDUCE i(
      LET string = condense( CONV string( i_num ) )
          strl = strlen( string )
      IN INIT ret = 0
      FOR i = 0 WHILE i < strl
      NEXT ret += ( string+i(1) ) ** strl
    ).

  ENDMETHOD.

ENDCLASS.
