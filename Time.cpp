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

char* getNameMonth(int month) {
    if (month == 1) return "Jan";
    if (month == 2) return "Feb";
    if (month == 3) return "Mar";
    if (month == 4) return "Apr";
    if (month == 5) return "May";
    if (month == 6) return "Jun";
    if (month == 7) return "Jul";
    if (month == 8) return "Aug";
    if (month == 9) return "Sep";
    if (month == 10) return "Oct";
    if (month == 11) return "Nov";
    return "Dec";
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
        return TIME;
    }
    int day = Day(TIME);
    int month = Month(TIME);
    int year = Year(TIME);
    
    char* temp = new char [3];
    temp = getNameMonth(month);
    
    if (type == 'B') {
        TIME[0] = temp[0];
        TIME[1] = temp[1];
        TIME[2] = temp[2];
        TIME[3] = ' ';
        TIME[4] = (day / 10) + '0';
        TIME[5] = (day % 10) + '0';
    }
    if (type == 'C') {
        TIME[0] = (day / 10) + '0';
        TIME[1] = (day % 10) + '0';
        TIME[2] = ' ';
        TIME[3] = temp[0];
        TIME[4] = temp[1];
        TIME[5] = temp[2];
    }
    
    TIME[6] = ',';
    TIME[7] = ' ';
    TIME[8] = (year / 1000) + '0';
    TIME[9] = ((year % 1000) / 100) + '0';
    TIME[10] = ((year % 100) / 10) + '0';
    TIME[11] = (year % 10) + '0';
    TIME[12] = '\0';
    
    return TIME;
}

//hàm số 6 trong yêu cầu giải quyết thao tác 4
//Kiểm tra năm nhuận
int LeapYear(char* TIME) {
    int year = Year(TIME);
    return isLeapYear(year);
}

//hàm số 7 trong yêu cầu giải quyết thao tác 5
//Tính khoảng thời gian cách biệt giữa giá trị năm
int  GetTime(char* TIME_1, char* TIME_2) {
    int year1 = Year(TIME_1);
    int year2 = Year(TIME_2);
    int day1, day2, month1 = 0, month2;
    
    if (year1 == year2) return 0;
    
    if (year1 < year2) {
        day1 = Day(TIME_1);
        month1 = Month(TIME_1);
        year1 = Year(TIME_1);
        
        day2 = Day(TIME_2);
        month2 = Month(TIME_2);
        year2 = Year(TIME_2);
    }
    
    if (year1 > year2) {
        day1 = Day(TIME_2);
        month1 = Month(TIME_2);
        year1 = Year(TIME_2);
        
        day2 = Day(TIME_1);
        month2 = Month(TIME_1);
        year2 = Year(TIME_1);
    }
    
    if (month1 < month2) return year2 - year1;
    if (month1 > month2) return year2 - year1 - 1;
    if (month1 == month2)
        if (day1 <= day2) return year2 - year1;
    
    return year2 - year1 - 1;
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

//hàm giải quyết thao tác 3
//hàm nhận chuỗi TIME và trả về 2 năm nhuận gần nhất với năm trong chuỗi TIME
//lưu ở year1 và year2
void getLeapYearNearest(char* TIME, int &year1, int &year2) {
    int year = Year(TIME);
    year1 = year2 = -1;
    
    for (int i = 1; i < 8; i++) {
        if (isLeapYear(year - i)){
            if (year1 == -1) year1 = year - i;
                else {
                    year2 = year - i;
                    return;
                }
        }
        if (isLeapYear(year + i)){
            if (year1 == -1) year1 = year + i;
            else {
                year2 = year + i;
                return;
            }
        }
    }
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
    
    char* TIME = new char [12];
    Date(dayInt, monthInt, yearInt, TIME);
    
    if (choiceInt == 1) {
        printf("%s", Date(dayInt, monthInt, yearInt, TIME));
    }
    if (choiceInt == 2) {
        printf("A. MM/DD/YYYY\n");
        printf("B. Month DD, YYYY\n");
        printf("C. DD Month, YYYY\n");
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
    if (choiceInt == 5) {
        char* temp = new char [10];
        Date(7, 4, 2018, temp);
        printf("%d", GetTime(temp, TIME));
    }
    if (choiceInt == 6) {
        int year1, year2;
        getLeapYearNearest(TIME, year1, year2);
        printf("%d %d", year1, year2);
    }
    return 0;
}
