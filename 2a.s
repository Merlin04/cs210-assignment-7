# function that takes as input two 32 bit integers and
# returns their product.

.data
arg_a: .word 380
arg_b: .word 423

.text
.globl main
main:

# load test data into a0,1
lw $a0, arg_a
lw $a1, arg_b
jal prod

# print result
move $a0, $v0
li $v0, 1
syscall

# exit
li $v0, 10
syscall

prod:
mult	$a0, $a1			# $a0 * $a1 = Hi and Lo registers
mflo	$v0					# copy Lo to $v0
mfhi	$v1					# copy Hi to $v1
jr $ra