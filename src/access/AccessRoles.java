package access;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

public class AccessRoles {

	public static ArrayList<String> get_permissons(String userid) throws Exception {
		Connection con = DbConnection.getConnection();
		Statement s = con.createStatement();
		String sql = "";		
		ArrayList<String> perms = new ArrayList<String>();
		sql = "SELECT perm_id FROM `role_perm` WHERE `role_id` = '" + userid + "'";
		ResultSet rs = s.executeQuery(sql);
		while (rs.next()) {
			String permid = rs.getString("perm_id");
			s = con.createStatement();
			sql = "SELECT * FROM `permissions` WHERE `perm_id` = '" + permid + "' LIMIT 1";
			ResultSet rs3 = s.executeQuery(sql);
			if (rs3.next()) {
				String rolename = rs3.getString("perm_desc");
				perms.add(rolename);
			}// getting permisson names end
		}// getting role permissons for role

		return perms;
	}

	public static String getrole(String userid) throws Exception {
		Connection con = DbConnection.getConnection();
		Statement s = con.createStatement();
		String sql = "SELECT roleid FROM `Employee` WHERE `id` = '" + userid	+ "' LIMIT 1";
		ResultSet rs = s.executeQuery(sql);
		if (rs.next()) {
			return rs.getString("roleid");
		}
		return null;
	}

	public static String getrolename(String userid) throws Exception {
		Connection con = DbConnection.getConnection();
		Statement s = con.createStatement();
		String sql = "SELECT role_name FROM `roles` WHERE `role_id` = '" + userid + "' LIMIT 1";
		ResultSet rs = s.executeQuery(sql);
		if (rs.next()) {
			return rs.getString(1);
		}
		return null;
	}
}
