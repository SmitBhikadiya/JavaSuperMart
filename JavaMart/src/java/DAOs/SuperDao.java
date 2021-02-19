/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DAOs;

import POJOs.*;
import com.mysql.jdbc.Connection;
import com.mysql.jdbc.PreparedStatement;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class SuperDao {
    private static Connection conn = null;
    
    /* seprate function to establish connection */
    private static Connection getConnection(){
        
        try {
            Class.forName("com.mysql.jdbc.Driver");
            
            conn = (Connection) DriverManager.getConnection("jdbc:mysql://localhost:3306/supermartjava?user=root");
            
        } catch (ClassNotFoundException | SQLException ex) {
            Logger.getLogger(SuperDao.class.getName()).log(Level.SEVERE, null, ex);
        }
   
        return conn;
    }
    
    /* for user registration */
    public static PojoRegistration getById(int id) throws SQLException{   
       PojoRegistration pojo = new PojoRegistration(); 
        conn = getConnection();
        
        String sql = "SELECT * FROM userregistration WHERE userid=?";
        
        try {
            PreparedStatement st = (PreparedStatement) conn.prepareStatement(sql);
            st.setInt(1, id);
            ResultSet rs = st.executeQuery();
            
            if(rs.next()){
                pojo.setUserId(rs.getInt("userid"));
                pojo.setUserName(rs.getString("username"));
                pojo.setUserType(rs.getString("usertype"));
                pojo.setUserMobile(rs.getString("usermobile"));
                pojo.setUserEmail(rs.getString("useremail"));
                pojo.setUserPassword(rs.getString("userpassword"));
                pojo.setUserAddress(rs.getString("useraddress"));
                pojo.setUserRegistrationTime(rs.getString("registrationtime"));
            }
            
        } catch (SQLException ex) {
            Logger.getLogger(SuperDao.class.getName()).log(Level.SEVERE, null, ex);
        } finally{
            conn.close();
        }
        return pojo;
    }
    
    /* for user registration */
    public static int insert(PojoRegistration pojo) throws SQLException{
        int status = 5;
        conn = getConnection();
        // prepared statement to insert data into the table
        String sql = "INSERT INTO userregistration (username, usertype, useremail, usermobile, userpassword, useraddress) VALUES (?,?,?,?,?,?)";
        try {
            PreparedStatement st = (PreparedStatement) conn.prepareStatement(sql);
            st.setString(1, pojo.getUserName());
            st.setString(2, pojo.getUserType());
            st.setString(3, pojo.getUserEmail());
            st.setString(4, pojo.getUserMobile());
            st.setString(5, pojo.getUserPassword());
            st.setString(6, pojo.getUserAddress());
            st.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(SuperDao.class.getName()).log(Level.SEVERE, null, ex);
        } finally{
            conn.close();
        }
        return status;
    }
    
    /* for user registration */
    public static PojoRegistration userAuth(String email,String pwd) throws SQLException{
        PojoRegistration pojo = new PojoRegistration(); 
        conn = getConnection();
        
        String sql = "SELECT * FROM userregistration WHERE useremail=? and userpassword=?";
        
        try {
            PreparedStatement st = (PreparedStatement) conn.prepareStatement(sql);
            st.setString(1, email);
            st.setString(2, pwd);
            ResultSet rs = st.executeQuery();
            
            if(rs.next()){
                pojo.setUserId(rs.getInt("userid"));
                pojo.setUserName(rs.getString("username"));
                pojo.setUserType(rs.getString("usertype"));
                pojo.setUserMobile(rs.getString("usermobile"));
                pojo.setUserEmail(rs.getString("useremail"));
                pojo.setUserPassword(rs.getString("userpassword"));
                pojo.setUserAddress(rs.getString("useraddress"));
                pojo.setUserRegistrationTime(rs.getString("registrationtime"));
            }
            
        } catch (SQLException ex) {
            Logger.getLogger(SuperDao.class.getName()).log(Level.SEVERE, null, ex);
        } finally{
            conn.close();
        }
        
        return pojo;
    }
    
    /* for image upload */
    public static void insert(pojoImg pojo){
        
    }
}
