package mailing;


import java.util.*;

import javax.activation.CommandMap;
import javax.activation.MailcapCommandMap;
import javax.mail.*;
import javax.mail.internet.*;

import constant.InfoConstant;

public class SendMail {
	final static String username = InfoConstant.WorkMailID;// provide username
	final static String password = InfoConstant.MailPassWord;// provide password

	public static void sendmail(String to, String subject, String htmlBody) {

		if (to != null || htmlBody != null) {
			if (!to.isEmpty() || !htmlBody.isEmpty()) {

				Properties prop = new Properties();
				prop.put("mail.smtp.auth", "true");
				prop.put("mail.smtp.host", "bh-17.webhostbox.net");
				prop.put("mail.smtp.port", "587");
				// prop.put("mail.smtp.starttls.enable", "true");
				prop.put("mail.smtp.socketFactory.port", "587");
				prop.put("mail.smtp.socketFactory.class",
						"javax.net.ssl.SSLSocketFactory");
				Session session = Session.getDefaultInstance(prop,
						new javax.mail.Authenticator() {
							protected PasswordAuthentication getPasswordAuthentication() {
								return new PasswordAuthentication(username,	password);
							}
						});
				try {
					Message message = new MimeMessage(session);
					message.setFrom(new InternetAddress(username));
					message.setRecipients(Message.RecipientType.TO,
							InternetAddress.parse(to));
					message.setSubject(subject);
					MailcapCommandMap mc = (MailcapCommandMap) CommandMap
							.getDefaultCommandMap();
					mc.addMailcap("text/html;; x-java-content-handler=com.sun.mail.handlers.text_html");
					mc.addMailcap("text/xml;; x-java-content-handler=com.sun.mail.handlers.text_xml");
					mc.addMailcap("text/plain;; x-java-content-handler=com.sun.mail.handlers.text_plain");
					mc.addMailcap("multipart/*;; x-java-content-handler=com.sun.mail.handlers.multipart_mixed");
					mc.addMailcap("message/rfc822;; x-java-content-handler=com.sun.mail.handlers.message_rfc822");
					CommandMap.setDefaultCommandMap(mc);
					message.setText(htmlBody);
					message.setContent(htmlBody, "text/html");
					Transport.send(message);
					System.out.println("Mail Sent");
				} catch (MessagingException e) {
					e.printStackTrace();
				}
			}
		}
	}

	public static boolean sendBulkMail(String[] to, String subject,	String htmlBody, String[] cc, String[] bcc) {

		if (to != null || htmlBody != null) {
			if (to.length != 0 || !htmlBody.isEmpty()) {
				Properties prop = new Properties();
				prop.put("mail.smtp.auth", "true");
				prop.put("mail.smtp.host", "bh-17.webhostbox.net");
				prop.put("mail.smtp.port", "587");
				// prop.put("mail.smtp.starttls.enable", "true");
				prop.put("mail.smtp.socketFactory.port", "587");
				prop.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
				Session session = Session.getDefaultInstance(prop,
						new javax.mail.Authenticator() {
							protected PasswordAuthentication getPasswordAuthentication() {
								return new PasswordAuthentication(username,	password);
							}
						});
				try {
					Message message = new MimeMessage(session);
					message.setFrom(new InternetAddress(username));
					message.setSubject(subject);
					MailcapCommandMap mc = (MailcapCommandMap) CommandMap
							.getDefaultCommandMap();
					mc.addMailcap("text/html;; x-java-content-handler=com.sun.mail.handlers.text_html");
					mc.addMailcap("text/xml;; x-java-content-handler=com.sun.mail.handlers.text_xml");
					mc.addMailcap("text/plain;; x-java-content-handler=com.sun.mail.handlers.text_plain");
					mc.addMailcap("multipart/*;; x-java-content-handler=com.sun.mail.handlers.multipart_mixed");
					mc.addMailcap("message/rfc822;; x-java-content-handler=com.sun.mail.handlers.message_rfc822");
					CommandMap.setDefaultCommandMap(mc);
					message.setText(htmlBody);
					message.setContent(htmlBody, "text/html");
					InternetAddress[] toadd = new InternetAddress[to.length];
					for (int i = 0; i < to.length; i++) {						
						toadd[i] =  new InternetAddress(to[i]);						
					}
					message.setRecipients(Message.RecipientType.TO,	toadd);
					InternetAddress[] tocc = new InternetAddress[cc.length];
					for (int i = 0; i < cc.length; i++) {						
						tocc[i] =  new InternetAddress(cc[i]);						
					}
					message.setRecipients(Message.RecipientType.CC,	tocc);					
					InternetAddress[] tobcc = new InternetAddress[bcc.length];
					for (int i = 0; i < bcc.length; i++) {						
						tobcc[i] =  new InternetAddress(bcc[i]);					
					}
					message.setRecipients(Message.RecipientType.BCC, tobcc);
					
					Transport.send(message);					
				} catch (MessagingException e) {
					e.printStackTrace();
					return false;
				}
			}
		}
		return true;		
	}
}