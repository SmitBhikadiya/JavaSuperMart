/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DAOs;

import POJOs.PojoOrdersStatus;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Smit Bhikadiya
 */
public class DaoOrdersStatus {

    private static Connection conn = null;
    private static Connection getConnection() {

        try {
            Class.forName("com.mysql.jdbc.Driver");

            conn = (Connection) DriverManager.getConnection("jdbc:mysql://localhost:3306/supermartjava?user=root");

        } catch (ClassNotFoundException | SQLException ex) {
            Logger.getLogger(DaoStore.class.getName()).log(Level.SEVERE, null, ex);
        }

        return conn;
    }

    public static PojoOrdersStatus getOrderStatusByOrdId(int ordid) throws SQLException {
        String sql = "SELECT * FROM orderstatus WHERE ordid = ?";
        PojoOrdersStatus pojo = null;
        System.out.println("getOrderStatusByOrdId : ordid->"+ordid);
        conn = getConnection();
        PreparedStatement st;
        try {
            st = conn.prepareStatement(sql);
            st.setInt(1, ordid);
            ResultSet row = st.executeQuery();
            if (row.next()) {
                pojo = new PojoOrdersStatus();
                pojo.setOrdid(row.getInt("ordid"));
                pojo.setOrdstatus(row.getInt("ordstatus"));
                pojo.setOrdarrivalat(row.getString("ordarrivalat"));
                pojo.setAccepttime(row.getString("accepttime"));
                pojo.setDeliverytime(row.getString("deliverytime"));
                pojo.setAcceptstatus(row.getString("acceptstatus"));
                pojo.setAcceptedname(row.getString("acceptedname"));
                pojo.setAcceptedcontact(row.getString("acceptedcontact"));
                pojo.setPin(row.getString("pin"));
            }
        } catch (SQLException ex) {
            Logger.getLogger(DaoStore.class.getName()).log(Level.SEVERE, null, ex);
        } finally{
           //conn.close();
        }
        return pojo;
    }
    
    public static int updateOrderStatus(int ordstatus,int acceptstatus, String ordarrivalat, int ordid) throws SQLException {
        String sql = "UPDATE orderstatus SET ordstatus = ?, acceptstatus = ?, ordarrivalat = ? WHERE ordid = ?";
        PojoOrdersStatus pojo = null;
        int row = 0;
        conn = getConnection();
        PreparedStatement st;
        try {
            st = conn.prepareStatement(sql);
            st.setInt(1, ordstatus);
            st.setInt(2, acceptstatus);
            st.setString(3, ordarrivalat);
            st.setInt(4, ordid);
            row = st.executeUpdate();
            
        } catch (SQLException ex) {
            Logger.getLogger(DaoStore.class.getName()).log(Level.SEVERE, null, ex);
        } finally{
            conn.close();
        }
        return row;
    }
    
    public static String getePin(int ordid) throws SQLException {
        String sql = "SELECT pin FROM orderstatus WHERE ordid = ?";
        
        String pin = "NA";
        conn = getConnection();
        PreparedStatement st;
        try {
            st = conn.prepareStatement(sql);
            st.setInt(1, ordid);
            ResultSet row = st.executeQuery();
            if(row.next()){
                pin = row.getString("pin");
            }
            
        } catch (SQLException ex) {
            Logger.getLogger(DaoStore.class.getName()).log(Level.SEVERE, null, ex);
        } finally{
            conn.close();
        }
        return pin;
    }
    
    public static int setPin(String pin, int ordid) throws SQLException {
        String sql = "UPDATE orderstatus SET pin = ? WHERE ordid = ?";
        int row = 0;
        conn = getConnection();
        PreparedStatement st;
        try {
            st = conn.prepareStatement(sql);
            st.setString(1, pin);
            st.setInt(2, ordid);
            row = st.executeUpdate();
            
        } catch (SQLException ex) {
            Logger.getLogger(DaoStore.class.getName()).log(Level.SEVERE, null, ex);
        } finally{
            conn.close();
        }
        return row;
    }
    
    public static int updateOrderStatus(PojoOrdersStatus pojo) throws SQLException {
        String sql;
        int flag = 0;
        if(pojo.getPin()=="NA"){
            flag = 1;
            sql = "UPDATE orderstatus SET deliverytime = ?, acceptstatus = ?, acceptedname = ?, acceptedcontact = ?, accepttime = ?, pin = ? WHERE ordid = ?";
        }else{
            sql = "UPDATE orderstatus SET deliverytime = ?, acceptstatus = ?, acceptedname = ?, acceptedcontact = ?, accepttime = ? WHERE ordid = ?";
        }
        
        System.out.println(sql);
        
        int row = 0;
        conn = getConnection();
        PreparedStatement st;
        try {
            st = conn.prepareStatement(sql);
            st.setString(1, pojo.getDeliverytime());
            st.setString(2, pojo.getAcceptstatus());
            st.setString(3, pojo.getAcceptedname());
            st.setString(4, pojo.getAcceptedcontact());
            st.setString(5, pojo.getAccepttime());
            if(flag==1){
                st.setString(6, pojo.getPin());
                st.setInt(7, pojo.getOrdid());
            }else{
                st.setInt(6, pojo.getOrdid());
            }
            row = st.executeUpdate();
            
        } catch (SQLException ex) {
            Logger.getLogger(DaoStore.class.getName()).log(Level.SEVERE, null, ex);
        } finally{
            conn.close();
        }
        return row;
    }
    
    public static int updateR(PojoOrdersStatus pojo) throws SQLException {
        String sql = "UPDATE orderstatus SET ordstatus = ?, ordarrivalat = ?, accepttime = ?,deliverytime = ?, acceptstatus = ?, acceptedname = ?, acceptedcontact = ? WHERE ordid = ?";
        
        int row = 0;
        conn = getConnection();
        PreparedStatement st;
        try {
            st = conn.prepareStatement(sql);
            st.setInt(1, pojo.getOrdstatus());
            st.setString(2, pojo.getOrdarrivalat());
            st.setString(3, pojo.getAccepttime());
            st.setString(4, pojo.getDeliverytime());
            st.setString(5, pojo.getAcceptstatus());
            st.setString(6, pojo.getAcceptedname());
            st.setString(7, pojo.getAcceptedcontact());
            st.setInt(8, pojo.getOrdid());
            row = st.executeUpdate();
            
        } catch (SQLException ex) {
            Logger.getLogger(DaoStore.class.getName()).log(Level.SEVERE, null, ex);
        } finally{
            conn.close();
        }
        return row;
    }
    
    

    public static void setOrderStatus(PojoOrdersStatus pojo) throws SQLException {
        String sql = "INSERT INTO orderstatus (ordid, ordstatus, ordarrivalat, deliverytime, acceptstatus, acceptedname, acceptedcontact) VALUES (?,?,?,?,?,?,?)";
  
        conn = getConnection();
        PreparedStatement st;
        try {
            st = conn.prepareStatement(sql);
            st.setInt(1, pojo.getOrdid());
            st.setInt(2, pojo.getOrdstatus());
            st.setString(3, pojo.getOrdarrivalat());
            st.setString(4, pojo.getDeliverytime());
            st.setString(5, pojo.getAcceptstatus());
            st.setString(6, pojo.getAcceptedname());
            st.setString(7, pojo.getAcceptedcontact());
            st.executeUpdate();

        } catch (SQLException ex) {
            Logger.getLogger(DaoStore.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            conn.close();
        }
    }
    
    public static void deleteOrderById(int ordid) throws SQLException {
        String sql = "DELETE FROM orderstatus WHERE ordid = ?";
        conn = getConnection();
        PreparedStatement st;
        try {
            st = conn.prepareStatement(sql);
            st.setInt(1, ordid);
            st.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(DaoStore.class.getName()).log(Level.SEVERE, null, ex);
        } finally{
            conn.close();
        }
    }
}
