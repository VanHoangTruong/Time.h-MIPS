.data
	test1: .asciiz "12/04/2018"
	test2: .asciiz "30/01/1998"
.text
main:
	
end_prog:
	addi $v0, $0, 10
	syscall
convertStringToInt:
	addi $sp, $sp, -100
	sw $ra, 0($sp)
	sw $a0, 4($sp)
	sw $a1, 8($sp)
	sw $a2, 12($sp)
	sw $a3, 16($sp)
	
	addi $v0, $0, 0 #res
	addi $t0, $0, 0 #tmp
	convertStringToInt_while:
		lb $t1, 0($a0)
		addi $t2, $0, '\n'
		beq $t1, $t2, convertStringToInt_end_func # if input[i] == '\n' break
		lb $t1, 0($a0)
		addi $t2, $0, '0'
		slt $t0, $t1, $t2 # if input[i] < '0'
		bne $t0, $0, convertStringToInt_return_m1 # retunr -1
		lb $t1, 0($a0)
		addi $t2, $0, '9'
		slt $t0, $t2, $t1 # if '9' < input[i]
		bne $t0, $0, convertStringToInt_return_m1 # return -1
		addi $t1, $0, 10
		mul $v0, $v0, $t1 # res *= 10
		lb $t1, 0($a0)
		add $v0, $v0, $t1 # res += input[i]
		addi $v0, $v0, -48 # res -= '0'
		addi $a0, $a0, 1 # i++
		j convertStringToInt_while
	convertStringToInt_return_m1:
		addi $v0, $0, -1
	convertStringToInt_end_func:
	lw $ra, 0($sp)
	lw $a0, 4($sp)
	lw $a1, 8($sp)
	lw $a2, 12($sp)
	lw $a3, 16($sp)
	addi $sp, $sp, 100
	jr $ra
isLeapYear:
	addi $sp, $sp, -100
	sw $ra, 0($sp)
	sw $a0, 4($sp)
	sw $a1, 8($sp)
	sw $a2, 12($sp)
	sw $a3, 16($sp)
	sw $t0, 20($sp)
	sw $t1, 24($sp)
	sw $t2, 28($sp)
	sw $t3, 32($sp)
	sw $t4, 36($sp)
	isLeapYear_if_input_mod_4_e_0:
		addi $t0, $0, 4
		div $a0, $t0
		mfhi $t0
		beq $t0, $0, isLeapYear_if_input_mod_100_ne_0
		j isLeapYear_if_input_mod_400_e_0
		isLeapYear_if_input_mod_100_ne_0:
			addi $t0, $0, 100
			div $a0, $t0
			mfhi $t0
			bne $t0, $0, isLeapYear_return_1
	isLeapYear_if_input_mod_400_e_0:
		addi $t0, $0, 400
		div $a0, $t0
		mfhi $t0
		beq $t0, $0, isLeapYear_return_1
		j isLeapYear_return_0
	isLeapYear_return_1:
		addi $v0, $0, 1
		j isLeapYear_end_func
	isLeapYear_return_0:
		addi $v0, $0, 0
		j isLeapYear_end_func
	isLeapYear_end_func:
	lw $ra, 0($sp)
	lw $a0, 4($sp)
	lw $a1, 8($sp)
	lw $a2, 12($sp)
	lw $a3, 16($sp)
	addi $sp, $sp, 100
	jr $ra
checkDateValid:
	addi $sp, $sp, -100
	sw $ra, 0($sp)
	sw $a0, 4($sp)
	sw $a1, 8($sp)
	sw $a2, 12($sp)
	sw $a3, 16($sp)
	
	addi $t1, $0, 1
	# if day < 1
	slt $t0, $a0, $t1
	bne $t0, $0, checkDateValid_return_0 #end_if
	# if month < 1
	slt $t0, $a1, $t1
	bne $t0, $0, checkDateValid_return_0 #end_if
	# if 31 < day
	addi $t1, $0, 31
	slt $t0, $t1, $a0
	bne $t0, $0, checkDateValid_return_0 #end_if
	# if 12 < month
	addi $t1, $0, 12
	slt $t0, $t1, $a1
	bne $t0, $0, checkDateValid_return_0 #end_if
	# if year < 0
	slt $t0, $a2, $0
	bne $t0, $0, checkDateValid_return_0 #end_if
	#
	addi $t2, $0, 28 # Feb has 28 days
	addi $t0, $a0, 0 # save $a0
	addi $a0, $a2, 0 
	jal isLeapYear # check leap year
	addi $a0, $t0, 0 # restore $a0
	addi $t0, $v0, 0
	bne $t0, $0, checkDateValid_set_max_Feb # if leap year
	j checkDateValid_check_month
	checkDateValid_set_max_Feb:
		addi $t2, $0, 29
	# 
	checkDateValid_check_month:
	add $t0, $0, $a0 # save $a0
	addi $v0, $0, 9 # ready for create pointer
	addi $a0, $0, 13 # create 13 bytes
	syscall
	add $a0, $0, $t0 # restore $a0
	addi $t0, $0, 31
	# set max day of month
	sb $t0, 1($v0)
	sb $t0, 3($v0)
	sb $t0, 5($v0)
	sb $t0, 7($v0)
	sb $t0, 8($v0)
	sb $t0, 10($v0)
	sb $t0, 12($v0)
	addi $t0, $0, 30
	sb $t0, 4($v0)
	sb $t0, 6($v0)
	sb $t0, 9($v0)
	sb $t0, 11($v0)
	
	sb $t2, 2($v0)
	# check max day
	addi $t0, $0, 0 #i
	checkDateValid_while:
		beq $t0, $a1, checkDateValid_end_while
		addi $v0, $v0, 1 # i++
		lb $t1, 0($v0)
		addi $t0, $t0, 1
		j checkDateValid_while
	checkDateValid_end_while:
		slt $t0, $t1, $a0 # check if maxDay < day a0
		bne $t0, $0, checkDateValid_return_0
		j checkDateValid_return_1
	checkDateValid_return_0:
		addi $v0, $0, 0
		j checkDateValid_end_func
	checkDateValid_return_1:
		addi $v0, $0, 1
		j checkDateValid_end_func
	checkDateValid_end_func:
	lw $ra, 0($sp)
	lw $a0, 4($sp)
	lw $a1, 8($sp)
	lw $a2, 12($sp)
	lw $a3, 16($sp)
	addi $sp, $sp, 100
	jr $ra
checkChoiceValid:
	addi $sp, $sp, -100
	sw $ra, 0($sp)
	sw $a0, 4($sp)
	sw $a1, 8($sp)
	sw $a2, 12($sp)
	sw $a3, 16($sp)
	
	addi $t1, $0, 1
	slt $t0, $a0, $t1
	bne $t0, $0, checkChoiceValid_return_0
	addi $t1, $0, 7
	slt $t0, $t1, $a0
	bne $t0, $0, checkChoiceValid_return_0
	j checkChoiceValid_return_1
	checkChoiceValid_return_0:
		addi $v0, $0, 0
		j checkChoiceValid_end_func
	checkChoiceValid_return_1:
		addi $v0, $0, 1
		j checkChoiceValid_end_func
	checkChoiceValid_end_func:
	lw $ra, 0($sp)
	lw $a0, 4($sp)
	lw $a1, 8($sp)
	lw $a2, 12($sp)
	lw $a3, 16($sp)
	addi $sp, $sp, 100
	jr $ra
Date:
	addi $sp, $sp, -100
	sw $ra, 0($sp)
	sw $a0, 4($sp)
	sw $a1, 8($sp)
	sw $a2, 12($sp)
	sw $a3, 16($sp)
	sw $s0, 20($sp)
	
	addi $s0, $0, '/'
	
	addi $t0, $0, 10
	div $a0, $t0
	mflo $t1 # day /10
	addi $t1, $t1, '0'
	sb $t1, 0($a3)
	mfhi $t1 # day % 10
	addi $t1, $t1, '0'
	sb $t1, 1($a3)
	sb $s0, 2($a3)

	div $a1, $t0
	mflo $t1 # month /10
	addi $t1, $t1, '0'
	sb $t1, 3($a3)
	mfhi $t1 # month % 10
	addi $t1, $t1, '0'
	sb $t1, 4($a3)
	sb $s0, 5($a3)
	
	div $a2, $t0
	mfhi $t1
	addi $t1, $t1, '0'
	sb $t1, 9($a3)
	mflo $a2
	div $a2, $t0
	mfhi $t1
	addi $t1, $t1, '0'
	sb $t1, 8($a3)
	mflo $a2
	div $a2, $t0
	mfhi $t1
	addi $t1, $t1, '0'
	sb $t1, 7($a3)
	mflo $a2
	div $a2, $t0
	mfhi $t1
	addi $t1, $t1, '0'
	sb $t1, 6($a3)
	addi $s0, $0, '\0'
	sb $s0, 10($a3)
	addi $v0, $a3, 0
	Date_end_func:
	lw $ra, 0($sp)
	lw $a0, 4($sp)
	lw $a1, 8($sp)
	lw $a2, 12($sp)
	lw $a3, 16($sp)
	lw $s0, 20($sp)
	addi $sp, $sp, 100
	jr $ra
Day:
	addi $sp, $sp, -100
	sw $ra, 0($sp)
	sw $a0, 4($sp)
	sw $a1, 8($sp)
	sw $a2, 12($sp)
	sw $a3, 16($sp)
	
	addi $v0, $0, 0
	lb $t0, 0($a0)
	add $v0, $v0, $t0
	addi $v0, $v0, -48
	addi $t0, $0, 10
	mul $v0, $v0, $t0
	lb $t0, 1($a0)
	add $v0, $v0, $t0
	addi $v0, $v0, -48
	Day_end_func:
	lw $ra, 0($sp)
	lw $a0, 4($sp)
	lw $a1, 8($sp)
	lw $a2, 12($sp)
	lw $a3, 16($sp)
	addi $sp, $sp, 100
	jr $ra
Month:
	addi $sp, $sp, -100
	sw $ra, 0($sp)
	sw $a0, 4($sp)
	sw $a1, 8($sp)
	sw $a2, 12($sp)
	sw $a3, 16($sp)
	
	addi $v0, $0, 0
	lb $t0, 3($a0)
	add $v0, $v0, $t0
	addi $v0, $v0, -48
	addi $t0, $0, 10
	mul $v0, $v0, $t0
	lb $t0, 4($a0)
	add $v0, $v0, $t0
	addi $v0, $v0, -48
	Month_end_func:
	lw $ra, 0($sp)
	lw $a0, 4($sp)
	lw $a1, 8($sp)
	lw $a2, 12($sp)
	lw $a3, 16($sp)
	addi $sp, $sp, 100
	jr $ra
Year:
	addi $sp, $sp, -100
	sw $ra, 0($sp)
	sw $a0, 4($sp)
	sw $a1, 8($sp)
	sw $a2, 12($sp)
	sw $a3, 16($sp)
	addi $t1, $0, 10
	addi $v0, $0, 0
	lb $t0, 6($a0)
	add $v0, $v0, $t0
	addi $v0, $v0, -48
	mul $v0, $v0, $t1
	lb $t0, 7($a0)
	add $v0, $v0, $t0
	addi $v0, $v0, -48
	mul $v0, $v0, $t1
	lb $t0, 8($a0)
	add $v0, $v0, $t0
	addi $v0, $v0, -48
	mul $v0, $v0, $t1
	lb $t0, 9($a0)
	add $v0, $v0, $t0
	addi $v0, $v0, -48
	Year_end_func:
	lw $ra, 0($sp)
	lw $a0, 4($sp)
	lw $a1, 8($sp)
	lw $a2, 12($sp)
	lw $a3, 16($sp)
	addi $sp, $sp, 100
	jr $ra
getNameMonth:
	addi $sp, $sp, -100
	sw $ra, 0($sp)
	sw $a0, 4($sp)
	sw $a1, 8($sp)
	sw $a2, 12($sp)
	sw $a3, 16($sp)
	
	addi $t0, $a0, 0
	addi $v0, $0, 9
	addi $a0, $0, 3
	syscall
	addi $a0, $t0, 0

	addi $t0, $0, 1
	beq $a0, $t0, getNameMonth_Jan
	addi $t0, $0, 2
	beq $a0, $t0, getNameMonth_Feb
	addi $t0, $0, 3
	beq $a0, $t0, getNameMonth_Mar
	addi $t0, $0, 4
	beq $a0, $t0, getNameMonth_Apr
	addi $t0, $0, 5
	beq $a0, $t0, getNameMonth_May
	addi $t0, $0, 6
	beq $a0, $t0, getNameMonth_Jun
	addi $t0, $0, 7
	beq $a0, $t0, getNameMonth_Jul
	addi $t0, $0, 8
	beq $a0, $t0, getNameMonth_Aug
	addi $t0, $0, 9
	beq $a0, $t0, getNameMonth_Sep
	addi $t0, $0, 10
	beq $a0, $t0, getNameMonth_Oct
	addi $t0, $0, 11
	beq $a0, $t0, getNameMonth_Nov
	addi $t0, $0, 12
	beq $a0, $t0, getNameMonth_Dec
	getNameMonth_Jan:
		addi $t0, $0, 'J'
		sb $t0, 0($v0)
		addi $t0, $0, 'a'
		sb $t0, 1($v0)
		addi $t0, $0, 'n'
		sb $t0, 2($v0)
		j getNameMonth_end_func	
	getNameMonth_Feb:
		addi $t0, $0, 'F'
		sb $t0, 0($v0)
		addi $t0, $0, 'e'
		sb $t0, 1($v0)
		addi $t0, $0, 'b'
		sb $t0, 2($v0)
		j getNameMonth_end_func	
	getNameMonth_Mar:
		addi $t0, $0, 'M'
		sb $t0, 0($v0)
		addi $t0, $0, 'a'
		sb $t0, 1($v0)
		addi $t0, $0, 'r'
		sb $t0, 2($v0)
		j getNameMonth_end_func	
	getNameMonth_Apr:
		addi $t0, $0, 'A'
		sb $t0, 0($v0)
		addi $t0, $0, 'p'
		sb $t0, 1($v0)
		addi $t0, $0, 'r'
		sb $t0, 2($v0)
		j getNameMonth_end_func	
	getNameMonth_May:
		addi $t0, $0, 'M'
		sb $t0, 0($v0)
		addi $t0, $0, 'a'
		sb $t0, 1($v0)
		addi $t0, $0, 'y'
		sb $t0, 2($v0)
		j getNameMonth_end_func	
	getNameMonth_Jun:
		addi $t0, $0, 'J'
		sb $t0, 0($v0)
		addi $t0, $0, 'u'
		sb $t0, 1($v0)
		addi $t0, $0, 'n'
		sb $t0, 2($v0)
		j getNameMonth_end_func	
	getNameMonth_Jul:
		addi $t0, $0, 'J'
		sb $t0, 0($v0)
		addi $t0, $0, 'u'
		sb $t0, 1($v0)
		addi $t0, $0, 'l'
		sb $t0, 2($v0)
		j getNameMonth_end_func	
	getNameMonth_Aug:
		addi $t0, $0, 'A'
		sb $t0, 0($v0)
		addi $t0, $0, 'u'
		sb $t0, 1($v0)
		addi $t0, $0, 'g'
		sb $t0, 2($v0)
		j getNameMonth_end_func	
	getNameMonth_Sep:
		addi $t0, $0, 'S'
		sb $t0, 0($v0)
		addi $t0, $0, 'e'
		sb $t0, 1($v0)
		addi $t0, $0, 'p'
		sb $t0, 2($v0)
		j getNameMonth_end_func	
	getNameMonth_Oct:
		addi $t0, $0, 'O'
		sb $t0, 0($v0)
		addi $t0, $0, 'c'
		sb $t0, 1($v0)
		addi $t0, $0, 't'
		sb $t0, 2($v0)
		j getNameMonth_end_func
	getNameMonth_Nov:
		addi $t0, $0, 'N'
		sb $t0, 0($v0)
		addi $t0, $0, 'o'
		sb $t0, 1($v0)
		addi $t0, $0, 'v'
		sb $t0, 2($v0)
		j getNameMonth_end_func	
	getNameMonth_Dec:
		addi $t0, $0, 'D'
		sb $t0, 0($v0)
		addi $t0, $0, 'e'
		sb $t0, 1($v0)
		addi $t0, $0, 'c'
		sb $t0, 2($v0)
		j getNameMonth_end_func	
	getNameMonth_end_func:
	lw $ra, 0($sp)
	lw $a0, 4($sp)
	lw $a1, 8($sp)
	lw $a2, 12($sp)
	lw $a3, 16($sp)
	addi $sp, $sp, 100
	jr $ra
Convert:
	addi $sp, $sp, -100
	sw $ra, 0($sp)
	sw $a0, 4($sp)
	sw $a1, 8($sp)
	sw $a2, 12($sp)
	sw $a3, 16($sp)
	sw $s0, 20($sp) # day
	sw $s1, 24($sp) # month
	sw $s2, 28($sp) # year
	sw $s3, 32($sp) # name of month
	addi $t0, $0, 'A'
	beq $a1, $t0, Convert_A
	jal Day
	addi $s0, $v0, 0
	jal Month
	addi $s1, $v0, 0
	jal Year
	addi $s2, $v0, 0
	addi $s3, $a0, 0 # save $a0
	addi $a0, $s1, 0
	jal getNameMonth
	addi $a0, $s3, 0 # restore $a0
	addi $s3, $v0, 0
	addi $t0, $0, 'B'
	beq $a1, $t0, Convert_B
	addi $t0, $0, 'C'
	beq $a1, $t0, Convert_C
	Convert_A:
		# swap TIME[0], TIME[3]
		lb $t0, 0($a0)
		lb $t1, 3($a0)
		sb $t1, 0($a0)
		sb $t0, 3($a0) # end
		# swap TIME[1], TIME[4]
		lb $t0, 1($a0)
		lb $t1, 4($a0)
		sb $t1, 1($a0)
		sb $t0, 4($a0) # end
		addi $v0, $a0, 0
		j Convert_end_func
	Convert_B:
		lb $t0, 0($s3)
		sb $t0, 0($a0)
		lb $t0, 1($s3)
		sb $t0, 1($a0)
		lb $t0, 2($s3)
		sb $t0, 2($a0)
		addi $t0, $0, ' '
		sb $t0, 3($a0)
		addi $t0, $0, 10
		div $s0, $t0
		mflo $t0
		addi $t0, $t0, '0'
		sb $t0, 4($a0)
		mfhi $t0
		addi $t0, $t0, '0'
		sb $t0, 5($a0)
		j Convert_pre_end_func
	Convert_C:
		lb $t0, 0($s3)
		sb $t0, 3($a0)
		lb $t0, 1($s3)
		sb $t0, 4($a0)
		lb $t0, 2($s3)
		sb $t0, 5($a0)
		addi $t0, $0, ' '
		sb $t0, 2($a0)
		addi $t0, $0, 10
		div $s0, $t0
		mflo $t0
		addi $t0, $t0, '0'
		sb $t0, 0($a0)
		mfhi $t0
		addi $t0, $t0, '0'
		sb $t0, 1($a0)
		j Convert_pre_end_func
	Convert_pre_end_func:
		addi $t0, $0, ','
		sb $t0, 6($a0)
		addi $t0, $0, ' '
		sb $t0, 7($a0)
		addi $t0, $0, 10
		div $s2, $t0
		mfhi $t1
		addi $t1, $t1, '0'
		sb $t1, 11($a0)
		mflo $s2
		div $s2, $t0
		mfhi $t1
		addi $t1, $t1, '0'
		sb $t1, 10($a0)
		mflo $s2
		div $s2, $t0
		mfhi $t1
		addi $t1, $t1, '0'
		sb $t1, 9($a0)
		mflo $s2
		div $s2, $t0
		mfhi $t1
		addi $t1, $t1, '0'
		sb $t1, 8($a0)
		addi $t0, $0, '\0'
		sb $t0, 12($a0)
		addi $v0, $a0, 0
	Convert_end_func:
	lw $ra, 0($sp)
	lw $a0, 4($sp)
	lw $a1, 8($sp)
	lw $a2, 12($sp)
	lw $a3, 16($sp)
	lw $s0, 20($sp)
	lw $s1, 24($sp)
	lw $s2, 28($sp)
	lw $s3, 32($sp)
	addi $sp, $sp, 100
	jr $ra
LeapYear:
	addi $sp, $sp, -100
	sw $ra, 0($sp)
	sw $a0, 4($sp)
	sw $a1, 8($sp)
	sw $a2, 12($sp)
	sw $a3, 16($sp)
	jal Year
	addi $a0, $v0, 0
	jal isLeapYear
	LeapYear_end_func:
	lw $ra, 0($sp)
	lw $a0, 4($sp)
	lw $a1, 8($sp)
	lw $a2, 12($sp)
	lw $a3, 16($sp)
	addi $sp, $sp, 100
	jr $ra
GetTime:
	addi $sp, $sp, -100
	sw $ra, 0($sp)
	sw $a0, 4($sp)
	sw $a1, 8($sp)
	sw $a2, 12($sp)
	sw $a3, 16($sp)
	sw $s0, 20($sp) # year 1
	sw $s1, 24($sp) # year 2
	sw $s2, 28($sp) # day 1
	sw $s3, 32($sp) # day 2
	sw $s4, 36($sp) # month 1
	sw $s5, 40($sp) # month 2
	
	jal Year
	addi $s0, $v0, 0
	addi $s1, $a0, 0
	addi $a0, $a1, 0
	jal Year
	addi $a0, $s1, 0
	addi $s1, $v0, 0
	
	beq $s0, $s2, GetTime_year1_eq_year2
	slt $t0, $s0, $s1
	bne $t0, $0, GetTime_year1_lt_year2
		# year_2_lt_year 1
		addi $s0, $a0, 0
		addi $a0, $a1, 0
		jal Day
		addi $s2, $v0, 0
		jal Month
		addi $s4, $v0, 0
		jal Year
		addi $a0, $s0, 0
		addi $s0, $v0, 0
		
		jal Day
		addi $s3, $v0, 0
		jal Month
		addi $s5, $v0, 0
		jal Year
		addi $a0, $s1, 0
		add $s1, $v0, 0
	j GetTime_process_month
	GetTime_year1_lt_year2:
		jal Day
		addi $s2, $v0, 0
		jal Month
		addi $s4, $v0, 0
		jal Year
		addi $s0, $v0, 0
		
		addi $s1, $a0, 0
		addi $a0, $a1, 0
		jal Day
		addi $s3, $v0, 0
		jal Month
		addi $s5, $v0, 0
		jal Year
		addi $a0, $s1, 0
		add $s1, $v0, 0
	GetTime_process_month:
		slt $t0, $s4, $s5
		bne $t0, $0, GetTime_month1_lt_month2
		slt $t0, $s5, $s4
		bne $t0, $0, GetTime_month2_lt_month1
		# month2 == month1
		slt $t0, $s3, $s2
		beq $t0, $0, GetTime_day1_lte_day2
		# return year2 -  year1 -1
		sub $v0, $s1, $s0
		addi $v0, $v0, -1
		GetTime_month1_lt_month2:
			sub $v0, $s1, $s0
			j GetTime_end_func
		GetTime_month2_lt_month1:
			sub $v0, $s1, $s0
			addi $v0, $v0, -1
			j GetTime_end_func
		GetTime_day1_lte_day2:
			sub $v0, $s1, $s0
			j GetTime_end_func
	GetTime_year1_eq_year2:
		addi $v0, $0, 0
		j GetTime_end_func
	GetTime_end_func:
	lw $ra, 0($sp)
	lw $a0, 4($sp)
	lw $a1, 8($sp)
	lw $a2, 12($sp)
	lw $a3, 16($sp)
	lw $s0, 20($sp) # year 1
	lw $s1, 24($sp) # year 2
	lw $s2, 28($sp) # day 1
	lw $s3, 32($sp) # day 2
	lw $s4, 36($sp) # month 1
	lw $s5, 40($sp) # month 2
	addi $sp, $sp, 100
	jr $ra
Weekday:
	addi $sp, $sp, -100
	sw $ra, 0($sp)
	sw $a0, 4($sp)
	sw $a1, 8($sp)
	sw $a2, 12($sp)
	sw $a3, 16($sp)
	sw $s0, 20($sp) #day
	sw $s1, 24($sp) #month
	sw $s2, 28($sp) #year
	sw $s3, 32($sp)
	
	jal Day
	addi $s0, $v0, 0
	jal Month
	addi $s1, $v0, 0
	jal Year
	addi $s2, $v0, 0
	
	add $t0, $0, 12
	beq $s1, $t0, Weekday_case_month12
	addi $t0, $t0, -1
	beq $s1, $t0, Weekday_case_month11
	addi $t0, $t0, -1	
	beq $s1, $t0, Weekday_case_month10
	addi $t0, $t0, -1
	beq $s1, $t0, Weekday_case_month9
	addi $t0, $t0, -1
	beq $s1, $t0, Weekday_case_month8
	addi $t0, $t0, -1
	beq $s1, $t0, Weekday_case_month7
	addi $t0, $t0, -1
	beq $s1, $t0, Weekday_case_month6
	addi $t0, $t0, -1
	beq $s1, $t0, Weekday_case_month5
	addi $t0, $t0, -1
	beq $s1, $t0, Weekday_case_month4
	addi $t0, $t0, -1
	beq $s1, $t0, Weekday_case_month3
	addi $t0, $t0, -1
	beq $s1, $t0, Weekday_case_month2
	addi $t0, $t0, -1
	beq $s1, $t0, Weekday_case_month1
	Weekday_case_month12:
		addi $s0, $s0, 5
		j Weekday_check_leapyear
	Weekday_case_month11:
		addi $s0, $s0, 3
		j Weekday_check_leapyear
	Weekday_case_month10:
		addi $s0, $s0, 0
		j Weekday_check_leapyear
	Weekday_case_month9:
		addi $s0, $s0, 5
		j Weekday_check_leapyear
	Weekday_case_month8:
		addi $s0, $s0, 2
		j Weekday_check_leapyear
	Weekday_case_month7:
		addi $s0, $s0, 6
		j Weekday_check_leapyear
	Weekday_case_month6:
		addi $s0, $s0, 4
		j Weekday_check_leapyear
	Weekday_case_month5:
		addi $s0, $s0, 1
		j Weekday_check_leapyear
	Weekday_case_month4:
		addi $s0, $s0, 6
		j Weekday_check_leapyear
	Weekday_case_month3:
		addi $s0, $s0, 3
		j Weekday_check_leapyear
	Weekday_case_month2:
		addi $s0, $s0, 3
		j Weekday_check_leapyear
	Weekday_case_month1:
		addi $s0, $s0, 0
		j Weekday_check_leapyear
	Weekday_check_leapyear:
		addi $a0, $s2, 0
		jal isLeapYear
		bne $v0, $0, Weekday_next_process
		addi $t0, $0, 1
		beq $s1, $t0, Weekday_if_month1
		addi $t0, $t0, 1
		beq $s1, $t0, Weekday_if_month2
		j Weekday_next_process
		Weekday_if_month1:
			addi $s0, $s0, 6
			j Weekday_next_process
		Weekday_if_month2:
			addi $s0, $s0, -1
			j Weekday_next_process
	Weekday_next_process:
		add $s0, $s0, $s2 # temp = temp + year
		addi $t0, $0, 4
		div $s2, $t0
		mflo $t1
		add $s0, $s0, $t1
		addi $t0, $0, 100
		div $s2, $t0
		mflo $t1
		sub $s0, $s0, $t1
		addi $t0, $0, 400
		div $s2, $t0
		mflo $t1
		add $s0, $s0, $t1
		addi $t0, $0 7
		div $s0, $t0
		mfhi $s0
		addi $v0, $0, 9
		addi $a0, $0, 5 # 5 bytes
		syscall
		addi $t0, $0, 0
		beq $s0, $t0, Weekday_case_temp0
		addi $t0, $t0, 1
		beq $s0, $t0, Weekday_case_temp1
		addi $t0, $t0, 1
		beq $s0, $t0, Weekday_case_temp2
		addi $t0, $t0, 1
		beq $s0, $t0, Weekday_case_temp3
		addi $t0, $t0, 1
		beq $s0, $t0, Weekday_case_temp4
		addi $t0, $t0, 1
		beq $s0, $t0, Weekday_case_temp5
		j Weekday_case_temp_else
		Weekday_case_temp0:
			addi $t0, $0, 'S'
			sb $t0, 0($v0)
			addi $t0, $0, 'a'
			sb $t0, 1($v0)
			addi $t0, $0, 't'
			sb $t0, 2($v0)
			j Weekday_end_func
		Weekday_case_temp1:
			addi $t0, $0, 'S'
			sb $t0, 0($v0)
			addi $t0, $0, 'u'
			sb $t0, 1($v0)
			addi $t0, $0, 'n'
			sb $t0, 2($v0)
			j Weekday_end_func
		Weekday_case_temp2:
			addi $t0, $0, 'M'
			sb $t0, 0($v0)
			addi $t0, $0, 'o'
			sb $t0, 1($v0)
			addi $t0, $0, 'n'
			sb $t0, 2($v0)
			j Weekday_end_func
		Weekday_case_temp3:
			addi $t0, $0, 'T'
			sb $t0, 0($v0)
			addi $t0, $0, 'u'
			sb $t0, 1($v0)
			addi $t0, $0, 'e'
			sb $t0, 2($v0)
			addi $t0, $0, 's'
			sb $t0, 3($v0)
			j Weekday_end_func
		Weekday_case_temp4:
			addi $t0, $0, 'W'
			sb $t0, 0($v0)
			addi $t0, $0, 'e'
			sb $t0, 1($v0)
			addi $t0, $0, 'd'
			sb $t0, 2($v0)
			j Weekday_end_func
		Weekday_case_temp5:
			addi $t0, $0, 'T'
			sb $t0, 0($v0)
			addi $t0, $0, 'h'
			sb $t0, 1($v0)
			addi $t0, $0, 'u'
			sb $t0, 2($v0)
			addi $t0, $0, 'r'
			sb $t0, 3($v0)
			addi $t0, $0, 's'
			sb $t0, 4($v0)
			j Weekday_end_func
		Weekday_case_temp_else:
			addi $t0, $0, 'F'
			sb $t0, 0($v0)
			addi $t0, $0, 'r'
			sb $t0, 1($v0)
			addi $t0, $0, 'i'
			sb $t0, 2($v0)
			j Weekday_end_func
	Weekday_end_func:
	lw $ra, 0($sp)
	lw $a0, 4($sp)
	lw $a1, 8($sp)
	lw $a2, 12($sp)
	lw $a3, 16($sp)
	lw $s0, 20($sp) #day
	lw $s1, 24($sp) #month
	lw $s2, 28($sp) #year
	lw $s3, 32($sp)
	addi $sp, $sp, 100
	jr $ra
getLeapYearNearest:
	addi $sp, $sp, -100
	sw $ra, 0($sp)
	sw $a0, 4($sp)
	sw $a1, 8($sp)
	sw $a2, 12($sp)
	sw $a3, 16($sp)
	sw $s0, 20($sp)
	sw $s1, 24($sp)
	sw $s2, 28($sp)
	sw $s3, 32($sp)
	sw $s4, 36($sp) # res 1
	sw $s5, 40($sp) # res 2
	jal Year
	addi $s0, $v0, 0
	addi $s4, $0, -1
	addi $s5, $0, -1
	addi $s1, $0, 1 # i
	addi $s2, $0, 8
	getLeapYearNearest_while:
		beq $s1, $s2, getLeapYearNearest_end_while
		sub $s3, $s0, $s1
		addi $a0, $s3, 0
		jal isLeapYear
		bne $v0, $0, getLeapYearNearest_isLeapYear1
		j getLeapYearNearest_if2
		getLeapYearNearest_isLeapYear1:
			addi $t0, $0, -1
			beq $s4, $t0, getLeapYearNearest_isLeapYear1_year1m1
			sub $s5, $s0, $s1
			j getLeapYearNearest_end_func
			getLeapYearNearest_isLeapYear1_year1m1:
				sub $s4, $s0, $s1
		getLeapYearNearest_if2:
		add $s3, $s0, $s1
		addi $a0, $s3, 0
		jal isLeapYear
		bne $v0, $0, getLeapYearNearest_isLeapYear2
		j getLeapYearNearest_while_inc_i
		getLeapYearNearest_isLeapYear2:
			addi $t0, $0, -1
			beq $s4, $t0, getLeapYearNearest_isLeapYear2_year1m1
			add $s5, $s0, $s1
			j getLeapYearNearest_end_func
			getLeapYearNearest_isLeapYear2_year1m1:
				sub $s4, $s0, $s1
		getLeapYearNearest_while_inc_i:
		addi $s1, $s1, 1
		j getLeapYearNearest_while
	getLeapYearNearest_end_while:
	getLeapYearNearest_end_func:
	addi $v0, $s4, 0
	addi $v1, $s5, 0
	lw $ra, 0($sp)
	lw $a0, 4($sp)
	lw $a1, 8($sp)
	lw $a2, 12($sp)
	lw $a3, 16($sp)
	lw $s0, 20($sp)
	lw $s1, 24($sp)
	lw $s2, 28($sp)
	lw $s3, 32($sp)
	lw $s4, 36($sp)
	lw $s5, 40($sp)
	addi $sp, $sp, 100
	jr $ra
