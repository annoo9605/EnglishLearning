package com.learning.eng.test;

import static org.junit.Assert.*;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.TimeZone;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.learning.eng.common.Util;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration( locations = {
		 "classpath:client-context.xml"
		,"classpath:root-context.xml"
		,"classpath:dao-context.xml"
})
public class DateTest {
	@Autowired
	Util cUtil;
	
	@Test
	public void test() {
		fail("Not yet implemented");
	}
	
	@Test
	public void getUTCformatDate(){
		 long ts = System.currentTimeMillis();
		    Date localTime = new Date(ts);
		    String format = "yyyy/MM/dd HH:mm:ss";
		    SimpleDateFormat sdf = new SimpleDateFormat(format);

		    // Convert Local Time to UTC (Works Fine)
		    sdf.setTimeZone(TimeZone.getTimeZone("UTC"));
		    Date gmtTime = new Date(sdf.format(localTime));
		    System.out.println("Local:" + localTime.toString() + "," + localTime.getTime() + " --> UTC time:"
		            + gmtTime.toString() + "," + gmtTime.getTime());

		    // **** YOUR CODE **** END ****

		    // Convert UTC to Local Time
		    Date fromGmt = new Date(gmtTime.getTime() + TimeZone.getDefault().getOffset(localTime.getTime()));
		    System.out.println("UTC time:" + gmtTime.toString() + "," + gmtTime.getTime() + " --> Local:"
		            + fromGmt.toString() + "-" + fromGmt.getTime());
	}
	
	@Test
	public void getTiyme(){
		//2015-07-12T12:30:00
			Calendar cal = Calendar.getInstance();
			long ts = System.currentTimeMillis();
			Date date = new Date(ts);
			cal.setTime(date);
			int year = cal.get(Calendar.YEAR);
			int dmonth = cal.get(Calendar.MONTH)+1;
			int dday = cal.get(Calendar.DATE);
			int dhour = cal.get(Calendar.HOUR_OF_DAY);
			int dminute = cal.get(Calendar.MINUTE);
			int dsecond = cal.get(Calendar.SECOND);
			String month = cUtil.getTwoDigit(dmonth);
			String day = cUtil.getTwoDigit(dday);
			String hour = cUtil.getTwoDigit(dhour);
			String minute = cUtil.getTwoDigit(dminute);
			String second = cUtil.getTwoDigit(dsecond);
			System.out.println(year+"-"+month+"-"+day+"T"+hour+":"+minute+":"+second);
	}
	

}
