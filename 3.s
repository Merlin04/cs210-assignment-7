# Write a MIPS assembly function that takes as input a
# pointer to a list of 10 characters and an enum representing
# the days of the week. The function should set the list to
# contain the word corresponding to that day of the week
# following C string guidelines. Assume that the enum is
# numbered from 0 to 6, starting on Sunday and ending on
# Saturday. The function should return whether the value
# passed was a valid enum value. For full credit, your
# function should use a jump table.

.data
d1: .asciiz "Sunday"
d2: .asciiz "Monday"
d3: .asciiz "Tuesday"
d4: .asciiz "Wednesday"
d5: .asciiz "Thursday"
d6: .asciiz "Friday"
d7: .asciiz "Saturday"
jt: .word d1, d2, d3, d4, d5, d6, d7

# test
out: .space 10
num: .word 3

.text
.globl main
main:
la $a0, out
lw $a1, num
jal set_day_str

# print result
la $a0, out
li $v0, 4
syscall

# exit
move $a0, $v0
li $v0, 17 # exit with code
syscall

set_day_str: # $a0: dest, $a1: day
bgt $a1, 6, sds_invalid
blt $a1, 0, sds_invalid
la $t0, jt
sll $t1, $a1, 2
add $t0, $t0, $t1
lw $t0, 0($t0)
# now copy into the array
j sds_cond
sds_loop:
sb $t1, 0($a0)
addi $a0, $a0, 1
addi $t0, $t0, 1

sds_cond:
lb $t1, 0($t0)
bne $t1, $zero, sds_loop

li $v0, 1
jr $ra

sds_invalid:
li $v0, 0
jr $ra
