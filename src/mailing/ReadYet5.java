package mailing;
import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.Properties;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.mail.Address;
import javax.mail.BodyPart;
import javax.mail.Flags;
import javax.mail.Folder;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Multipart;
import javax.mail.NoSuchProviderException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Store;
import javax.mail.Flags.Flag;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMultipart;
import javax.mail.search.FlagTerm;

import access.DbConnection;

import com.sun.mail.util.MailSSLSocketFactory;
 
public class ReadYet5 {
    Properties properties = null;
    private Session session = null;
    private Store store = null;
    private Folder inbox = null;
    boolean gotdata=false;
    private String userName = "yet5@eyeopentechnologies.com";// provide user name
    private String password = "WinWin1940";// provide password
	     
    public ReadYet5() { 
    }
 
    public void readMails() throws IOException, Exception {
		properties = new Properties();
		properties.setProperty("mail.host", "bh-17.webhostbox.net");
		properties.setProperty("mail.port", "143");
		properties.setProperty("mail.transport.protocol", "imaps");
		session = Session.getInstance(properties,
				new javax.mail.Authenticator() {
					protected PasswordAuthentication getPasswordAuthentication() {
						return new PasswordAuthentication(userName, password);
					}
				});
        try {
            store = session.getStore("imaps");
            store.connect();
            inbox = store.getFolder("INBOX");
            inbox.open(Folder.READ_WRITE);
            Message messages[] = inbox.search(new FlagTerm(new Flags(Flag.SEEN), false));
            //System.out.println("Number of mails = " + messages.length);
            for (int i = 0; i < messages.length; i++) {
                Message message = messages[i];
                Address[] from = message.getFrom();
                System.out.println("-------------------------------");
                //System.out.println("Date : " + message.getSentDate());
                //System.out.println("From : " + from[0]);
                //System.out.println("Subject: " + message.getSubject());
                //System.out.println("Content :");
                
                int msgno = message.getMessageNumber();                
                boolean already_read = false;
                boolean ignore = false;               
                
                Connection con = DbConnection.getConnection();
    			Statement s = con.createStatement();
    			String checksql = "SELECT * FROM `enquiry` WHERE `source`='YET5' AND `mailid`='"+msgno+"' ";
    			ResultSet rs2 = s.executeQuery(checksql);
    			if(rs2.next()){
    				already_read = true;
    			}
                
                if(!already_read){                
	                String email = from == null ? null : ((InternetAddress) from[0]).getAddress();	                
	                if(email.equalsIgnoreCase("care@yet5.com")){
	                	System.out.println("Yet5 Mail :"+email);
	                }else{	                	
	                	System.out.println("Not a YET5 Mail Ignored :"+email);
	                	ignore = true;
	                }
                }else{
                	System.out.println("Mail Already Read. Ignored");
                	message.setFlag(Flags.Flag.SEEN, true);
                	ignore = true;                	
                }
                                
                ArrayList<String> details4 = new ArrayList<>();
                if(!ignore){                
	                gotdata=false;
	            	try {
	            		Object content = message.getContent();
	            		if (content instanceof String)  
	    				{  
	    				    String body = (String)content;  
	    				    //System.out.println("String");
	    				}  
	    				else if (content instanceof MimeMultipart) {
	    				    MimeMultipart multipart=(MimeMultipart)content;
	    				    if (multipart.getCount() > 0) {
	    				      BodyPart part=multipart.getBodyPart(0);
	    				      content=part.getContent();
	    				    }
	    				}	
	            		if (content != null) {
	      				  String messagebody = content.toString();	      				
	      				  //Get Name
	      				  int startindex = 0;
	      				  String ref = "Name : ";
	      					int endindex = messagebody.indexOf(ref);
	      					StringBuilder str = new StringBuilder(messagebody);
	      					str.replace(startindex, endindex, "");
	      					str = new StringBuilder(str);
	      					startindex = str.indexOf(ref);
	      					endindex = str.indexOf("\n");
	      					str = new StringBuilder(str.substring(startindex, endindex));
	      					str.replace(0, ref.indexOf(":"), "");
	      					str.replace(0, 1, "");
	      					details4.add(str.toString());
	      					//System.out.println("Name" + str);
	      					
	      					 //Get City
	      					startindex = 0;
	      					ref = "City : ";
	      					endindex = messagebody.indexOf(ref);
	      					str = new StringBuilder(messagebody);
	      					str.replace(startindex, endindex, "");
	      					str = new StringBuilder(str);
	      					startindex = str.indexOf(ref);
	      					endindex = str.indexOf("\n");
	      					str = new StringBuilder(str.substring(startindex, endindex));
	      					str.replace(0, ref.indexOf(":"), "");
	      					str.replace(0, 1, "");
	      					details4.add(str.toString());
	      					//System.out.println("City" + str);
	      						
	      					//Get Area
	      					startindex = 0;
	      					ref = "Area : ";
	      					endindex = messagebody.indexOf(ref);
	      						
	      					str = new StringBuilder(messagebody);
	      					str.replace(startindex, endindex, "");
	      					str = new StringBuilder(str);
	      					startindex = str.indexOf(ref);
	      					endindex = str.indexOf("\n");
	      					str = new StringBuilder(str.substring(startindex, endindex));
	      					str.replace(0, ref.indexOf(":"), "");
	      					str.replace(0, 1, "");
	      					details4.add(str.toString());
	      					//System.out.println("Area" + str);
	      							
	      							
	      					//Get Contact No
	      					startindex = 0;
	      					ref = "Contact No.: ";
	      					endindex = messagebody.indexOf(ref);
	      					str = new StringBuilder(messagebody);
	      					str.replace(startindex, endindex, "");
	      					str = new StringBuilder(str);
	      					startindex = str.indexOf(ref);
	      					endindex = str.indexOf("\n");
	      					str = new StringBuilder(str.substring(startindex, endindex));
	      					str.replace(0, ref.indexOf(":"), "");
	      					str.replace(0, 1, "");
	      					ref = str.toString();
	      					if(ref.contains(" - [Mobile Number Verified]")){
	      						ref = ref.replace(" - [Mobile Number Verified]", "");
	      					}
	      					ref = ref.substring(0, 11);
	      					//ref.replace("</strong>", "");	
	      					details4.add(ref);
	      					//System.out.println("Contact No" + ref);
	      							
	      				  
	      					//Get Email 
	      					startindex = 0;
	      					ref = "Email : ";
	      					endindex = messagebody.indexOf(ref);
	      					str = new StringBuilder(messagebody);
	      					str.replace(startindex, endindex, "");
	      					str = new StringBuilder(str);
	      					startindex = str.indexOf(ref);
	      					endindex = str.indexOf("\n");
	      					str = new StringBuilder(str.substring(startindex, endindex));
	      					str.replace(0, ref.indexOf(":"), "");
	      					str.replace(0, 1, "");
	      					ref = str.toString();
	      					details4.add(ref);
	      					//System.out.println("Email " + ref);
	      									
	      									
	      					//Get Course Interested in 
	      					startindex = 0;
	      					ref = "Course Interested in: ";
	      					endindex = messagebody.indexOf(ref);
	      					str = new StringBuilder(messagebody);
	      					str.replace(startindex, endindex, "");
	      					str = new StringBuilder(str);
	      					startindex = str.indexOf(ref);
	      					endindex = str.indexOf("\n");
	      					str = new StringBuilder(str.substring(startindex, endindex));
	      					str.replace(0, ref.indexOf(":"), "");
	      					str.replace(0, 1, "");
	      					ref = str.toString();
	      					details4.add(ref);
	      					//System.out.println("Course Interested in " + ref);	      						
	      				 }
	                } catch (IOException e) {
	                    e.printStackTrace();
	                } catch (MessagingException e) {
	                    e.printStackTrace();
	                }            	
                }
                
                boolean gotyet5 = false;
                
                if((details4.size() > 0) && !already_read){
	            	try{
	            		SimpleDateFormat ddmm = new SimpleDateFormat("yyyy-MM-dd");
	        			SimpleDateFormat yyyy = new SimpleDateFormat("yyyy");
	        			Calendar calender = Calendar.getInstance();
	        			Date currentdate = new Date();
	        			calender.setTime(currentdate);
	        			int month = calender.get(Calendar.MONTH) + 1;
	        			String cDate = ddmm.format(currentdate);
	        			String year = yyyy.format(currentdate);

	        			s = con.createStatement();
	        			String mobilen = details4.get(3).substring(0, 12);
	        			String sql = "INSERT INTO `enquiry`(`source`, `name`, `email`, `mobile`, `qualification`, `stream`, `currentlyin`, `homephone`, `courseinterested`, `address`,`donebyid`,`date`,`month`,`year`,`status`,`mailid`) VALUES ('YET5','"	+ details4.get(0)	+ "','"	+ details4.get(4)	+ "','"	+ mobilen + "','','','','','"	+ details4.get(5)+","+details4.get(2)+","+details4.get(1)+ "','0','"	+ cDate	+ "','"	+ month+ "','"	+ year + "','NEW','"+msgno+"')";
	        			System.out.println(sql);
	        			s.executeUpdate(sql,Statement.RETURN_GENERATED_KEYS);
	        			ResultSet rs = s.getGeneratedKeys();
	        			if (rs.next()) {
	        				// Retrieve the auto generated key(s).
	        				int key = rs.getInt(1);
	        					sql = "INSERT INTO `enquiry_data`(`enquiry_id`, `followon`) VALUES ('"+ key	+ "','"+cDate+"')";
	        					s.executeUpdate(sql);
	        					gotyet5 = true;
	        			} else {
	        				//Actual End
	        			}	            		
	            	}
	            	catch(Exception e){
	            		e.printStackTrace();
	            	}
	            	}else{
	            		System.out.println("Sorry No Data Found");
	            	}
            	
            	
            	/*ArrayList<String> details2 = new ArrayList<>();
            	if(parsedcontent!=null && !already_read){
	            	if(parsedcontent.length() > 0){	            		
	            		Pattern pattern = Pattern.compile("<td valign=\"top\">(.*?)</td>");
	                    Matcher matcher = pattern.matcher(parsedcontent);	                    
	                    while(matcher.find()) {
	                        details2.add(matcher.group(1));
	                        gotdata = true;
	                    }
	            	}else{
	            		System.out.println("Sorry No Data Found");
	            	}
            	}*/
            	
            	if(gotyet5){
            		//Set Message as Read
            		System.out.println("YET5 Mail Details Read Successfully");
                    try{
                    	message.setFlag(Flags.Flag.SEEN, true);                    
                    }
                    catch(Exception e){
                    	e.printStackTrace();
                    }                    
            	}else{
            		System.out.println("YET5 Mail Details Read Failed");            		
                    message.setFlag(Flag.SEEN, false);
            	}
                
				/*if(gotdata){
                	int detailcount = 0;
                	for(String s3:details2){
                		System.out.println("Detail : "+s3);
                		detailcount++;
                	}
                	if(detailcount==5){
                		//Set Message as Read
                		System.out.println("Mail Details Read Successfully");
                        message.setFlag(Flag.SEEN, true);
                	}else{
                		System.out.println("Mail Details Read Failed");
                		//Set Message as Read
                        message.setFlag(Flag.SEEN, false);
                	}
                }else{
                	message.setFlag(Flag.SEEN, false);
                }*/
                
                System.out.println("--------------------------------");
 
            }
            inbox.close(true);
            store.close();
        } catch (NoSuchProviderException e) {
            e.printStackTrace();
        } catch (MessagingException e) {
            e.printStackTrace();
        }
    }
 
   /* public StringBuilder procesMultiPart(Multipart content) {
    	StringBuilder sb = new StringBuilder();
        try {
            int multiPartCount = content.getCount();
            for (int i = 0; i < multiPartCount; i++) {
                BodyPart bodyPart = content.getBodyPart(i);
                Object o;
                o = bodyPart.getContent();
                if (o instanceof String) {
                    sb.append(o);
                } else if (o instanceof Multipart) {
                    procesMultiPart((Multipart) o);
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        } catch (MessagingException e) {
            e.printStackTrace();
        }
        return sb; 
    }*/
 
    public static void main(String[] args) throws Exception {
       /* ReadYet5 sample = new ReadYet5();
        sample.readMails();*/
    }
 
}