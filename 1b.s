# Write a MIPS assembly function that implements your code
# from the previeous part, but does not make any recursive
# calls.

# uint32_t _decaying_sum_tr(uint32_t res, uint16_t* values, uint16_t length, uint16_t decay) {
#     if(length <= 0) return res;
#     return _decaying_sum_tr(res + (values[0] / decay), &values[1], length - 1, decay * decay);
# }
# uint32_t decaying_sum_tr(uint16_t* values, uint16_t length, uint16_t decay) {
#     return _decaying_sum_tr(values[0], &values[1], length - 1, decay);
# }

# test data
.data
values: .half 1, 5, 8, 3
length: .word 4
decay: .word 2

.text
.globl main
main:

# test (load data into args)
la $a0, values
lw $a1, length
lw $a2, decay

# call function
jal decaying_sum

# print result
move $a0, $v0
li $v0, 1
syscall

# exit
li $v0, 10
syscall

# the function in assembly:

decaying_sum: # a0: values, a1: length, a2: decay; v0: result
lh $v0, 0($a0)
addi $a0, $a0, 2
j dc_Cond

dc_Loop:
lh $t0, 0($a0)		# load value
div $t0, $a2		# divide by decay
mflo $t0			# move result to t0
add $v0, $v0, $t0	# add to result
addi $a1, $a1, -1	# $a1 = $a1 - 1
addi $a0, $a0, 2	# $a0 = $a0 + 2
mult $a2, $a2		# $a2 * $a2 = Hi and Lo registers
mflo $a2			# copy Lo to $a2

dc_Cond:
bgt		$a1, 1, dc_Loop	# if $a1 > 1 then dc_Loop

jr $ra