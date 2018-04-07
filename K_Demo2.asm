# NOTE:
# func Convert: only type A, type B and type C are not coded
.data
	#prompt
	msg_nhap_ngay: .asciiz "Nhap ngay DAY: "
	msg_nhap_thang: .asciiz "Nhap thang MONTH: "
	msg_nhap_nam: .asciiz "Nhap nam YEAR: "
	msg_lua_chon: .asciiz "Lua chon: "
	msg_nhap_lai: .asciiz "Hay nhap lai\n"
	#variable
	s: .asciiz "2013\n"
	stringTest: .asciiz "30/01/2018"
	newLine: .asciiz "\n"
	stringDate: .asciiz "" # tmp variable for func Date
	stringConvert: .asciiz "" # tmp variable for func Convert
	arrTemp: .byte 0, 0, 3, 3, 6, 1, 4, 6, 2, 5, 0, 3, 5 # for func Weekday
	arrTemp2: .byte 0, 6, -1 # for func Weekday
	Sat: .asciiz "Sat"
	Sun: .asciiz "Sun"
	Mon: .asciiz "Mon"
	Tue: .asciiz "Tue"
	Wed: .asciiz "Wed"
	Thu: .asciiz "Thu"
	Fri: .asciiz "Fri"
	arrTemp3: .word Sat, Sun, Mon, Tue, Wed, Thu, Fri 
	day: .asciiz ""
	month: .asciiz ""
	year: .asciiz ""
	choice: .asciiz ""
.text

	main:
		li $v0, 4
		la $a0, msg_nhap_ngay
		syscall
		li $v0, 8
		la $a0, day
		la $a1, 100
		syscall
		jal convertStringToInt
		move $s1, $v1
		
		li $v0, 4
		la $a0, msg_nhap_thang
		syscall
		li $v0, 8
		la $a0, month
		la $a1, 100
		syscall
		jal convertStringToInt
		move $s2, $v1
		
		li $v0, 4
		la $a0, msg_nhap_nam
		syscall
		li $v0, 8
		la $a0, year
		la $a1, 100
		syscall
		jal convertStringToInt
		move $s3, $v1
		
		move $a0, $s1
		move $a1, $s2
		move $a2, $s3
		jal Date
		move $a0, $v1
		li $v0, 4
		syscall
		li $a1, 'A'
		jal Convert
		move $a0, $v1
		li $v0, 4
		syscall
		la $a0, stringTest
		jal Day
		move $a0, $v1
		li $v0, 1
		syscall
		la $a0, stringTest
		jal Month
		move $a0, $v1
		li $v0, 1
		syscall
		la $a0, stringTest
		jal Year
		move $a0, $v1
		li $v0, 1
		syscall
		la $a0, stringTest
		jal LeapYear
		move $a0, $v1
		li $v0, 1
		syscall
		la $a0, stringTest
		jal Weekday
		move $a0, $v1
		li $v0, 4
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
	Convert:
		addi $sp, $sp, -100
		sw $ra, 0($sp)
		sw $a0, 4($sp)
		sw $a1, 8($sp)
		sw $t0, 12($sp)
		sw $t1, 16($sp)
		beq $a1, 'A', Convert_type_A
		beq $a1, 'B', Convert_type_B
		beq $a1, 'C', Convert_type_C
		Convert_type_A:
			lb $t0, 0($a0)
			lb $t1, 3($a0)
			sb $t1, 0($a0)
			sb $t0, 3($a0)
			lb $t0, 1($a0)
			lb $t1, 4($a0)
			sb $t1, 1($a0)
			sb $t0, 4($a0)
			j Convert_end_func
		Convert_type_B:
			j Convert_end_func
		Convert_type_C:
			j Convert_end_func
		Convert_end_func:
		move $v1, $a0
		lw $ra, 0($sp)
		lw $a0, 4($sp)
		lw $a1, 8($sp)
		lw $t0, 12($sp)
		lw $t1, 16($sp)
		addi $sp, $sp, 100
		jr $ra
	checkDateValid:
		addi $sp, $sp, -100
		sw $ra, 0($sp)
		sw $a0, 4($sp)
		sw $a1, 8($sp)
		sw $a2, 8($sp)
		sw $a3, 12($sp)
		sw $t0, 16($sp)
		
		blt $a0, 1, checkDateValid_return_0
		bgt $a0, 31, checkDateValid_return_0
		blt $a1, 1, checkDateValid_return_0
		bgt $a1, 12, checkDateValid_return_0
		blt $a2, 1, checkDateValid_return_0
		li $t0, 0
		beq $a1, 4, checkDateValid_check_day_greater_than_30
		beq $a1, 6, checkDateValid_check_day_greater_than_30
		beq $a1, 9, checkDateValid_check_day_greater_than_30
		beq $a1, 11, checkDateValid_check_day_greater_than_30
		j checkDateValid_next
		checkDateValid_check_day_greater_than_30:
			bgt $a0, 30, checkDateValid_return_0
		j checkDateValid_return_1
		checkDateValid_next:
		beq $a1, 2, checkDateValid_check_Feb
		checkDateValid_check_Feb:
			move $t0, $a0
			move $a0, $a2
			jal isLeapYear
			move $a0, $t0
			beq $v1, $0, checkDateValid_check_day_greater_than_28
			j checkDateValid_check_day_greater_than_29
			checkDateValid_check_day_greater_than_28:
				bgt $a0, 28, checkDateValid_return_0
				j checkDateValid_return_1
			checkDateValid_check_day_greater_than_29:
				bgt $a0, 29, checkDateValid_return_0
				j checkDateValid_return_1
		checkDateValid_return_0:
			li $v1, 0
			j checkDateValid_end_func
		checkDateValid_return_1:
			li $v1, 1
			j checkDateValid_end_func
		checkDateValid_end_func:
		lw $ra, 0($sp)
		lw $a0, 4($sp)
		lw $a1, 8($sp)
		lw $a2, 8($sp)
		lw $a3, 12($sp)
		lw $t0, 16($sp)
		addi $sp, $sp, 100
		jr $ra
	checkChoiceValid:
		addi $sp, $sp, -100
		sw $ra, 0($sp)
		sw $a0, 4($sp)
		blt $a0, 1, checkChoiceValid_return_0
		bgt $a0, 7, checkChoiceValid_return_0
		checkChoiceValid_return_0:
			li $v1, 0
			j checkChoiceValid_end_func
		checkChoiceValid_return_1:
			li $v1, 1
			j checkChoiceValid_end_func
		checkChoiceValid_end_func:
		lw $ra, 0($sp)
		lw $a0, 4($sp)
		addi $sp, $sp, 100
		jr $ra
	Day:
		addi $sp, $sp, -100
		sw $ra, 0($sp)
		sw $a0, 4($sp)
		sw $t0, 8($sp)
		addi $v1, $0, 0
		lb $t0, 0($a0) # TIME[0]
		addi $v1, $t0, -48
		mul $v1, $v1, 10
		lb $t0, 1($a0)
		add $v1, $v1, $t0
		addi $v1, $v1, -48
		Day_end_func:
		lw $ra, 0($sp)
		lw $a0, 4($sp)
		lw $t0, 8($sp)	
		addi $sp, $sp, 100
		jr $ra
	Month:
		addi $sp, $sp, -100
		sw $ra, 0($sp)
		sw $a0, 4($sp)
		sw $t0, 8($sp)
		addi $v1, $0, 0
		lb $t0, 3($a0) # TIME[3]
		addi $v1, $t0, -48
		mul $v1, $v1, 10
		lb $t0, 4($a0)
		add $v1, $v1, $t0
		addi $v1, $v1, -48
		Month_end_func:
		lw $ra, 0($sp)
		lw $a0, 4($sp)
		lw $t0, 8($sp)	
		addi $sp, $sp, 100
		jr $ra
	Year:
		addi $sp, $sp, -100
		sw $ra, 0($sp)
		sw $a0, 4($sp)
		sw $t0, 8($sp)
		addi $v1, $0, 0
		lb $t0, 6($a0) # TIME[6]
		addi $v1, $t0, -48
		mul $v1, $v1, 10
		lb $t0, 7($a0)
		add $v1, $v1, $t0
		addi $v1, $v1, -48
		mul $v1, $v1, 10
		lb $t0, 8($a0)
		add $v1, $v1, $t0
		addi $v1, $v1, -48
		mul $v1, $v1, 10
		lb $t0, 9($a0)
		add $v1, $v1, $t0
		addi $v1, $v1, -48
		Year_end_func:
		lw $ra, 0($sp)
		lw $a0, 4($sp)
		lw $t0, 8($sp)	
		addi $sp, $sp, 100
		jr $ra
	LeapYear:
		addi $sp, $sp, -100
		sw $ra, 0($sp)
		sw $a0, 4($sp)
		sw $t0, 8($sp)
		move $t0, $a0
		jal Year
		move $a0, $v1
		jal isLeapYear
		LeapYear_end_func:
		lw $ra, 0($sp)
		lw $a0, 4($sp)
		lw $t0, 8($sp)	
		addi $sp, $sp, 100
		jr $ra
	Weekday:
		addi $sp, $sp, -100
		sw $ra, 0($sp)
		sw $a0, 4($sp)
		sw $t0, 8($sp) # tmp
		sw $t1, 12($sp) # day
		sw $t2, 16($sp) # month
		sw $t3, 20($sp) #year
		sw $t4, 24($sp)
		sw $t5, 28($sp)
		sw $t6, 32($sp)
		jal Day
		move $t1, $v1
		jal Month
		move $t2, $v1
		jal Year
		move $t3, $v1
		move $t0, $t1
		lb $t4, arrTemp($t2)
		add $t0, $t0, $t4 #temp = temp + x
		move $t4, $a0
		move $a0, $t3
		jal isLeapYear
		move $a0, $t4
		move $t4, $v1
		beq $t4, 1, Weekday_check_leapyear
		Weekday_check_leapyear:
			lb $t4, arrTemp2($t2)
			add $t0, $t0, $t4
		add $t0, $t0, $t3
		div $t4, $t3, 4
		add $t0, $t0, $t4
		div $t4, $t3, 100
		sub $t0, $t0, $t4
		div $t4, $t3, 400
		add $t0, $t0, $t4
		li $t4, 7
		div $t0, $t4
		mfhi $t0
		la $t5, arrTemp3
		add $t5, $t5, $t0
		lw $v1, 0($t5)
		Weekday_end_func:
		lw $ra, 0($sp)
		lw $a0, 4($sp)
		lw $t0, 8($sp)	
		lw $t1, 12($sp)
		lw $t2, 16($sp)
		lw $t3, 20($sp)
		lw $t4, 24($sp)
		lw $t5, 28($sp)
		lw $t6, 32($sp)
		addi $sp, $sp, 100
		jr $ra
