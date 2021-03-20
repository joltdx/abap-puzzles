# Narcissistic numbers
In number theory, a narcissistic number is a number where the sum of each of its digits raised to the power of the total number of digits equals the number itself.\
This is the case for instance for the number 153. It has 3 digits, so when each digit is raised to the power 3, then the sum equals 153.\
1^3 + 5^3 + 3^3 = 1 + 125 + 27 = 153\
\
Narcissistic number are also known as Armstrong numbers or plus perfect numbers

## As a programming puzzle
Implement a program that lists all narcissistic numbers with 5 or less digits, i.e. between 0 and 99999.\
These are, for reference 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 153, 370, 371, 407, 1634, 8208, 9474, 54748, 92727 and 93084\
\
Solution examples are in class [src/zcl_puzzle_narcissistic_number.clas.abap](src/zcl_puzzle_narcissistic_number.clas.abap)


# Solution 1
```abap
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
```
This solution is using the data only as integers and using arithmetic operators to do the calculations.\
\
The first thing is to count the number of digits by counting how many times the number can be divided by 10 and still have value left in the integer part.\
\
Next, the same procedure is used again, but this time also keeping track of the remainder of the division by 10, which will give us one digit at a time.\
This digit is raised to the number of digits found before, and added to a total sum


# Solution 2
```abap
  METHOD get_sum_of_powers_2.
    DATA offset TYPE i.

    DATA(number_as_string) = |{ number }|.
    DATA(number_of_digits) = strlen( number_as_string ).

    DO number_of_digits TIMES.
      offset = sy-index - 1.
      result = result + ( number_as_string+offset(1) ** number_of_digits ).
    ENDDO.
  ENDMETHOD.
```
This approach is using both explicit and automatic type conversions in ABAP to be able to use the number in character format, and therefore
be able to split and choose in a simple way, and back to number format to perform calculations with the parts.

By first using a string template to have the number as a string, we can use the length of the string to know the number of digits in the number.

We then read the string character by character by using string offset and length, and rely on the automatic type conversion to be able to
perform the necessary calculations.


# Solution 3
```abap
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
```
This solution uses an integer table as a basis.

We use division by 10 here and using the modulo, the remainder, as the digit to put in a table and then keeping the integer part of the division for a next round.
While there is still value in the integer part, there are still digits, and we keep going.

When done, we have the number of lines in the table as the number of digits in the number, and we can loop the table to calculate each digits power and add to a total sum
