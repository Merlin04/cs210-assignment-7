# Write a MIPS assembly function that takes as input a double
# precision floating point number, a pointer to a list of
# double precision floating point numbers, and the length of
# the list. The function should add each of the values in the
# list to the input value, which should reside in $a0 and $a1
# at the end of the function. The function should return the
# exponent field (the encoding, not the value) of the
# resulting sum. The value returned should be shifted such
# that the LSB of the exponent is the LSB of the return value

.text
.globl main
main:

acc_exp: # $a0: input num, $a1: pointer, $a2: length
