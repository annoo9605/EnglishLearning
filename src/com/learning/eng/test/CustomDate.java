package com.learning.eng.test;

import java.util.Calendar;
import java.util.Date;
import java.util.Locale;
import java.util.TimeZone;

import sun.util.calendar.BaseCalendar;
import sun.util.calendar.CalendarUtils;

public class CustomDate {

	public String toString() {
		//2015-07-12T12:30:00
		Calendar cal = Calendar.getInstance();
		
		int year = cal.get(Calendar.YEAR);
		int month = cal.get(Calendar.MONTH)+1;
		int date = cal.get(Calendar.YEAR);
		int hour = cal.get(Calendar.HOUR);
		int minute = cal.get(Calendar.MINUTE);
		int second = cal.get(Calendar.SECOND);
		System.out.println(year+"-"+month+"-"+date+"T"+hour+":"+minute+":"+second);
		return year+"-"+month+"-"+date+"T"+hour+":"+minute+":"+second;
	}

}
