/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DAOs;

import POJOs.PojoOrderHistory;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class DaoOrderHistory {

    private static Connection conn = null;

    /* seprate function to establish connection */
    private static Connection getConnection() {
        
        try {
            Class.forName("com.mysql.jdbc.Driver");
            
            conn = (Connection) DriverManager.getConnection("jdbc:mysql://localhost:3306/supermartjava?user=root");
            
        } catch (ClassNotFoundException | SQLException ex) {
            Logger.getLogger(DaoStore.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        return conn;
    }
    
    public static int insertOrderHistory(PojoOrderHistory pojo) throws SQLException {
        String sql = "INSERT INTO orderhistory(ordid, cstmid, strid, ordcharge, deliveredby, acceptedtype, deliveredcontact, orderedtime, deliveredtime, billingname, billingaddress) VALUES (?,?,?,?,?,?,?,?,?,?,?)";
        
        int row = 0;
        conn = getConnection();
        PreparedStatement st;
        try {
            st = conn.prepareStatement(sql);
            st.setInt(1, pojo.getOrdid());
            st.setInt(2, pojo.getCstmid());
            st.setInt(3, pojo.getStrid());
            st.setInt(4, pojo.getOrdcharge());
            st.setString(5, pojo.getDeliveredby());
            st.setString(6, pojo.getAcceptedtype());
            st.setString(7, pojo.getDeliveredcontact());
            st.setString(8, pojo.getOrderedtime());
            st.setString(9, pojo.getDeliveredtime());
            st.setString(10, pojo.getBillingname());
            st.setString(11, pojo.getBillingaddress());
            row = st.executeUpdate();
            
        } catch (SQLException ex) {
            Logger.getLogger(DaoStore.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            conn.close();
        }
        return row;
    }

    /* get all store from the stores table */
    public static List<PojoOrderHistory> getOrderHistoryByCstmid(int cstmid) throws SQLException {
        String sql = "SELECT * FROM orderhistory WHERE cstmid = ?";
        List<PojoOrderHistory> history = new ArrayList();
        PojoOrderHistory pojo;
        
        conn = getConnection();
        PreparedStatement st;
        try {
            st = conn.prepareStatement(sql);
            st.setInt(1, cstmid);
            ResultSet rs = st.executeQuery();
            
            while (rs.next()) {
                pojo = new PojoOrderHistory();
                pojo.setOrdhistoryid(rs.getInt(1));
                pojo.setOrdid(rs.getInt(2));
                pojo.setCstmid(rs.getInt(3));
                pojo.setStrid(rs.getInt(4));
                pojo.setOrdcharge(rs.getInt(5));
                pojo.setDeliveredby(rs.getString(6));
                pojo.setAcceptedtype(rs.getString(7));
                pojo.setDeliveredcontact(rs.getString(8));
                pojo.setOrderedtime(rs.getString(9));
                pojo.setDeliveredtime(rs.getString(10));
                pojo.setBillingname(rs.getString(11));
                pojo.setBillingaddress(rs.getString(12));
                history.add(pojo);
            }
        } catch (SQLException ex) {
            Logger.getLogger(DaoStore.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            conn.close();
        }
        return history;
    }
    
    public static List<PojoOrderHistory> getOrderHistoryByStrid(int strid) throws SQLException {
        String sql = "SELECT * FROM orderhistory WHERE strid = ?";
        List<PojoOrderHistory> history = new ArrayList();
        PojoOrderHistory pojo;
        
        conn = getConnection();
        PreparedStatement st;
        try {
            st = conn.prepareStatement(sql);
            st.setInt(1, strid);
            ResultSet rs = st.executeQuery();
            
            while (rs.next()) {
                pojo = new PojoOrderHistory();
                pojo.setOrdhistoryid(rs.getInt(1));
                pojo.setOrdid(rs.getInt(2));
                pojo.setCstmid(rs.getInt(3));
                pojo.setStrid(rs.getInt(4));
                pojo.setOrdcharge(rs.getInt(5));
                pojo.setDeliveredby(rs.getString(6));
                pojo.setAcceptedtype(rs.getString(7));
                pojo.setDeliveredcontact(rs.getString(8));
                pojo.setOrderedtime(rs.getString(9));
                pojo.setDeliveredtime(rs.getString(10));
                pojo.setBillingname(rs.getString(11));
                pojo.setBillingaddress(rs.getString(12));
                history.add(pojo);
            }
        } catch (SQLException ex) {
            Logger.getLogger(DaoStore.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            conn.close();
        }
        return history;
    }
    
    public static PojoOrderHistory getOrderHistoryById(int ordhistoryid) throws SQLException {
        String sql = "SELECT * FROM orderhistory WHERE ordhistoryid = ?";
        PojoOrderHistory pojo = null;
        
        conn = getConnection();
        PreparedStatement st;
        try {
            st = conn.prepareStatement(sql);
            st.setInt(1, ordhistoryid);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                pojo = new PojoOrderHistory();
                pojo.setOrdhistoryid(rs.getInt(1));
                pojo.setOrdid(rs.getInt(2));
                pojo.setCstmid(rs.getInt(3));
                pojo.setStrid(rs.getInt(4));
                pojo.setOrdcharge(rs.getInt(5));
                pojo.setDeliveredby(rs.getString(6));
                pojo.setAcceptedtype(rs.getString(7));
                pojo.setDeliveredcontact(rs.getString(8));
                pojo.setOrderedtime(rs.getString(9));
                pojo.setDeliveredtime(rs.getString(10));
                pojo.setBillingname(rs.getString(11));
                pojo.setBillingaddress(rs.getString(12));
            }
        } catch (SQLException ex) {
            Logger.getLogger(DaoStore.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            conn.close();
        }
        return pojo;
    }
    
    public static PojoOrderHistory getOrderHistoryByordid(int ordid) throws SQLException {
        String sql = "SELECT * FROM orderhistory WHERE ordid = ?";
        PojoOrderHistory pojo = null;
        
        conn = getConnection();
        PreparedStatement st;
        try {
            st = conn.prepareStatement(sql);
            st.setInt(1, ordid);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                pojo = new PojoOrderHistory();
                pojo.setOrdhistoryid(rs.getInt(1));
                pojo.setOrdid(rs.getInt(2));
                pojo.setCstmid(rs.getInt(3));
                pojo.setStrid(rs.getInt(4));
                pojo.setOrdcharge(rs.getInt(5));
                pojo.setDeliveredby(rs.getString(6));
                pojo.setAcceptedtype(rs.getString(7));
                pojo.setDeliveredcontact(rs.getString(8));
                pojo.setOrderedtime(rs.getString(9));
                pojo.setDeliveredtime(rs.getString(10));
                pojo.setBillingname(rs.getString(11));
                pojo.setBillingaddress(rs.getString(12));
            }
        } catch (SQLException ex) {
            Logger.getLogger(DaoStore.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            conn.close();
        }
        return pojo;
    }
    
    public static int getLastRowId() throws SQLException {
        String sql = "SELECT ordhistoryid FROM orderhistory WHERE ordhistoryid = (SELECT MAX(ordhistoryid) FROM orderhistory)";
        conn = getConnection();
        int ordhistoryid = 0;
        PreparedStatement st;
        try {
            st = conn.prepareStatement(sql);
          
            ResultSet row = st.executeQuery();
            if (row.next()) {
               ordhistoryid = row.getInt("ordhistoryid");
            }
        } catch (SQLException ex) {
            Logger.getLogger(DaoStore.class.getName()).log(Level.SEVERE, null, ex);
        } finally{
            conn.close();
        }
        return ordhistoryid;
    }
    
    public static int getCntHistoryByStrid(int strid) throws SQLException {
        String sql = "SELECT COUNT(*) FROM orderhistory WHERE strid=?";
        conn = getConnection();
        int count = 0;
        PreparedStatement st;
        try {
            st = conn.prepareStatement(sql);
            st.setInt(1, strid);
            ResultSet row = st.executeQuery();
            if (row.next()) {
               count = row.getInt(1);
            }
        } catch (SQLException ex) {
            Logger.getLogger(DaoStore.class.getName()).log(Level.SEVERE, null, ex);
        } finally{
            conn.close();
        }
        return count;
    } 
    
}
