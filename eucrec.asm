# Euclidean Recursive
# Michael Dank
# 10/2011

		.text
	.globl  main
main:
	sub	$sp,$sp,12	# push stack
	sw	$ra,4($sp)	# save return address

	li	$v0,4       # Ready for string output
	la	$a0,pow     # Load address of pow
	syscall         # Print string
	
	li $v0,5        # Ready for integer input
	syscall         # Read integer from console
	move $t2,$v0    # Move into to $t2 temporarily
		
	li	$v0,4       # Ready for string output
	la	$a0,bas     # Load address of bas
	syscall         # Print string
	
	li $v0,5        # Ready for integer input
	syscall         # Read integer from console
	move $a0,$t2    # Move into to $a0
	move $a1,$v0    # Move power integer to $a1
	
	jal euc
	sw	$v0,8($sp)

# print the result
	
	li	$v0,4
	la	$a0,str
	syscall

	li	$v0,1
	lw	$a0,8($sp)
	syscall
	
	lw	$ra,4($sp)	# restore return address
	add	$sp,$sp,12	# pop stack
	jr	$ra

	.data
str:                    # label of address containing a string
	.asciiz "value = "  # Assembly directive used to create a null terminated ASCII string
bas:                    # label of address containing a string
	.asciiz "second integer = "  # Assembly directive used to create a null terminated ASCII string
pow:                    # label of address containing a string
	.asciiz "first integer = "  # Assembly directive used to create a null terminated ASCII string
	
	.text
euc:
	sub	$sp,$sp,8	# push stack
	sw	$ra,4($sp)	# save return address

	bne $a1, $zero, L1 # if b!=0 then exit
	add	$v0,$zero,$a0	# return a0
	add	$sp,$sp,8	# pop stack
	jr	$ra		# return to calling procedure
L1:
	move $t4,$a1         # set up c = b
	rem $a1,$a0,$a1      # b = a % b
	move $a0,$t4         # a = c
	jal euc            # recurse

	lw	$ra,4($sp)	# restore previous return addr
	move $v0,$a0    # Move a to $v0

	add	$sp,$sp,8	# pop stack
	jr	$ra		# return to calling procedure
