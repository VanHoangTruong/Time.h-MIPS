.data
	s: .asciiz "2013\n"
	newLine: .asciiz "\n"
.text

	main:
		li $a0, 2013
		jal isLeapYear
		move $a0, $v1
		li $v0, 1
		syscall
		li $v0, 4
		la $a0, newLine
		syscall
		la $a0, s
		jal length
		move $a0, $v1
		li $v0, 1
		syscall
		li $v0, 4
		la $a0, newLine
		syscall
		la $a0, s
		jal convertStringToInt
		move $a0, $v1
		li $v0, 1
		syscall
	end_prog:
		li $v0, 10
		syscall
	isLeapYear:
		addi $sp, $sp, -8
		sw $ra, 0($sp)
		sw $t0, 4($sp)
	
		li $t0, 4
		div $a0, $t0
		mfhi $t0
		bne $t0, $0, isLeapYear_else # if (input % 4 != 0) jump to else
		li $t0, 100
		div $a0, $t0
		mfhi $t0
		beq $t0, $0, isLeapYear_end # if (input % 100 == 0) jump to end retrun 0
		li $v1, 1 # return 1
		j isLeapYear_end_func
		isLeapYear_else:
			li $t0, 400
			div $a0, $t0
			mfhi $t0
			bne $t0, $0, isLeapYear_end # if (input % 400 != 0) jump to end return 0
			li $v1, 1 # return 1
			j isLeapYear_end_func
		isLeapYear_end:
			li $v1, 0 # return 0
		isLeapYear_end_func:
		lw $ra, 0($sp)
		lw $t0, 4($sp)
		addi $sp, $sp, 8
		jr $ra
	# a0: input: char*
	convertStringToInt:
		addi $sp, $sp, -24
		sw $ra, 0($sp)
		sw $a0, 4($sp)
		sw $t0, 8($sp)
		sw $t1, 12($sp)
		sw $t2, 16($sp)
		sw $t3, 20($sp)
		
		
		addi $t0, $0, 0 # i
		jal length # arg is $a0
		move $t1, $v1 # length of char *
		li $t1, 4
		addi $v1, $0, 0 # res
		convertStringToInt_while:
			beq $t0, $t1, convertStringToInt_end_while # if (i == len) end_while
			lb $t2, 0($a0)
			blt $t2, '0', convertStringToInt_return_m1
			bgt $t2, '9', convertStringToInt_return_m1
			mul $v1, $v1, 10
			addi $t2, $t2, -48 # -'0'
			add $v1, $v1, $t2
			addi $t0, $t0, 1
			addi $a0, $a0, 1
			j convertStringToInt_while
		convertStringToInt_end_while:
			j convertStringToInt_end_func
		convertStringToInt_return_m1:
			li $v1, -1
		convertStringToInt_end_func:
		lw $ra, 0($sp)
		lw $a0, 4($sp)
		lw $t0, 8($sp)
		lw $t1, 12($sp)
		lw $t2, 16($sp)
		lw $t3, 20($sp)
		addi $sp, $sp, 24
		jr $ra
	length:
		addi $sp, $sp, -12
		sw $ra, 0($sp)
		sw $t0, 4($sp)
		sw $a0, 8($sp)
		
		addi $v1, $0, 0
		length_while:
			lb $t0, 0($a0)
			beq $t0, '\n', length_end_while
			beq $t0, '\0', length_end_while
			addi $a0, $a0, 1
			addi $v1, $v1, 1
			j length_while
		length_end_while:
		length_end_func:
		lw $ra, 0($sp)
		lw $t0, 4($sp)
		lw $a0, 8($sp)
		addi $sp, $sp, 12
		jr $ra
