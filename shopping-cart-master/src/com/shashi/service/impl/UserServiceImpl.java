package com.shashi.service.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.shashi.beans.ProductBean;
import com.shashi.beans.UserBean;
import com.shashi.constants.IUserConstants;
import com.shashi.service.UserService;
import com.shashi.utility.DBUtil;
import com.shashi.utility.MailMessage;

public class UserServiceImpl implements UserService {

	@Override
	public String registerUser(String userName, String mobileNo, String emailId, String address, int pinCode,
			String password) {

		UserBean user = new UserBean(userName, mobileNo, emailId, address, pinCode, password);

		String status = registerUser(user);

		return status;
	}

	@Override
	public String registerUser(UserBean user) {

		String status = "Đăng ký người dùng không thành công!";

		boolean isRegtd = isRegistered(user.getEmail());

		if (isRegtd) {
			status = "Id email đã được đăng ký!";
			return status;
		}
		Connection conn = DBUtil.provideConnection();
		PreparedStatement ps = null;
		if (conn != null) {
			System.out.println("Đã kết nối thành công!");
		}

		try {

			ps = conn.prepareStatement("insert into " + IUserConstants.TABLE_USER + " values(?,?,?,?,?,?)");

			ps.setString(1, user.getEmail());
			ps.setString(2, user.getName());
			ps.setString(3, user.getMobile());
			ps.setString(4, user.getAddress());
			ps.setInt(5, user.getPinCode());
			ps.setString(6, user.getPassword());

			int k = ps.executeUpdate();

			if (k > 0) {
				status = "Người dùng đã đăng ký thành công!";
				MailMessage.registrationSuccess(user.getEmail(), user.getName().split(" ")[0]);
			}

		} catch (SQLException e) {
			status = "Error: " + e.getMessage();
			e.printStackTrace();
		}

		DBUtil.closeConnection(ps);
		DBUtil.closeConnection(ps);

		return status;
	}

	@Override
	public boolean isRegistered(String emailId) {
		boolean flag = false;

		Connection con = DBUtil.provideConnection();

		PreparedStatement ps = null;
		ResultSet rs = null;

		try {
			ps = con.prepareStatement("select * from user where email=?");

			ps.setString(1, emailId);

			rs = ps.executeQuery();

			if (rs.next())
				flag = true;

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		DBUtil.closeConnection(con);
		DBUtil.closeConnection(ps);
		DBUtil.closeConnection(rs);

		return flag;
	}

	@Override
	public String isValidCredential(String emailId, String password) {
		String status = "Đăng nhập bị từ chối! Tên đăng nhập hoặc mật khẩu không chính xác";

		Connection con = DBUtil.provideConnection();

		PreparedStatement ps = null;
		ResultSet rs = null;

		try {

			ps = con.prepareStatement("select * from user where email=? and password=?");

			ps.setString(1, emailId);
			ps.setString(2, password);

			rs = ps.executeQuery();

			if (rs.next())
				status = "valid";

		} catch (SQLException e) {
			status = "Error: " + e.getMessage();
			e.printStackTrace();
		}

		DBUtil.closeConnection(con);
		DBUtil.closeConnection(ps);
		DBUtil.closeConnection(rs);
		return status;
	}

	@Override
	public UserBean getUserDetails(String emailId, String password) {

		UserBean user = null;

		Connection con = DBUtil.provideConnection();

		PreparedStatement ps = null;
		ResultSet rs = null;

		try {
			ps = con.prepareStatement("select * from user where email=? and password=?");
			ps.setString(1, emailId);
			ps.setString(2, password);
			rs = ps.executeQuery();

			if (rs.next()) {
				user = new UserBean();
				user.setName(rs.getString("name"));
				user.setMobile(rs.getString("mobile"));
				user.setEmail(rs.getString("email"));
				user.setAddress(rs.getString("address"));
				user.setPinCode(rs.getInt("pincode"));
				user.setPassword(rs.getString("password"));

				return user;
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}

		DBUtil.closeConnection(con);
		DBUtil.closeConnection(ps);
		DBUtil.closeConnection(rs);

		return user;
	}

	@Override
	public String getFName(String emailId) {
		String fname = "";

		Connection con = DBUtil.provideConnection();

		PreparedStatement ps = null;
		ResultSet rs = null;

		try {
			ps = con.prepareStatement("select name from user where email=?");
			ps.setString(1, emailId);

			rs = ps.executeQuery();

			if (rs.next()) {
				fname = rs.getString(1);

				fname = fname.split(" ")[0];

			}

		} catch (SQLException e) {

			e.printStackTrace();
		}

		return fname;
	}

	@Override
	public String getUserAddr(String userId) {
		String userAddr = "";

		Connection con = DBUtil.provideConnection();
		PreparedStatement ps = null;
		ResultSet rs = null;

		try {
			ps = con.prepareStatement("select address from user where email=?");

			ps.setString(1, userId);

			rs = ps.executeQuery();

			if (rs.next())
				userAddr = rs.getString(1);

		} catch (SQLException e) {

			e.printStackTrace();
		}

		return userAddr;
	}
	public List<UserBean> getAllUser(){
		
		List<UserBean> listUser = new ArrayList<UserBean>();
		
		Connection con = DBUtil.provideConnection();
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		try {
			ps = con.prepareStatement("select * from user");
			rs = ps.executeQuery();
			while(rs.next()) {
				UserBean user = new UserBean();
				user.setEmail(rs.getString(1));
				user.setName(rs.getString(2));
				user.setMobile(rs.getString(3));
				user.setAddress(rs.getString(4));
				user.setPinCode(rs.getInt(5));
				user.setPassword(rs.getString(6));
				
				listUser.add(user);
			}
		}catch (SQLException e) {
			e.printStackTrace();
		} 
		DBUtil.closeConnection(con);
		DBUtil.closeConnection(ps);
		DBUtil.closeConnection(rs);
		return listUser;
	}


public String removeUser(String email) {
	String status = "Xoá người dùng bị lỗi. Vui lòng thử lại...";
	Connection con = DBUtil.provideConnection();
	PreparedStatement ps = null;
	try {
		ps = con.prepareStatement("delete  from user where email = ?");
		ps.setString(1, email);
		int k =  ps.executeUpdate();
		if(k > 0) {
			status = " Xoá thành công ";
		}
	}catch (SQLException e) {
		status = "Error: " + e.getMessage();
		e.printStackTrace();
	}

	DBUtil.closeConnection(con);
	DBUtil.closeConnection(ps);
	
	return status;
}


public String updateUser(String prevUser, UserBean updatedUser) {
	String status = "Cập nhật người dùng thất bại";	
	Connection con = DBUtil.provideConnection();
	if (con == null) {
	   
	    return "Không thể kết nối đến cơ sở dữ liệu";
	}
	PreparedStatement ps = null;
	
	try {
		ps = con.prepareStatement(
				"update user set name=?,mobile = ?, address=?,pincode = ?, password=? where email=?");
		
		ps.setString(1, updatedUser.getName());
		ps.setString(2, updatedUser.getMobile());
		ps.setString(3, updatedUser.getAddress());
		ps.setInt(4,updatedUser.getPinCode());
		ps.setString(5, updatedUser.getPassword());
		ps.setString(6, prevUser);
	
		int k = ps.executeUpdate();

		if (k > 0) {
		    status = "User được cập nhật thành công!";
		} else {
		    status = "Không tìm thấy bản ghi để cập nhật";
		}

	}catch (SQLException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}
	DBUtil.closeConnection(con);
	DBUtil.closeConnection(ps);

	return status;
}

public UserBean getUserDetaill(String email) {
	UserBean listUser = null;
	Connection con = DBUtil.provideConnection();

	PreparedStatement ps = null;
	ResultSet rs = null;

	try {
		ps = con.prepareStatement("select * from user where email=?");

		ps.setString(1, email);
		rs = ps.executeQuery();

		if (rs.next()) {
			listUser = new UserBean();
			listUser.setEmail(rs.getString(1));
			listUser.setName(rs.getString(2));
			listUser.setMobile(rs.getString(3));
			listUser.setAddress(rs.getString(4));
			listUser.setPinCode(rs.getInt(5));
			listUser.setPassword(rs.getString(6));
		}

	} catch (SQLException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}

	DBUtil.closeConnection(con);
	DBUtil.closeConnection(ps);

	return listUser;
}

public int getPincodeDetail(String email) {
	int pincode = 0;

	Connection con = DBUtil.provideConnection();

	PreparedStatement ps = null;
	ResultSet rs = null;

	try {
		ps = con.prepareStatement("select * from user where email=?");

		ps.setString(1, email);
		rs = ps.executeQuery();

		if (rs.next()) {
			pincode = rs.getInt("pincode");
		}

	} catch (SQLException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}

	DBUtil.closeConnection(con);
	DBUtil.closeConnection(ps);

	return pincode;
}

}


