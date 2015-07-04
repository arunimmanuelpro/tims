package general;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.text.SimpleDateFormat;
import java.util.Date;

import security.SecureNew;
import access.DbConnection;

public class ActivityLog {

	public static void log(String activity,String type,String userid) throws Exception{
		Connection con = DbConnection.getConnection();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		Date to = new Date();
		String today = sdf.format(to);
		
		SecureNew sn = new SecureNew();
		String s_activity = sn.encrypt(activity);
		String s_type = sn.encrypt(type);
		
		PreparedStatement ps = con.prepareStatement("INSERT INTO `activity_log`(`date`, `activity`,`type`, `userid`) VALUES (?,?,?,?)");
		ps.setString(1, today);
		ps.setString(2, s_activity);
		ps.setString(3, s_type);
		ps.setString(4, userid);
		ps.execute();
	}
}
