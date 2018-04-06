#include <stdio.h>

//hàm chuyển char* về int, nếu chuyển không thành công thì hàm trà về -1
int convertStringToInt(char* input) {
    int res = 0;
    int i = 0;
    
    while (input[i] != '\0') {
        if (input[i] < '0') return -1;
        if (input[i] > '9') return -1;
        res = res * 10 + input[i] - '0';
        i++;
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

//hàm kiểm tra tính hợp lệ của input Date
bool checkDateValid(int day, int month, int year) {
    // ngày nhỏ hơn 1 hoặc > 31 thì không hợp lệ
    if (day < 1) return 0;
    if (day > 31) return 0;
    
    // tháng nhỏ hơn 1 hoặc > 12 thì không hợp lệ
    if (month < 1) return 0;
    if (month > 12) return 0;
    
    // năm nhỏ hơn 0 thì không hợp lệ
    if (year < 0) return 0;
    
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

//hàm kiểm tra tính hợp lệ của input lựa chọn tính năng
bool checkChoiceValid(int choice) {
    // lựa chọn tính năng nhỏ hơn 1 hoặc > 7 thì không hợp lệ
    if (choice < 1) return 0;
    if (choice > 7) return 0;
    
    return 1;
}

//hàm số 1 trong yêu cầu giải quyết thao tác 1
//Xuất chuỗi TIME theo định dạng mặc định DD/MM/YYYY
char* Date(int day, int month, int year, char* TIME) {
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

//hàm số 2 trong yêu cầu giải quyết thao tác 2
//Chuyển dổi định dạng chuỗi
char* Convert(char* TIME, char type) {
    if (type == 'A') {
        // swap time[0], time[3]
        char temp = TIME[0];
        TIME[0] = TIME[3];
        TIME[3] = temp;
        
        // swap time[1], time[4]
        temp = TIME[1];
        TIME[1] = TIME[4];
        TIME[4] = temp;
    }
    if (type == 'B') {
        // swap time[0], time[3]
        char temp = TIME[0];
        TIME[0] = TIME[3];
        TIME[3] = temp;
        
        TIME[2] = ' ';
        
        // swap time[1], time[4]
        temp = TIME[1];
        TIME[1] = TIME[4];
        TIME[4] = temp;
        
        TIME[5] = ',';
    }
    if (type == 'C') {
        TIME[2] = ' ';
        TIME[5] = ',';
    }
    return TIME;
}

//hàm số 3 trong yêu cầu
//lấy giá trị ngày từ chuỗi TIME
int Day(char* TIME) {
    int res = 0;
    res = TIME[0] - '0';
    res = res * 10;
    res = res + TIME[1] - '0';
    return res;
}

//hàm số 4 trong yêu cầu
//lấy giá trị tháng từ chuỗi TIME
int Month(char* TIME) {
    int res = 0;
    res = TIME[3] - '0';
    res = res * 10;
    res = res + TIME[4] - '0';
    return res;
}

//hàm số 5 trong yêu cầu
//lấy giá trị năm từ chuỗi TIME
int Year(char* TIME) {
    int res = 0;
    res = TIME[6] - '0';
    res = res * 10;
    res = res + TIME[7] - '0';
    res = res * 10;
    res = res + TIME[8] - '0';
    res = res * 10;
    res = res + TIME[9] - '0';
    return res;
}

//hàm số 6 trong yêu cầu  giải quyết thao tác 4
//Kiểm tra năm nhuận
int LeapYear(char* TIME) {
    int year = Year(TIME);
    return isLeapYear(year);
}

//hàm số 8 trong yêu cầu giải quyết thao tác 3
//Cho biết giá trị ngày trong chuỗi TIME là thứ mấy trong tuần
char* Weekday(char* TIME) {
    int day = Day(TIME);
    int month = Month(TIME);
    int year = Year(TIME);
    
    int temp = day;
    
    if (month == 12) temp = temp + 5;
    if (month == 11) temp = temp + 3;
    if (month == 10) temp = temp + 0;
    if (month == 9) temp = temp + 5;
    if (month == 8) temp = temp + 2;
    if (month == 7) temp = temp + 6;
    if (month == 6) temp = temp + 4;
    if (month == 5) temp = temp + 1;
    if (month == 4) temp = temp + 6;
    if (month == 3) temp = temp + 3;
    if (month == 2) temp = temp + 3;
    if (month == 1) temp = temp + 0;
    if (isLeapYear(year))
        if (month == 1) temp = temp + 6;
    if (isLeapYear(year))
        if (month == 2) temp = temp - 1;
    
    temp = temp + year;
    temp = temp + year / 4;
    temp = temp - year / 100;
    temp = temp + year / 400;
    
    temp = temp % 7;
    
    if (temp == 0) return "Sat";
    if (temp == 1) return "Sun";
    if (temp == 2) return "Mon";
    if (temp == 3) return "Tues";
    if (temp == 4) return "Wed";
    if (temp == 5) return "Thurs";
    return "Fri";
}


int main() {
    char* day = new char[100];
    char* month = new char[100];
    char* year = new char[100];
    char* choice = new char[100];
    
    int dayInt, monthInt, yearInt;
    
    while(1) {
        printf("Nhap ngay DAY: "); scanf("%s", day);
        printf("Nhap thang MONTH: "); scanf("%s", month);
        printf("Nhap nam YEAR: "); scanf("%s", year);
        
        dayInt = convertStringToInt(day);
        monthInt = convertStringToInt(month);
        yearInt = convertStringToInt(year);
        
        if (checkDateValid(dayInt, monthInt, yearInt)){
            break;
        } else printf("Hay nhap lai ngay, thang, nam\n");
    }
    
    int choiceInt;
    
    delete []day;
    delete []month;
    delete []year;
    
    while(1) {
        printf("Lua chon: "); scanf("%s", choice);
        choiceInt = convertStringToInt(choice);
        if (checkChoiceValid(choiceInt)){
            break;
        } else printf("Hay nhap lai ");
    }
    
    char* TIME = new char [10];
    Date(dayInt, monthInt, yearInt, TIME);
    
    if (choiceInt == 1) {
        printf("%s", Date(dayInt, monthInt, yearInt, TIME));
    }
    if (choiceInt == 2) {
        printf("A. MM/DD/YYYY\n");
        printf("B. MM DD,YYYY\n");
        printf("C. DD MM,YYYY\n");
        char type;
        printf("Nhap lua chon(A, B, C): "); scanf("%c", &type);
        printf("%s", Convert(TIME, type));
    }
    if (choiceInt == 3) {
        printf("%s", Weekday(TIME));
    }
    if (choiceInt == 4) {
        printf("%d", LeapYear(TIME));
    }
    return 0;
}
