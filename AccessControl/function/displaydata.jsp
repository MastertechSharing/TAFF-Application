<%@ page contentType="text/html; charset=tis-620" language="java"%>

<%!		

	public String displayColorStr(String data, String lang) {
		String th_color[] = { "ขาว", "แดง", "เขียว", "เหลือง" };
		String en_color[] = { "White", "Red", "Green", "Yellow" };
		String result = "";
		int dataI = 0;
		try {
			dataI = Integer.parseInt(data);
		} catch (Exception e) {

		}
		if (lang.equals("th")) {
			result = th_color[dataI];
		} else {
			result = en_color[dataI];
		}
		return result;
	}

	public String displayLanguage(String data, String lang) {
		String result = "";
		if (lang.equals("th")) {
			if (data.equals("0")) {
				result = "ภาษาไทย";
			} else if (data.equals("1")) {
				result = "ภาษาอังกฤษ";
			}
		} else {
			if (data.equals("0")) {
				result = "Thai";
			} else if (data.equals("1")) {
				result = "English";
			}
		}
		return result;
	}	

	public String displayActive(String data, String lang) {
		String result = "";
		if (lang.equals("th")) {
			if (data.equals("0")) {
				result = "ไม่ทำงาน";
			} else if (data.equals("1")) {
				result = "ทำงาน";
			}
		} else {
			if (data.equals("0")) {
				result = "Inactive";
			} else if (data.equals("1")) {
				result = "Active";
			}
		}
		return result;
	}

	public String displayWriteOnCard(String data, String lang) {
		String result = "";
		if (lang.equals("th")) {
			if (data.equals("0")) {
				result = "ไม่เขียน";
			} else if (data.equals("1")) {
				result = "เขียนบัตรหลังจากตรวจสอบสิทธิ์";
			} else if (data.equals("2")) {
				result = "เขียนบัตรก่อนตรวจสอบสิทธิ์";
			}
		} else {
			if (data.equals("0")) {
				result = "Inactive";
			} else if (data.equals("1")) {
				result = "After Check Right";
			} else if (data.equals("2")) {
				result = "Before Check Right";
			}
		}
		return result;
	}
	
	public String displayWriteTransLoop(String data, String lang) {
		String result = "";
		if (lang.equals("th")) {
			if(data.equals("0")){
				result = "เขียนวนทับไม่ได้";
			}else if(data.equals("1")){
				result = "เขียนวนทับได้";
			}
		} else {
			if(data.equals("0")){
				result = "Inactive";
			}else if(data.equals("1")){
				result = "Active";
			}
		}
		return result;
	}
	
	public String displayTZ0Unlock(String data, String lang) {
		String result = "";
		if (lang.equals("th")) {
			if(data.equals("0")){
				result = "ไม่เปิดประตู";
			}else if(data.equals("1")){
				result = "เปิดประตู";
			}
		} else {
			if(data.equals("0")){
				result = "No Open Door";
			}else if(data.equals("1")){
				result = "Open Door";
			}
		}
		return result;
	}
	
	public String displayActiveKeyPad(String data, String lang) {
		String result = "";
		if (lang.equals("th")) {
			if (data.equals("0")) {
				result = "กดไม่ได้";
			} else if (data.equals("1")) {
				result = "กดได้";
			} else if (data.equals("2")) {
				result = "กดคีย์บอร์ดอย่างเดียว";
			}
		} else {
			if (data.equals("0")) {
				result = "Inactive";
			} else if (data.equals("1")) {
				result = "Active";
			} else if (data.equals("2")) {
				result = "Key Active Only";
			}
		}
		return result;
	}
	
	public String displayStatusIO(String data, String lang) {
		String result = "";
		if (lang.equals("th")) {
			if (data.equals("I")) {
				result = "เข้า";
			} else if (data.equals("O")) {
				result = "ออก";
			}
		} else {
			if (data.equals("I")) {
				result = "In";
			} else if (data.equals("O")) {
				result = "Out";
			}
		}
		return result;
	}
	
	public String displayActiveKeyDuty(String data, String lang) {
		String result = "";
		if (lang.equals("th")) {
			if(data.equals("0")){
				result = "Active View Only";
			}else if(data.equals("1")){
				result = "Active Duty & View";
			}else if(data.equals("2")){
				result = "Inactive Duty & View";
			}else if(data.equals("3")){
				result = "Active Duty Only";
			}
		} else {
			if(data.equals("0")){
				result = "Active View Only";
			}else if(data.equals("1")){
				result = "Active Duty & View";
			}else if(data.equals("2")){
				result = "Inactive Duty & View";
			}else if(data.equals("3")){
				result = "Active Duty Only";
			}
		}
		return result;
	}

	public String displaySecurity(String data, String lang) {
		String result = "";
		if (lang.equals("th")) {
			if (data.equals("0")) {
				result = "ปิด";
			} else if (data.equals("1")) {
				result = "เปิด";
			}
		} else {
			if (data.equals("0")) {
				result = "Off";
			} else if (data.equals("1")) {
				result = "On";
			}
		}
		return result;
	}
	
	public String displayProx(String data, String lang) {
		String result = "";
		if (lang.equals("th")) {
			if (data.equals("0")) {
				result = "Card Number Only";
			} else if (data.equals("1")) {
				result = "Facility Code + Card Number";
			}
		} else {
			if (data.equals("0")) {
				result = "Card Number Only";
			} else if (data.equals("1")) {
				result = "Facility Code + Card Number";
			}
		}
		return result;
	}

	public String displayRd2Mode(String data, String lang) {
		String result = "";
		if (lang.equals("th")) {
			if (data.equals("0")) {
				result = "หัวอ่านสำรอง";
			} else if (data.equals("1")) {
				result = "หัวอ่านหลัก";
			}
		} else {
			if (data.equals("0")) {
				result = "Secondary Reader";
			} else if (data.equals("1")) {
				result = "Primary Reader";
			}
		}
		return result;
	}
	
	public String displayCompareMode(String data) {
		String result = "";
		if (data.equals("0")) {
			result = "Card Pattern Only";
		} else if (data.equals("1")) {
			result = "Card Pattern+Timezone";
		} else if (data.equals("2")) {
			result = "Card Pattern+Timezone (Offline)";
		} else if (data.equals("3")) {
			result = "Card Pattern+Timezone (Online)";
		}
		return result;
	}

	public String displayConfigGPRS(String data) {
		String result = "";
		if (data.equals("0")) {
			result = "Disable";
		} else if (data.equals("1")) {
			result = "AIS(mtt)";
		} else if (data.equals("2")) {
			result = "AIS(internet)";
		} else if (data.equals("3")) {
			result = "True(internet)";
		} else if (data.equals("4")) {
			result = "Dtac(www.dtac.co.th)";
		}
		return result;
	}

	public String displayAlarmMode(String data) {
		String result = "";
		if (data.equals("0")) {
			result = "Internal Buzzer";
		} else if (data.equals("1")) {
			result = "OUT2";
		}
		return result;
	}

	public String displayAccessMode(String data) {
		String result = "";
		if (data.equals("0")) {
			result = "Internal(CRU)";
		} else if (data.equals("1")) {
			result = "External(MU)";
		}
		return result;
	}

	public String displayReaderType(String data) {
		String result = "";
		if (data.equals("0")) {
			result = "Standard";
		} else if (data.equals("1")) {
			result = "Finger";
		} else if (data.equals("2")) {
			result = "Palm vein";
		}
		return result;
	}

	public String displayReaderFunc(String data) {
		String result = "";
		if (data.equals("0")) {
			result = "Access";
		} else if (data.equals("1")) {
			result = "Time Attendance";
		} else if (data.equals("2")) {
			result = "Safety";
		}
		return result;
	}

	public String displayUser(String data) {
		String result = "";
		if (data.equals("0")) {
			result = "Administrator";
		} else if (data.equals("1")) {
			result = "Manager";
		} else if (data.equals("2")) {
			result = "User [Manager]";
		} else if (data.equals("3")) {
			result = "Personnel";
		} else if (data.equals("4")) {
			result = "User [Personnel]";
		} else if (data.equals("5")) {
			result = "Supervisor";
		} else if (data.equals("6")) {
			result = "User [Supervisor]";
		} else if (data.equals("7")) {
			result = "Monitor View";
		} else {
			result = "User";
		}
		return result;
	}	
	
	public String displayFaceIdentifyMode(String data) {
		String result = "";
		//String[] identifyMode = { "Face", "Card and Face", "Card or Face", "Card", "ID and Face", "ID or Face", "ID and Card", "ID or Card", "Default Device", "ID and Pin" };
		if (data.equals("0")) {
			result = "Face";
		} else if (data.equals("1")) {
			result = "Card and Face";
		} else if (data.equals("2")) {
			result = "Card or Face";
		} else if (data.equals("3")) {
			result = "Card";
		} else if (data.equals("4")) {
			result = "ID and Face";
		} else if (data.equals("5")) {
			result = "ID or Face";
		} else if (data.equals("6")) {
			result = "ID and Card";
		} else if (data.equals("7")) {
			result = "ID or Card";
		} else if (data.equals("8")) {
			result = "Default Device";
		} else if (data.equals("9")) {
			result = "ID and Pin";
		}
		return result;
	}

	// -----textmessage menu config about [set]-----//
	public String displayTextAlert(String status, String times, String lang, String cmd) {
		String result = "";
		String displaytxt = "";
		if (lang.equals("th")) {
			switch (Integer.parseInt(status)) {
			case 1:
				if (cmd.equals("30")) {
					displaytxt = "เพิ่มประตู";
				} else if (cmd.equals("32")) {
					displaytxt = "เพิ่มช่วงเวลาเข้า-ออก";
				} else if (cmd.equals("34")) {
					displaytxt = "เพิ่มวันหยุด";
				} else if (cmd.equals("60")) {
					displaytxt = "เพิ่มหัวอ่าน";
				} else if (cmd.equals("72")) {
					displaytxt = "เพิ่มหมายประตู";
				} else if (cmd.equals("93")) {
					displaytxt = "เพิ่มรหัสงาน";
				}
				result = "<span style='font-family: tahoma;font-size: 12px; color:#00CC33;' onmouseover=this.style.cursor='hand' title='"
						+ times + "'> [ " + displaytxt + " ]</span>";
				break;
			case 2:
				if (cmd.equals("30")) {
					displaytxt = "แก้ไขประตู";
				} else if (cmd.equals("31")) {
					displaytxt = "แก้ไขเหตุการณ์";
				} else if (cmd.equals("32")) {
					displaytxt = "แก้ไขช่วงเวลาเข้า-ออก";
				} else if (cmd.equals("33")) {
					displaytxt = "แก้ไขช่วงเวลาปลดล็อคประตู";
				} else if (cmd.equals("34")) {
					displaytxt = "แก้ไขวันหยุด";
				} else if (cmd.equals("35")) {
					displaytxt = "แก้ไขช่วงเวลาล็อคประตู";
				} else if (cmd.equals("39")) {
					displaytxt = "แก้ไขช่วงเวลาปลดล็อค Output 4";
				} else if (cmd.equals("60")) {
					displaytxt = "แก้ไขหัวอ่าน";
				} else if (cmd.equals("72")) {
					displaytxt = "แก้ไขหมายเลขประตู";
				} else if (cmd.equals("93")) {
					displaytxt = "แก้ไขรหัสงาน";
				}
				result = "<span style='font-family: tahoma;font-size: 12px; color:#CC0000;' onmouseover=this.style.cursor='hand' title='"
						+ times + "'> [ " + displaytxt + " ]</span>";
				break;
			case 3:
				if (cmd.equals("32")) {
					displaytxt = "ลบช่วงเวลาเข้า-ออก";
				} else if (cmd.equals("34")) {
					displaytxt = "ลบวันหยุด";
				} else if (cmd.equals("93")) {
					displaytxt = "ลบรหัสงาน";
				}
				result = "<span style='font-family: tahoma;font-size: 12px; color:#CC0000;' onmouseover=this.style.cursor='hand' title='"
						+ times + "'> [ " + displaytxt + " ]</span>";
				break;
			}
		} else {
			switch (Integer.parseInt(status)) {
			case 1:
				if (cmd.equals("30")) {
					displaytxt = "Add Door";
				} else if (cmd.equals("32")) {
					displaytxt = "Add Timezone";
				} else if (cmd.equals("34")) {
					displaytxt = "Add Holiday";
				} else if (cmd.equals("60")) {
					displaytxt = "Add Reader";
				} else if (cmd.equals("72")) {
					displaytxt = "Add Door Id";
				} else if (cmd.equals("93")) {
					displaytxt = "Add Work Code";
				}
				result = "<span style='font-family: tahoma;font-size: 12px; color:#00CC33;' onmouseover=this.style.cursor='hand' title='"
						+ times + "'> [ " + displaytxt + " ]</span>";
				break;
			case 2:
				if (cmd.equals("30")) {
					displaytxt = "Edit Door";
				} else if (cmd.equals("31")) {
					displaytxt = "Edit Event";
				} else if (cmd.equals("32")) {
					displaytxt = "Edit Timezone";
				} else if (cmd.equals("33")) {
					displaytxt = "Edit Unlock";
				} else if (cmd.equals("34")) {
					displaytxt = "Edit Holiday";
				} else if (cmd.equals("35")) {
					displaytxt = "Edit Lock";
				} else if (cmd.equals("39")) {
					displaytxt = "Edit Time_output4";
				} else if (cmd.equals("60")) {
					displaytxt = "Edit Reader";
				} else if (cmd.equals("72")) {
					displaytxt = "Edit Door Id";
				} else if (cmd.equals("93")) {
					displaytxt = "Edit Work Code";
				}
				result = "<span style='font-family: tahoma;font-size: 12px; color:#CC0000;' onmouseover=this.style.cursor='hand' title='"
						+ times + "'> [ " + displaytxt + " ]</span>";
				break;
			case 3:
				if (cmd.equals("32")) {
					displaytxt = "Delete Timezone";
				} else if (cmd.equals("34")) {
					displaytxt = "Delete Holiday";
				} else if (cmd.equals("93")) {
					displaytxt = "Delete Work Code";
				}
				result = "<span style='font-family: tahoma;font-size: 12px; color:#CC0000;' onmouseover=this.style.cursor='hand' title='"
						+ times + "'> [ " + displaytxt + " ]</span>";
				break;
			}
		}
		return result;
	}

	public String chkFileDisplayImg(String page, String sortable, String sortcol) {
		String result = "";
		if (page.equals("location")) {
			if (sortable.equals("1")) { // asc
				if ((sortcol.equals("1")) || (sortcol.equals("2")) || (sortcol.equals("3"))) {
					result = "images/column-asc.png";
				} else {
					result = "images/column-sortable.png";
				}
			} else if (sortable.equals("2")) { // desc
				if ((sortcol.equals("1")) || (sortcol.equals("2")) || (sortcol.equals("3"))) {
					result = "images/column-desc.png";
				} else {
					result = "images/column-sortable.png";
				}
			}
		}
		return result;
	}

	public String displayImg(int group_img) {
		String img = "";
		switch (group_img) {
		case 1:
			img = "images/door_open.gif";
			break;
		case 2:
			img = "images/door_alarm.gif";
			break;
		case 3:
			img = "images/door_alert.gif";
			break;
		case 4:
			img = "images/door_disconnect.gif";
			break;
		case 5:
			img = "images/door_switch.gif";
			break;
		case 6:
			img = "images/door_stop.gif";
			break;
		case 7:
			img = "images/door_unplug.gif";
			break;
		default:
			img = "images/door_close.gif";
			break;
		}
		return img;
	}

	public String displayText(int group_img, String lang) {
		String result = "";
		if (lang.equals("th")) {
			switch (group_img) {
			case 0:
				result = "ประตูปิด";
				break;
			case 1:
				result = "ประตูเปิด";
				break;
			case 2:
				result = "สัญญานแจ้งเตือน";
				break;
			case 3:
				result = "การแตะบัตรไม่ถูกต้อง";
				break;
			case 4:
				result = "ติดต่อเซิฟเวอร์ไม่ได้";
				break;
			case 5:
				result = "การกดปุ่ม";
				break;
			case 6:
				result = "ระบบไฟฟ้าหยุดทำงาน";
				break;
			case 7:
				result = "เครื่องถูกถอดออกจากที่ติดตั้ง";
				break;
			}
		} else {
			switch (group_img) {
			case 0:
				result = "Close Door";
				break;
			case 1:
				result = "Open Door";
				break;
			case 2:
				result = "Alarm Door";
				break;
			case 3:
				result = "Transaction Error";
				break;
			case 4:
				result = "Disconnect Server";
				break;
			case 5:
				result = "Switch Press";
				break;
			case 6:
				result = "Door Stop";
				break;
			case 7:
				result = "Door Unplug";
				break;
			}
		}
		return result;
	}
	
	public String showTransBlank3(String data){
		String result = "";
		try{
			switch(Integer.parseInt(data)){
				case 0 : result = "No Update"; break;
				case 1 : result = "MU or Finger Success"; break;
				case 2 : result = "Palm Success"; break;
				case 3 : result = "Delete Success"; break;
				case 4 : result = "Memory Full"; break;
				case 5 : result = "Memory Error"; break;
				case 6 : result = "Finger or Palm Module Error"; break;
				case 7 : result = "Delete Error"; break;
				case 8 : result = "Time Out"; break;
				case 9 : result = "Offline"; break;
			}
		}catch(Exception e){
			switch(data.charAt(0)){
				case 'A' : result = "Fail Last Update ID Fail"; break;
				case 'B' : result = "Fail Last Update TPL Fail"; break;
				case 'C' : result = "Fingerprint Table Fail"; break;
			}
		}
		return result;
	}

	public String getUseOrNotUse(String value, String lang) {
		String result = "";
		if (value == null || value.equals("null") || value.equals("")) {
			value = "0";
		}
		if (lang.equals("th")) {
			if (value.equals("0")) {
				result = "ไม่ใช้";
			} else {
				result = "ใช้";
			}
		} else {
			if (value.equals("0")) {
				result = "Not Use";
			} else {
				result = "Use";
			}
		}
		return result;
	}

	public String getYesOrNo(String value, String lang) {
		String result = "";
		if (value == null || value.equals("null") || value.equals("")) {
			value = "0";
		}
		if (lang.equals("th")) {
			if (value.equals("0")) {
				result = "ไม่มี";
			} else {
				result = "มี";
			}
		} else {
			if (value.equals("0")) {
				result = "No";
			} else {
				result = "Yes";
			}
		}
		return result;
	}	
	
	public String checkImgValue(String data) {
		String result = "";
		try {
			if (data.equals("1")){	
				result = "images/checkbox_ch.png";
			} else {
				result = "images/checkbox_un.png";
			}
		} catch (Exception e) {
			result = "images/checkbox_un.png";
		}	
		return result;
	}

	public String checkImgAtPos(String data, int position) {
		String result = "";
		try {
			if (data.charAt(position) == '1') {
				result = "<img src=\"images/checkbox_ch.png\" width='20' height='20'>";
			} else {
				result = "<img src=\"images/checkbox_un.png\" width='20' height='20'>";
			}
		} catch (Exception e) {
			result = "<img src=\"images/checkbox_un.png\" width='20' height='20'>";
		}
		return result;
	}

	public String checkImgAtPosY(String data, int position) {
		String result = "";
		try {
			if (data.charAt(position) == 'Y') {
				result = "<img src=\"images/checkbox_ch.png\" width='20' height='20'>";
			} else {
				result = "<img src=\"images/checkbox_un.png\" width='20' height='20'>";
			}
		} catch (Exception e) {
			result = "<img src=\"images/checkbox_un.png\" width='20' height='20'>";
		}
		return result;
	}

	public String checkBoxAtPos(String data, int position) {
		String result = "";
		try {
			if (data.charAt(position) == '1') {
				result = "checked";
			} else {
				result = "";
			}
		} catch (Exception e) {
			result = "";
		}
		return result;
	}

	public String checkBoxAtPosY(String data, int position) {
		String result = "";
		try {
			if (data.charAt(position) == 'Y') {
				result = "checked";
			} else {
				result = "";
			}
		} catch (Exception e) {
			result = "";
		}
		return result;
	}
	
	public String padKeyRight(String dataword, int dataLen, String dataValue) {
		if (dataword.length() > 0) {
			while (dataword.length() < dataLen) {
				dataword += dataValue;
			}
		}
		return dataword;
	}
	
	public String padKeyLeft(String dataword, int dataLen, String dataValue) {
		if (dataword.length() > 0) {
			while (dataword.length() < dataLen) {
				dataword = dataValue + dataword;
			}
		}
		return dataword;
	}	
	
	public String formatFullIP(String ip1, String ip2, String ip3, String ip4) {
		String result = "";
		result = padKeyLeft(ip1, 3, "0") + "." + padKeyLeft(ip2, 3, "0") + "." + padKeyLeft(ip3, 3, "0") + "."
				+ padKeyLeft(ip4, 3, "0");
		return result;
	}
	
	public String formatFullTime(String hh1, String mm1, String hh2, String mm2) {
		String result = "";
		return result = padKeyLeft(hh1, 2, "0") + padKeyLeft(mm1, 2, "0") + padKeyLeft(hh2, 2, "0")
				+ padKeyLeft(mm2, 2, "0");
	}

	public String formatFullTimeOut4(String hh1, String mm1, String ss1, String hh2, String mm2, String ss2) {
		String result = "";
		if (!((hh1 + mm1 + ss1).equals("") && (hh2 + mm2 + ss2).equals(""))) {
			result = padKeyLeft(hh1, 2, "0") + padKeyLeft(mm1, 2, "0") + padKeyLeft(ss1, 2, "0") + "-"
					+ padKeyLeft(hh2, 2, "0") + padKeyLeft(mm2, 2, "0") + padKeyLeft(ss2, 2, "0");
		}
		return result;
	}
	
	public String displayFormatPhone(String data) {
		// return format = xxx-xxx-xxxx
		String result = "";
		if (data.length() == 10) {
			result = data.substring(0, 3) + "-" + data.substring(3, 6) + "-" + data.substring(6, 10);
		}
		return result;
	}

	public String displayFormatPublicId(String data) {
		// return format = x-xxxx-xxxxx-xx-x
		String result = "";
		if (data.length() == 13) {
			result = data.substring(0, 1) + "-" + data.substring(1, 5) + "-" + data.substring(5, 10) + "-"
					+ data.substring(10, 12) + "-" + data.substring(12, 13);
		}
		return result;
	}

	public String chkTextStringAlert(String status, String times, String textadd, String textedit) {
		String result = "";
		if (status.equals("1")) {
			result = "<span style='font-family: tahoma;font-size: 12px; color:#00CC33;' onmouseover=this.style.cursor='hand' title='"
					+ times + "'> [ " + textadd + " ]</span>";
		} else if (status.equals("2")) {
			result = "<span style='font-family: tahoma;font-size: 12px; color:#CC0000;' onmouseover=this.style.cursor='hand' title='"
					+ times + "'> [ " + textedit + " ]</span>";
		}
		return result;
	}

	public String chkTextStringAlert2(String status, String times, String textadd, String textedit, String textdel) {
		String result = "";
		if (status.equals("1")) {
			result = "<span style='font-family: tahoma;font-size: 12px; color:#00CC33;' onmouseover=this.style.cursor='hand' title='"
					+ times + "'> [ " + textadd + " ]</span>";
		} else if (status.equals("2")) {
			result = "<span style='font-family: tahoma;font-size: 12px; color:#CC0000;' onmouseover=this.style.cursor='hand' title='"
					+ times + "'> [ " + textedit + " ]</span>";
		} else if (status.equals("3")) {
			result = "<span style='font-family: tahoma;font-size: 12px; color:#CC0000;' onmouseover=this.style.cursor='hand' title='"
					+ times + "'> [ " + textdel + " ]</span>";
		}
		return result;
	}	
%>