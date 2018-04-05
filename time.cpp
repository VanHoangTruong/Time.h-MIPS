#include <stdio.h>
#include <string.h>
 
//hàm chuyển char* về int, nếu chuyển không thành công thì hàm trà về -1
int convertStringToInt(char* input) {
    int res = 0;
    for (int i = 0; i < strlen(input); i++) {
        if (input[i] < '0') return -1;
        if (input[i] > '9') return -1;
        res = res * 10 + input[i] - '0';
    }
    return res;
}
 
//hàm kiểm tra một năm có phải là năm nhuận hay không
bool isLeapYear(int input){
    //chia hết cho 4 mà không chia hết cho 100
    if (input % 4 == 0)
    	if (input % 100) return 1;
 
    //hoặc chia hết cho 400 là năm nhuận
    if (input % 400 == 0) return 1;
 
    return 0;
}
 
//hàm kiểm tra tính hợp lệ của input
bool checkInputValid(int day, int month, int year, int choice) {
    
 
     // ngày nhỏ hơn 1 hoặc > 31 thì không hợp lệ
    if (day < 1) return 0;
    if (day > 31) return 0;
 
     // tháng nhỏ hơn 1 hoặc > 12 thì không hợp lệ
    if (month < 1) return 0;
    if (month > 12) return 0;
 
     // năm nhỏ hơn 0 thì không hợp lệ
    if (year < 0) return 0;
 
     // lựa chọn tính năng nhỏ hơn 1 hoặc > 7 thì không hợp lệ
    if (choice < 1) return 0;
    if (choice > 7) return 0;
 
    // nếu tháng là 4 6 9 12 mà ngày > 30 thì không hợp lệ
    bool flag = 0;
    if (month == 4) flag = 1;
    if (month == 6) flag = 1;
    if (month == 9) flag = 1;
    if (month == 11) flag = 1;
 
    if (flag)
        if (day > 30) return 0;
 
    // nếu tháng là 2
    if (month == 2)
        //nếu là năm nhuận và ngày > 29 thì không hợp lệ
        if (isLeapYear(year))
	if (day > 29) return 0;
    if (month == 2)
        //nếu không là năm nhuận và ngày > 29 thì không hợp lệ
        if (!isLeapYear(year))
	if (day > 28) return 0;
 
    return 1;
}

//Xuất chuỗi TIME theo định dạng mặc định DD/MM/YYYY
char* Date(int day, int month, int year, char* TIME) {
	TIME = new char [10];
	TIME[0] = (day / 10) + '0';
	TIME[1] = (day % 10) + '0';
	TIME[2] = '/';
	TIME[3] = (month / 10) + '0';
	TIME[4] = (month % 10) + '0';
	TIME[5] = '/';
	TIME[6] = (year / 1000) + '0';
	TIME[7] = ((year % 1000) / 100) + '0';
	TIME[8] = ((year % 100) / 10) + '0';
	TIME[9] = (year % 10) + '0';
	TIME[10] = '\0';
	return TIME;
}
 
int main() {
    char* day = new char[100];
    char* month = new char[100];
    char* year = new char[100];
    char* choice = new char[100];
 
    printf("Nhap ngay DAY: "); scanf("%s", day);
    printf("Nhap thang MONTH: "); scanf("%s", month);
    printf("Nhap nam YEAR: "); scanf("%s", year);
    
    int dayInt = convertStringToInt(day);
    int monthInt = convertStringToInt(month);
    int yearInt = convertStringToInt(year);
    int choiceInt;
    
    delete []day;
    delete []month;
    delete []year;
 
    while(1) {
        printf("Lua chon: "); scanf("%s", choice);
        choiceInt = convertStringToInt(choice);
        if (checkInputValid(dayInt, monthInt, yearInt, choiceInt)){
            break;
        } else printf("Hay nhap lai\n");
    }
    
    if (choiceInt == 1) {
    	char* TIME;
    	printf("%s", Date(dayInt, monthInt, yearInt, TIME));
    }
 
    //printf("%s\n", day);
    //printf("%s\n", month);
    //printf("%s\n", year);
    return 0;
}