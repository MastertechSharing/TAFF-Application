<%@ page contentType="text/html; charset=tis-620" language="java"%>
<%@ page import="java.text.NumberFormat"%>
<%@ page import="java.text.DateFormat"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.text.ParseException"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.util.Locale"%>
<%@ page import="java.util.Calendar"%>
<%@ page import="java.util.GregorianCalendar"%>

<%!	
	public String getCurrentDateTimeShow() {
		SimpleDateFormat simpleFormat = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss", new Locale("us", "us"));
		return simpleFormat.format(new Date());
	}

	public String getCurrentDateTime() {
		SimpleDateFormat simpleFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss", new Locale("us", "us"));
		return simpleFormat.format(new Date());
	}

	public String getCurrentDate() {
		SimpleDateFormat simpleFormat = new SimpleDateFormat("dd/MM/yyyy", new Locale("us", "us"));
		return simpleFormat.format(new Date());
	}

	public String getCurrentDateyyyyMMdd() {
		SimpleDateFormat simpleFormat = new SimpleDateFormat("yyyy-MM-dd ", new Locale("us", "us"));
		return simpleFormat.format(new Date());
	}

	public String getCurrentTime() {
		SimpleDateFormat simpleFormat = new SimpleDateFormat("HH:mm:ss", new Locale("us", "us"));
		return simpleFormat.format(new Date());
	}

	public String getCurrentTimeShort() {
		SimpleDateFormat simpleFormat = new SimpleDateFormat("HH:mm", new Locale("us", "us"));
		return simpleFormat.format(new Date());
	}

	public String getCurrentDateInc(int year) {
		SimpleDateFormat simpleFormat = new SimpleDateFormat("dd/MM/yyyy", new Locale("us", "us"));
		// แปลงวันที่ ให้อยู่ในรูป dd/MM/yyyy
		String result = simpleFormat.format(new Date());
		String yyyy = result.substring(6, 10);
		String mm = result.substring(3, 5);
		String dd = result.substring(0, 2);
		int y = Integer.parseInt(yyyy);
		int m = Integer.parseInt(mm);
		int d = Integer.parseInt(dd);
		// หา leap year

		if ((y % 400 == 0 || y % 4 == 0) && (y % 100 != 0 || y % 100 == 0)) {
			if (d == 29 && m == 2) {
				// ให้วันที่ ลดวันไป 1 วันเป็น 28-02 ปีถัดไป
				Calendar cal = Calendar.getInstance();
				cal.add(Calendar.DATE, -1);		// Adding -1 day to current date
				cal.add(Calendar.YEAR, year);	// Adding 1 year to current year
				result = simpleFormat.format(cal.getTime());
			} else {
				// ถ้าไม่ใช่วันที่ 29/02
				y = y + year;
				yyyy = Integer.toString(y);
				result = dd + "/" + mm + "/" + yyyy;
			}
		} else {
			// ถ้าไม่ใช่ปีที่มี วันที่ 29/02
			y = y + year;
			yyyy = Integer.toString(y);
			result = dd + "/" + mm + "/" + yyyy;
		}
		return result;
	}

	public String getCurrentDateDec() {
		SimpleDateFormat simpleFormat = new SimpleDateFormat("dd/MM/yyyy", new Locale("us", "us"));
		// แปลงวันที่ ให้อยู่ในรูป dd/MM/yyyy
		String mydate = simpleFormat.format(new Date());
		String yyyy = mydate.substring(6, 10);
		String mm = mydate.substring(3, 5);
		String dd = mydate.substring(0, 2);
		int y = Integer.parseInt(yyyy);
		int m = Integer.parseInt(mm);
		int d = Integer.parseInt(dd);
		// หา leap year

		if ((y % 400 == 0 || y % 4 == 0) && (y % 100 != 0 || y % 100 == 0)) {
			if (d == 29 && m == 2) {
				// ให้วันที่ ลดวันไป 1 วันเป็น 28-02 ปีถัดไป
				Calendar cal = Calendar.getInstance();
				cal.add(Calendar.DATE, -1); // Adding -1 day to current date
				cal.add(Calendar.YEAR, 1); // Adding 1 year to current year
				mydate = simpleFormat.format(cal.getTime());
			} else {
				// ถ้าไม่ใช่วันที่ 29/02
				y = y + 1;
				m = m - 3;
				mm = Integer.toString(m);
				yyyy = Integer.toString(y);
				mydate = dd + "/" + mm + "/" + yyyy;
			}
		} else {
			// ถ้าไม่ใช่ปีที่มี วันที่ 29/02
			y = y + 1;
			m = m - 3;
			mm = Integer.toString(m);
			yyyy = Integer.toString(y);
			mydate = dd + "/" + mm + "/" + yyyy;
		}
		return mydate;
	}

	public String incDayCalendar(String dateNow, int n) {
		SimpleDateFormat simpleFormat = new SimpleDateFormat("yyyy-MM-dd", Locale.US);
		GregorianCalendar thisday = new GregorianCalendar();
		try {
			thisday.setTime(simpleFormat.parse(dateNow));
			thisday.add(GregorianCalendar.DATE, n);
			dateNow = simpleFormat.format(thisday.getTime());
		} catch (Exception e) {

		}
		return dateNow;					
	}
	
	public String decDayCalendar(String dateNow, int n) {
		SimpleDateFormat simpleFormat = new SimpleDateFormat("yyyy-MM-dd", Locale.US);
		GregorianCalendar thisday = new GregorianCalendar();
		try {
			thisday.setTime(simpleFormat.parse(dateNow));
			thisday.add(GregorianCalendar.DATE, -n);
			dateNow = simpleFormat.format(thisday.getTime());
		} catch (Exception e) {

		}
		return dateNow;			
	}

	public String dateToYMD(String dateStr) {
		// dateStr = dd/mm/yyyy
		String dd = dateStr.substring(0, 2);
		String mm = dateStr.substring(3, 5);
		String yyyy = dateStr.substring(6, 10);
		return yyyy + "-" + mm + "-" + dd;
	}

	public String dateToYYYYMMDD(String dateStr) {
		// dateStr = dd/mm/yyyy
		String dd = dateStr.substring(0, 2);
		String mm = dateStr.substring(3, 5);
		String yyyy = dateStr.substring(6, 10);
		return yyyy + "/" + mm + "/" + dd;
	}

	public String dateToDMY(String dateStr) {
		// dateStr = dd-mm-yyyy
		String dd = dateStr.substring(0, 2);
		String mm = dateStr.substring(3, 5);
		String yyyy = dateStr.substring(6, 10);
		return dd + "/" + mm + "/" + yyyy;
	}

	// 16-02-2558 เพิ่มฟังก์ชัน dateToYMDTime
	public String dateToYMDTime(String dateStr) {
		// dateStr = dd/mm/yyyy hh:mm:ss
		String dd = dateStr.substring(0, 2);
		String mm = dateStr.substring(3, 5);
		String yyyy = dateStr.substring(6, 10);
		String times = dateStr.substring(11, 19);
		return yyyy + "-" + mm + "-" + dd + " " + times;
	}

	public String YMDTodate(String dateStr) {
		// dateStr = yyyy-mm-dd
		String yyyy = dateStr.substring(0, 4);
		String mm = dateStr.substring(5, 7);
		String dd = dateStr.substring(8, 10);
		return dd + "/" + mm + "/" + yyyy;
	}

	public String YMDToYYYYMMDD(String dateStr) {	//	yyyy-mm-dd > yyyymmdd
		// dateStr = yyyy-mm-dd
		String yyyy = dateStr.substring(0, 4);
		String mm = dateStr.substring(5, 7);
		String dd = dateStr.substring(8, 10);
		return yyyy + mm + dd;
	}

	public String YMDToDDMMYYYY(String dateStr) {	//	yyyy-mm-dd > ddmmyyyy
		// dateStr = yyyy-mm-dd
		String yyyy = dateStr.substring(0, 4);
		String mm = dateStr.substring(5, 7);
		String dd = dateStr.substring(8, 10);
		return dd + mm + yyyy;
	}

	public String TimeToHHMM(String dateStr) {		//	HH:MM > HHMM
		// dateStr = hh:mm:ss
		String hh = dateStr.substring(0, 2);
		String mm = dateStr.substring(3, 5);
		return hh + mm;
	}

	public String TimeToHHMMSS(String dateStr) {	//	HH:MM:SS > HHMMSS
		// dateStr = hh:mm:ss
		String hh = dateStr.substring(0, 2);
		String mm = dateStr.substring(3, 5);
		String ss = dateStr.substring(6, 8);
		return hh + mm + ss;
	}

	public String DateTimeToYYYYMMDDHHMMSS(String dateStr) {
		// dateStr = yyyy-mm-dd hh:mm:ss
		String yyyymmdd = YMDToYYYYMMDD(dateStr.substring(0, 10));
		String hh = dateStr.substring(11, 13);
		String mm = dateStr.substring(14, 16);
		String ss = dateStr.substring(17, 19);
		return yyyymmdd + hh + mm + ss;
	}

	public int getDayOfWeek(String dateStr) {
		int result = 0;
		SimpleDateFormat simpleFormat = new SimpleDateFormat("yyyy-MM-dd", Locale.US); // ใหม่
		try {
			Calendar cal = Calendar.getInstance();
			cal.setTime(simpleFormat.parse(dateStr));
			result = cal.get(Calendar.DAY_OF_WEEK);
		} catch (Exception e) {

		}
		return result;
	}

	public String getDay(int dd, String lang) {
		String th_day[] = { "อาทิตย์", "จันทร์", "อังคาร", "พุธ", "พฤหัส", "ศุกร์", "เสาร์", "หยุด" };
		String en_day[] = { "Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Holi" };
		String result = "";
		if (lang.equals("th")) {
			result = th_day[dd - 1];
		} else {
			result = en_day[dd - 1];
		}
		return result;
	}

	public String intToStrShortDate(int dd, String lang) {
		String[] strDateTH = { "อา.", "จ.", "อ.", "พ.", "พฤ.", "ศ.", "ส.", "ฮ." };
		String[] strDateEn = { "Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Hol" };
		String result = "";
		if (lang.equals("th")) {
			result = strDateTH[dd];
		} else {
			result = strDateEn[dd];
		}
		return result;
	}

	public String getShortDay(int dd, String lang) {
		String th_day[] = { "อา.", "จ.", "อ.", "พ.", "พฤ.", "ศ.", "ส." };
		String en_day[] = { "Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat" };
		String result = "";
		if (lang.equals("th")) {
			result = th_day[dd - 1];
		} else {
			result = en_day[dd - 1];
		}
		return result;
	}

	public String getLongDay(int dd, String lang) {
		String th_day[] = { "วันอาทิตย์", "วันจันทร์", "วันอังคาร", "วันพุธ", "วันพฤหัสบดี", "วันศุกร์", "วันเสาร์",
				"วันหยุด" };
		String en_day[] = { "Sunday", "Monday", "Tuesday", "Wednesday", "Thurday", "Friday", "Saturday", "Holiday" };
		String result = "";
		if (lang.equals("th")) {
			result = th_day[dd - 1];
		} else {
			result = en_day[dd - 1];
		}
		return result;
	}

	public String getShortMonth(int mm, String lang) {
		String th_month[] = { "ม.ค.", "ก.พ.", "มี.ค.", "เม.ย.", "พ.ค.", "มิ.ย.", "ก.ค.", "ส.ค.", "ก.ย.", "ต.ค.", "พ.ย.",
				"ธ.ค." };
		String en_month[] = { "Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec" };
		String result = "";
		if (lang.equals("th")) {
			result = th_month[mm - 1];
		} else {
			result = en_month[mm - 1];
		}
		return result;
	}

	public String getLongMonth(int mm, String lang) {
		String th_month[] = { "มกราคม", "กุมภาพันธ์", "มีนาคม", "เมษายน", "พฤษภาคม", "มิถุนายน", "กรกฎาคม", "สิงหาคม",
				"กันยายน", "ตุลาคม", "พฤศจิกายน", "ธันวาคม" };
		String en_month[] = { "January", "Febuary", "March", "April", "May", "June", "July", "August", "September",
				"October", "November", "December" };
		String result = "";
		if (lang.equals("th")) {
			result = th_month[mm - 1];
		} else {
			result = en_month[mm - 1];
		}
		return result;
	}

	public String getTime(String time, int pos) {
		try {
			String result = "";
			switch (pos) {
			case 1:
				result = time.substring(0, 2);
				break;
			case 2:
				result = time.substring(2, 4);
				break;
			case 3:
				result = time.substring(4, 6);
				break;
			case 4:
				result = time.substring(6, 8);
				break;
			}
			return result;
		} catch (Exception e) {
			return "";
		}
	}

	public String getTimeSec(String time, int pos) {
		try {
			String result = "";
			switch (pos) {
			case 1:
				result = time.substring(0, 2);
				break;
			case 2:
				result = time.substring(2, 4);
				break;
			case 3:
				result = time.substring(4, 6);
				break;
			case 4:
				result = time.substring(7, 9);
				break;
			case 5:
				result = time.substring(9, 11);
				break;
			case 6:
				result = time.substring(11, 13);
				break;
			}
			return result;
		} catch (Exception e) {
			return "";
		}
	}

	public String changeTime(String time) {
		try {
			return time.substring(0, 2) + ":" + time.substring(2, 4) + "-" + time.substring(4, 6) + ":"
					+ time.substring(6, 8);
		} catch (Exception e) {
			return "&nbsp;";
		}
	}

	public String changeTimeSec(String time) {
		try {
			return time.substring(0, 2) + ":" + time.substring(2, 4) + ":" + time.substring(4, 6) + "-"
					+ time.substring(7, 9) + ":" + time.substring(9, 11) + ":" + time.substring(11, 13);
		} catch (Exception e) {
			return "&nbsp;";
		}
	}

	public int LastDay(String m, String y, String format) {
		int i;
		for (i = 29; i <= 32; i++) {
			if (!(validateDate2(m, i, y, format))) {
				break;
			}
		}
		return i - 1;
	}

	public int dateToIntYYYYMMDD(String date) {	//	dd/mm/yyyy > yyyymmdd
		return Integer.parseInt(date.substring(6, 10) + date.substring(3, 5) + date.substring(0, 2));
	}
	
	public int valueToInt(String value) {
		int result = 0;
		try {
			result = Integer.parseInt(value);
		} catch (Exception e) {
		}
		return result;
	}

	public boolean isValidDate(String value) {
		DateFormat dateF = new SimpleDateFormat("dd/MM/yyyy");
		try {
			dateF.setLenient(false);
			dateF.parse(value);
		} catch (ParseException e) {
			return false;
		} catch (Exception e) {
			return false;
		}
		return true;
	}

	public boolean isValidDateParseFormat(String value, String format) {
		DateFormat dateF = new SimpleDateFormat(format);
		try {
			dateF.setLenient(false);
			dateF.parse(value);
		} catch (ParseException e) {
			return false;
		} catch (Exception e) {
			return false;
		}
		return true;
	}

	public boolean validateDate(String dateStr) {
		String formatStr = "dd/MM/yyyy";
		if (formatStr == null)
			return false; // or throw some kinda exception, possibly a
							// InvalidArgumentException
		SimpleDateFormat df = new SimpleDateFormat(formatStr, new Locale("us", "us"));
		Date dates = null;
		try {
			dates = df.parse(dateStr);
		} catch (ParseException e) {
			// invalid date format
			return false;
		}
		// now test for legal values of parameters
		if (!df.format(dates).equals(dateStr)) {
			return false;
		} else {
			return true;
		}
	}

	public boolean validateDate2(String m, int i, String y, String formatStr) {
		if (formatStr == null)
			return false; // or throw some kinda exception, possibly a
							// InvalidArgumentException
		SimpleDateFormat df = new SimpleDateFormat(formatStr, new Locale("us", "us"));
		Date dates = null;
		String dateStr = m + "/" + Integer.toString(i) + "/" + y;
		try {
			dates = df.parse(dateStr);
		} catch (ParseException e) {
			// invalid date format
			return false;
		}
		if (!df.format(dates).equals(dateStr)) {
			return false;
		} else {
			return true;
		}
	}

	public String validateDate3(String dateStr, String formatStr) {
		SimpleDateFormat df = new SimpleDateFormat(formatStr, new Locale("us", "us"));
		SimpleDateFormat df1 = new SimpleDateFormat("E MM/dd/yyyy", new Locale("us", "us"));
		Date dates = null;
		String d = "";
		try {
			dates = df.parse(dateStr);
			d = df1.format(dates);
			return d;
		} catch (Exception e) {
			// invalid date format
			return "error";
		}
	}

	public String validateDateCal(String dateStr, String formatStr) {
		SimpleDateFormat df = new SimpleDateFormat(formatStr, new Locale("us", "us"));
		SimpleDateFormat df1 = new SimpleDateFormat("E dd/MM/yyyy", new Locale("us", "us"));
		String result = "";
		try {
			Date dates = df.parse(dateStr);
			result = df1.format(dates);
			return result;
		} catch (Exception e) {
			return "error";
		}
	}

	public double convertHourToSec(String time, String sign) {
		double result = 0;
		String[] time_arr = time.split(sign);
		int len = time_arr.length - 1;
		int time_int = 0;
		for (int i = 0; i < time_arr.length; i++) {
			time_int = Integer.parseInt(time_arr[i]);
			result = result + (time_int * Math.pow(60, len--));
		}
		return result;
	}// ชั่วโมง-> นาที รับเวลา HH:mm:ss หรือ HH:mm แล้วรับ ":" เข้ามา

	public String displayTimePerDay(double time, String hourDay) {
		String result = "";
		int time_int = (int) time;
		int time_work = (int) convertHourToSec(hourDay, ":");
		int time_div = time_int / time_work;
		int time_mod = time_int % time_work;
		result = time_div + "/" + doubleToTime(time_mod);
		return result;
	}

	public String doubleToTime(double value) {
		String result = "";
		int[] number = new int[3];
		double num = 0.0;
		for (int i = 2; i > 0; i--) {
			num = value / (Math.pow(60, i));
			value = value % (Math.pow(60, i));
			number[i] = (int) num;
			if (i == 1) {
				number[i - 1] = (int) value;
			}
		}
		for (int j = number.length - 1; j >= 0; j--) {
			if (number[j] < 10) {
				result = result + "0" + number[j];
			} else {
				result = result + number[j];
			}
			if (j != 0) {
				result = result + ":";
			}
		}
		return result;
	}// เปลี่ยนตัวเลขเป็นสตริง

	public double differentTime(String timeFirst, String timeLast) {
		double result = 0.0;
		if (timeFirst == "" || timeLast == "") {
			result = 0.0;
		} else {
			double num = convertHourToSec(timeFirst, ":");
			double num1 = convertHourToSec(timeLast, ":");
			if (timeFirst.compareTo(timeLast) < 0) {
				result = num1 - num;
			}
		}
		return result;
	}

	public String compareTimeToString(String timeFirst, String timeLast) {
		String result = "--:--:--";
		if (!timeFirst.equals("") && !timeLast.equals("")) {
			double num = convertHourToSec(timeFirst, ":");
			double num1 = convertHourToSec(timeLast, ":");
			if (timeFirst.compareTo(timeLast) < 0) {
				result = doubleToTime(num1 - num);
			}
		}
		return result;
	}// คืนเวลาที่สาย

	public boolean compareTime(String hh1, String mm1, String hh2, String mm2) {
		try {
			int time1 = Integer.parseInt(hh1 + mm1);
			int time2 = Integer.parseInt(hh2 + mm2);
			if (time1 > time2) {
				return true;
			} else {
				return false;
			}
		} catch (Exception e) {
			return true;
		}
	}

	public boolean compareTimeSec(String hh1, String mm1, String ss1, String hh2, String mm2, String ss2) {
		try {
			int time1 = Integer.parseInt(hh1 + mm1 + ss1);
			int time2 = Integer.parseInt(hh2 + mm2 + ss2);
			if (time1 > time2) {
				return true;
			} else {
				return false;
			}
		} catch (Exception e) {
			return true;
		}
	}

	public boolean compareDate(String st_date, String ex_date) {
		try {
			String new_stdate = st_date.substring(6, 10) + st_date.substring(3, 5) + st_date.substring(0, 2);
			String new_exdate = ex_date.substring(6, 10) + ex_date.substring(3, 5) + ex_date.substring(0, 2);
			int stDate = Integer.parseInt(new_stdate);
			int exDate = Integer.parseInt(new_exdate);
			if (stDate > exDate) {
				return true;
			} else {
				return false;
			}
		} catch (Exception e) {
			return true;
		}
	}

	public long longDiffOfDays(String sDate) {
		Calendar cal = Calendar.getInstance(Locale.US);
		int day = cal.get(Calendar.DATE);
		int month = cal.get(Calendar.MONTH) + 1;
		int year = cal.get(Calendar.YEAR);

		int tmpYear = Integer.parseInt(sDate.substring(0, 4));
		int tmpMonth = Integer.parseInt(sDate.substring(5, 7));
		int tmpDate = Integer.parseInt(sDate.substring(8, 10));

		Calendar ca1 = Calendar.getInstance();
		Calendar ca2 = Calendar.getInstance();
		// Set the date for both of the calendar to get difference
		ca1.set(year, month, day); // วันที่ปัจจุบัน
		ca2.set(tmpYear, tmpMonth, tmpDate); // วันที่สิ้นสุด หรือ หมดอายุ บัตร
		// Get date in milliseconds
		long milisecond1 = ca1.getTimeInMillis();
		long milisecond2 = ca2.getTimeInMillis();
		// Find date difference in milliseconds
		long diffInMSec = milisecond2 - milisecond1;

		// Find date difference in days
		// (24 hours 60 minutes 60 seconds 1000 millisecond)
		long diffOfDays = diffInMSec / (24 * 60 * 60 * 1000);

		return diffOfDays;
	}	
%>