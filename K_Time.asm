.data
	s: .asciiz "2013\n"
	newLine: .asciiz "\n"
	stringDate: .ascii ""
.text

	main:
		# test isLeapYear
		li $a0, 2013
		jal isLeapYear
		move $a0, $v1
		li $v0, 1
		syscall
		li $v0, 4
		la $a0, newLine
		syscall
		# test get length of string
		la $a0, s
		jal length
		move $a0, $v1
		li $v0, 1
		syscall
		li $v0, 4
		la $a0, newLine
		syscall
		# test convertStringToInt
		la $a0, s
		jal convertStringToInt
		move $a0, $v1
		li $v0, 1
		syscall
		li $v0, 4
		la $a0, newLine
		syscall
		# test convert to Date
		li $a0, 30
		li $a1, 1
		li $a2, 2018
		jal Date
		move $a0, $v1
		li $v0, 4
		syscall
		li $v0, 4
		la $a0, newLine
		syscall
		# test checkInputValid
		li $a0, 29
		li $a1, 2
		li $a2, 2016
		li $a3, 1
		jal checkInputValid
		move $a0, $v1
		li $v0, 1
		syscall
		
	end_prog:
		li $v0, 10
		syscall
	isLeapYear:
		addi $sp, $sp, -100
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
		addi $sp, $sp, 100
		jr $ra
	# a0: input: char*
	convertStringToInt:
		addi $sp, $sp, -100
		sw $ra, 0($sp)
		sw $a0, 4($sp)
		sw $t0, 8($sp)
		sw $t1, 12($sp)
		sw $t2, 16($sp)
		sw $t3, 20($sp)
		
		
		addi $t0, $0, 0 # i
		jal length # arg is $a0
		move $t1, $v1 # length of char *
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
		addi $sp, $sp, 100
		jr $ra
	length:
		addi $sp, $sp, -100
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
		addi $sp, $sp, 100
		jr $ra
	Date:
		addi $sp, $sp, -100
		sw $ra, 0($sp)
		sw $a0, 4($sp)
		sw $a1, 8($sp)
		sw $a2, 8($sp)
		sw $t0, 12($sp)
		
		la $v1, stringDate
		#day
		li $t0, 10
		div $a0, $t0 # day div 10 store to lo and hi
		mflo $t0 # day div 10
		addi $t0, $t0, '0'
		sb $t0, 0($v1)
		mfhi $t0
		addi $t0, $t0, '0'
		sb $t0, 1($v1)
		li $t0, '/'
		sb $t0, 2($v1)
		#month
		li $t0, 10
		div $a1, $t0 # day div 10 store to lo and hi
		mflo $t0 # day div 10
		addi $t0, $t0, '0'
		sb $t0, 3($v1)
		mfhi $t0
		addi $t0, $t0, '0'
		sb $t0, 4($v1)
		li $t0, '/'
		sb $t0, 5($v1)
		#year
		li $t0, 1000
		div $a2, $t0
		mflo $t0 #year div 1000
		addi $t0, $t0, '0'
		sb $t0, 6($v1)
		mfhi $a0 #year % 1000
		li $t0, 100
		div $a0, $t0 #(year % 1000) /100
		mflo $t0
		addi $t0, $t0, '0'
		sb $t0, 7($v1)
		li $t0, 100
		div $a2, $t0 # year div 100
		mfhi $a0 # year % 100
		li $t0, 10
		div $a0, $t0 #(year % 100) /10
		mflo $t0
		addi $t0, $t0, '0'
		sb $t0, 8($v1)
		li $t0, 10
		div $a2, $t0 # year div 10
		mfhi $t0 # year % 10
		addi $t0, $t0, '0'
		sb $t0, 9($v1)
		li $t0, '\0'
		sb $t0, 10($v1)
		Date_end_func:
		lw $ra, 0($sp)
		lw $a0, 4($sp)
		lw $a1, 8($sp)
		lw $a2, 8($sp)
		lw $t0, 12($sp)
		addi $sp, $sp, 100
		jr $ra
	checkInputValid:
		addi $sp, $sp, -100
		sw $ra, 0($sp)
		sw $a0, 4($sp)
		sw $a1, 8($sp)
		sw $a2, 8($sp)
		sw $a3, 12($sp)
		sw $t0, 16($sp)
		
		blt $a0, 1, checkInputValid_return_0
		bgt $a0, 31, checkInputValid_return_0
		blt $a1, 1, checkInputValid_return_0
		bgt $a1, 12, checkInputValid_return_0
		blt $a2, 1, checkInputValid_return_0
		blt $a3, 1, checkInputValid_return_0
		bgt $a3, 7, checkInputValid_return_0
		li $t0, 0
		beq $a1, 4, checkInputValid_check_day_greater_than_30
		beq $a1, 6, checkInputValid_check_day_greater_than_30
		beq $a1, 9, checkInputValid_check_day_greater_than_30
		beq $a1, 11, checkInputValid_check_day_greater_than_30
		j checkInputValid_next
		checkInputValid_check_day_greater_than_30:
			bgt $a0, 30, checkInputValid_return_0
		j checkInputValid_return_1
		checkInputValid_next:
		beq $a1, 2, checkInputValid_check_Feb
		checkInputValid_check_Feb:
			move $t0, $a0
			move $a0, $a2
			jal isLeapYear
			move $a0, $t0
			beq $v1, $0, checkInputValid_check_day_greater_than_28
			j checkInputValid_check_day_greater_than_29
			checkInputValid_check_day_greater_than_28:
				bgt $a0, 28, checkInputValid_return_0
				j checkInputValid_return_1
			checkInputValid_check_day_greater_than_29:
				bgt $a0, 29, checkInputValid_return_0
				j checkInputValid_return_1
		checkInputValid_return_0:
			li $v1, 0
			j checkInputValid_end_func
		checkInputValid_return_1:
			li $v1, 1
			j checkInputValid_end_func
		checkInputValid_end_func:
		lw $ra, 0($sp)
		lw $a0, 4($sp)
		lw $a1, 8($sp)
		lw $a2, 8($sp)
		lw $a3, 12($sp)
		lw $t0, 16($sp)
		addi $sp, $sp, 100
		jr $ra
