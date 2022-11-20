# Write a MIPS assembly function that takes as input pointers
# to two lists of 32 bit integers, a pointer to a list of 64
# bit integers, and the length of those lists, which is
# assumed to be the same. (All lists have the same length.)
# Each element in the third list should be set to the product
# of the corresponding elements in the first two lists. In
# code form, this means:
# for(int i = 0; i < length; i++) {
#     array3[i] = array1[i] * array2[i];
# }
# For full credit, use your function from the previous part.

.data
# strings for printing arrays
sep: .asciiz ", "
newline: .asciiz "\n"

array1: .word 1, 2, 3, 4, 5, 6, 7, 8, 9, 10
array2: .word 2, 3, 4, 5, 6, 7, 8, 9, 10, 11
array3: .space 40
length: .word 10

.text
.globl main
main:
# load into args
la $s0, array1
la $s1, array2
la $s2, array3
lw $s3, length

move $a0, $s0
move $a1, $s1
move $a2, $s2
move $a3, $s3
jal arr_prod

move $a0, $s2
li $t0, 2
mult $s3, $t0
mflo $a1
jal print_array

# exit
li $v0, 10
syscall

arr_prod: # array1, array2, array3, length
addiu $sp, $sp, -32
sw $ra, 28($sp)
sw $fp, 24($sp)
addiu $fp, $sp, 32
# need to save $s0, $s1, $s2, $s3
sw $s0, 20($sp)
sw $s1, 16($sp)
sw $s2, 12($sp)
sw $s3, 8($sp)

move $s0, $a0
move $s1, $a1
move $s2, $a2
move $s3, $a3

j ap_cond
ap_loop:
lw $a0, 0($s0)
lw $a1, 0($s1)
jal prod
sw $v1, 0($s2)
sw $v0, 4($s2)
addiu $s0, $s0, 4
addiu $s1, $s1, 4
addiu $s2, $s2, 8
addi $s3, $s3, -1

ap_cond:
bge $s3, 0, ap_loop

# restore $s0, $s1, $s2, $s3
lw $s0, 20($sp)
lw $s1, 16($sp)
lw $s2, 12($sp)
lw $s3, 8($sp)
lw $fp, 24($sp)
lw $ra, 28($sp)
addiu $sp, $sp, 32
jr $ra


prod:
mult	$a0, $a1			# $a0 * $a1 = Hi and Lo registers
mflo	$v0					# copy Lo to $v0
mfhi	$v1					# copy Hi to $v1
jr $ra


# test function (from last homework, copied in to print array)
print_array: # put arr in $t0, length in $t1
# li		$t4, 1			# $t4 = 1
# sub		$t4, $t1, $t4		# $t4 = $t1 - 1
move $t0 $a0
move $t1 $a1
addi	$t4, $t1, -1			# $t4 = $t1 + -1
li		$t2, 0		# $t2 = 0
bge		$t2, $t1, PAExit	# if $t2 >= $t1 then PAExit

PALoop:
# load array[i] into $t4
sll		$t3, $t2, 2			# $t3 = $t2 << 2
add		$t3, $t3, $t0		# $t3 = $t3 + $t0
lw		$a0, 0($t3)		#

li		$v0, 1		# $v0 = 1
syscall # print

beq     $t2, $t4, PAExit	# if $t2 == $t4 then PAExit
li		$v0, 4		# $v0 = 4
la		$a0, sep		# $a0 = space
syscall # print

addi	$t2, $t2, 1			# $t2 = $t2 + 1
j		PALoop				# jump to PALoop

PAExit:
li		$v0, 4		# $v0 = 4
la		$a0, newline		# $a0 = newline
syscall # print
jr		$ra					# return
