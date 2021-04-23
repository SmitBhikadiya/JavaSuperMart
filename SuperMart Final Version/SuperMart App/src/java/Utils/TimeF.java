/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Utils;

import java.time.LocalTime;
import java.time.ZoneId;

/**
 *
 * @author Smit Bhikadiya
 */
public class TimeF {
    
    public static String isOpen(String open, String close){
        String is = "";
        ZoneId z = ZoneId.of( "Asia/Kolkata" ) ; 
        LocalTime date1 = LocalTime.now(z);
        LocalTime opent = LocalTime.of(TimeF.getHour(open), Integer.parseInt(open.substring(3,5)));
        LocalTime closet = LocalTime.of(TimeF.getHour(close), Integer.parseInt(close.substring(3,5)));
        if(date1.compareTo(opent) > 0 && date1.compareTo(closet) < 0) {
            is = "Open";
        } else {
            is = "Closed";
        }
        //System.out.println(is);
        return is;
    }
    
    private static int getHour(String time){
       int hour = Integer.parseInt(time.substring(0,2));
       //System.out.println(">>"+hour);
       return hour;
    } 
}
