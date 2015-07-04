package general;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;

public class BatchSchedule {
	
	SimpleDateFormat mmdd = new SimpleDateFormat("MM/dd/yyyy");
	SimpleDateFormat ddmm = new SimpleDateFormat("yyyy-MM-dd");
	    Calendar calender = Calendar.getInstance();
	    Date currentdate = new Date();
	    String cDate = ddmm.format(currentdate);
		private ArrayList<String> list;
		private Date startdate;
		
		String result;
		private int res;
		private long iid;
	
	public String CreateSchedule(String date,String type,int courseduration,int Tid,String Session,int Cid,String userid,int HrsPerday){
		try {
			startdate = ddmm.parse(date);
		} catch (ParseException e) {
			e.printStackTrace();
		}
        res = create_b(date,type,courseduration,Tid,Session,Cid,userid,HrsPerday);
        if(res==0){
        	result = "Batch Creation Error";
        }else if(res==1){
        	result = "Created";
        }else if(res==5){
        	result = "Type Error";
        }
        else if(res==16){
        	result = "Batch Not Created Error";
        }else if(res==11){
        	result = "DB Connection Error";
        } else if(res==20){
        	result = "ALL_OK";
        }
        return result;
		
	
	}
	
	public int create_b(String date,String type,int courseduration,int Tid,String Session,int Cid,String userid,int HrsPerday){
		
		int result = 0;		
		int sduration = HrsPerday;
		int noofdays;
        int cdd;
        int tff;
        boolean batchlistcreated = false;;
        list = new ArrayList<String>();
        calender.setTime(startdate);
        if(!type.equalsIgnoreCase("")){
            switch(type){
                case "Mon-Fri":
                    noofdays = courseduration/sduration;
                    //sduration = 2;
                    System.out.println("No of Days:" +noofdays);
                    // Calculate Dates
                    tff = 0;
                    do{
                        cdd = calender.get(Calendar.DAY_OF_WEEK);
                        //System.out.println("Day :"+ tff + "Day of Week" + cdd);
                    if((cdd != Calendar.SATURDAY) && (cdd != Calendar.SUNDAY)){
                        //System.err.println("In"+cdd);
                        Date d = calender.getTime();
                        list.add(ddmm.format(d));
                        calender.add(Calendar.DATE, 1);
                        batchlistcreated = true;
                        tff++;
                    }else{
                        //System.err.println("Out"+cdd);
                        calender.add(Calendar.DATE, 1);
                    }
                    }while(tff < noofdays);
                    
                    break;
                
                case "Mon-Sat":
                    noofdays = courseduration/sduration;
                    //sduration = 3;
                    System.out.println("No of Days:" +noofdays);
                    // Calculate Dates
                    tff = 0;
                    do{
                        cdd = calender.get(Calendar.DAY_OF_WEEK);
                        //System.out.println("Day :"+ tff + "Day of Week" + cdd);
                    if(cdd != Calendar.SUNDAY){
                        //System.err.println("In"+cdd);
                        Date d = calender.getTime();
                        list.add(ddmm.format(d));
                        calender.add(Calendar.DATE, 1);
                        batchlistcreated = true;
                        tff++;
                    }else{
                        //System.err.println("Out"+cdd);
                        calender.add(Calendar.DATE, 1);
                    }
                    }while(tff < noofdays);
                    
                    break; 
                    
                case "Tue-Fri":
                    noofdays = courseduration/sduration;
                    //sduration = 3;
                    System.out.println("No of Days:" +noofdays);
                    // Calculate Dates
                    tff = 0;
                    do{
                        cdd = calender.get(Calendar.DAY_OF_WEEK);
                        //System.out.println("Day :"+ tff + "Day of Week" + cdd);
                    if((cdd != Calendar.MONDAY) && (cdd != Calendar.SATURDAY) && (cdd != Calendar.SUNDAY)){
                        //System.err.println("In"+cdd);
                        Date d = calender.getTime();
                        list.add(ddmm.format(d));
                        calender.add(Calendar.DATE, 1);
                        batchlistcreated = true;
                        tff++;
                    }else{
                        //System.err.println("Out"+cdd);
                        calender.add(Calendar.DATE, 1);
                    }
                    }while(tff < noofdays);                    
                    break;    
                case "Mon-Wed-Fri":
             	   //sduration = 2;
                     noofdays = courseduration/sduration;
                     System.out.println("No of Days:" +noofdays);
                     // Calculate Dates
                     tff = 0;
                     do{
                         cdd = calender.get(Calendar.DAY_OF_WEEK);
                         //System.out.println("Day :"+ tff + "Day of Week" + cdd);
                     if((cdd == Calendar.MONDAY) || (cdd == Calendar.WEDNESDAY)  || (cdd == Calendar.FRIDAY)){
                         //System.err.println("In"+cdd);
                         Date d = calender.getTime();
                         list.add(ddmm.format(d));
                         calender.add(Calendar.DATE, 1);
                         batchlistcreated = true;
                         tff++;
                     }else{
                         //System.err.println("Out"+cdd);
                         calender.add(Calendar.DATE, 1);
                     }
                     }while(tff < noofdays);
                     break;
                case "Tue-Thu-Sat":
             	   //sduration = 2;
                     noofdays = courseduration/sduration;
                     System.out.println("No of Days:" +noofdays);
                     // Calculate Dates
                     tff = 0;
                     do{
                         cdd = calender.get(Calendar.DAY_OF_WEEK);
                         //System.out.println("Day :"+ tff + "Day of Week" + cdd);
                     if((cdd == Calendar.TUESDAY) || (cdd == Calendar.THURSDAY)  || (cdd == Calendar.SATURDAY)){
                         //System.err.println("In"+cdd);
                         Date d = calender.getTime();
                         list.add(ddmm.format(d));
                         calender.add(Calendar.DATE, 1);
                         batchlistcreated = true;
                         tff++;
                     }else{
                         //System.err.println("Out"+cdd);
                         calender.add(Calendar.DATE, 1);
                     }
                     }while(tff < noofdays);
                     break;    
                case "Thu-Fri-Sat":
              	   //sduration = 2;
                      noofdays = courseduration/sduration;
                      System.out.println("No of Days:" +noofdays);
                      // Calculate Dates
                      tff = 0;
                      do{
                          cdd = calender.get(Calendar.DAY_OF_WEEK);
                          //System.out.println("Day :"+ tff + "Day of Week" + cdd);
                      if((cdd == Calendar.THURSDAY) || (cdd == Calendar.FRIDAY)  || (cdd == Calendar.SATURDAY)){
                          //System.err.println("In"+cdd);
                          Date d = calender.getTime();
                          list.add(ddmm.format(d));
                          calender.add(Calendar.DATE, 1);
                          batchlistcreated = true;
                          tff++;
                      }else{
                          //System.err.println("Out"+cdd);
                          calender.add(Calendar.DATE, 1);
                      }
                      }while(tff < noofdays);
                      break;        
                case "Sat-Sun":
                    noofdays = courseduration/sduration;
                    //sduration = 4;
                    System.out.println("No of Days:" +noofdays);
                    // Calculate Dates
                    tff = 0;
                    do{
                        cdd = calender.get(Calendar.DAY_OF_WEEK);
                        //System.out.println("Day :"+ tff + "Day of Week" + cdd);
                    if((cdd == Calendar.SATURDAY) || (cdd == Calendar.SUNDAY)){
                        //System.err.println("In"+cdd);
                        Date d = calender.getTime();
                        list.add(ddmm.format(d));
                        calender.add(Calendar.DATE, 1);
                        batchlistcreated = true;
                        tff++;
                    }else{
                        //System.err.println("Out"+cdd);
                        calender.add(Calendar.DATE, 1);
                    }
                    }while(tff < noofdays);
                    break;
              
               case "Sun-Only":
            	    //sduration = 4;
                    noofdays = courseduration/sduration;
                    System.out.println("No of Days:" +noofdays);
                    // Calculate Dates
                    tff = 0;
                    do{
                        cdd = calender.get(Calendar.DAY_OF_WEEK);
                        //System.out.println("Day :"+ tff + "Day of Week" + cdd);
                    if(cdd == Calendar.SUNDAY){
                        //System.err.println("In"+cdd);
                        Date d = calender.getTime();
                        list.add(ddmm.format(d));
                        calender.add(Calendar.DATE, 1);
                        batchlistcreated = true;
                        tff++;
                    }else{
                        //System.err.println("Out"+cdd);
                        calender.add(Calendar.DATE, 1);
                    }
                    }while(tff < noofdays);
                    break;
                default:
                   batchlistcreated = true;
                   break;
                    
            }// Switch End
            if(batchlistcreated){
                // Insert All to Database
            	result = 1;
                System.out.println("Batch Created");
                result = dbconnection_add_batch(date, type, sduration, courseduration, Tid, Session, Cid,userid);
            }
        }else{
            System.err.println("Batch type Empty");
            result = 5;
        }
        return result;
	}
	
	
	int dbconnection_add_batch(String date,String type,int sduration,int courseduration,int Tid,String Session,int Cid,String userid){
        int result2 = 20;
		try {
            Connection scon = access.DbConnection.getConnection();
            Connection con = scon;
            String startdate = list.get(0);
            String enddate = list.get(list.size()-1);
            PreparedStatement s = con.prepareStatement("INSERT INTO `batchdetails`( `Courseid`, `Trainerid`, `Startdate`, `Enddate`, `session`, `type`, `sessionduration`, `createdon`, `status`, `createdby`) VALUES (?,?,?,?,?,?,?,?,?,?)",Statement.RETURN_GENERATED_KEYS);
            s.setInt(1, Cid);
            s.setInt(2, Tid);
            s.setString(3, startdate);
            s.setString(4, enddate);
            s.setString(5, Session);
            s.setString(6, type);
            s.setInt(7, sduration);
            s.setString(8, ddmm.format(currentdate));
            s.setString(9, "CREATED");
            s.setString(10, userid);
            
            int res = s.executeUpdate();
            if(res > 0){
                System.out.println("main update ok");
                ResultSet rs = s.getGeneratedKeys();
                if (rs.next() ) {
                    // The generated id
                    iid = rs.getLong(1);
                    System.out.println("executeUpdate: id: " + iid);
                }
                //insert batch dates
                for (String string : list) {
                    PreparedStatement s1 = con.prepareStatement("INSERT INTO `batchsession`( `batchid`, `date`, `status`) VALUES (?,?,?)");

                    s1.setLong(1, iid);
                    s1.setString(2, string);
                    s1.setString(3, "PENDING");
                    int res2 = s1.executeUpdate();
                    if(res2 > 0){
                        System.out.println("update date success");
                    }else{
                        System.err.println("update date error");
                    }
            
                }
                //end insert batch dates
                

            }else{
                System.err.println("batch create db error");
                result2 = 16;
            }

                
            con.close();
            
        } catch (Exception ex) {
        	ex.printStackTrace();
            System.err.println("Cannot Get Data.");
            result2 = 11;
        }
		return result2;
    }

}
