
package DAOs;

import POJOs.PojoOrderHistory;
import POJOs.PojoOrderHistoryList;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class DaoOrderHistoryList {
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
    
    public static int insertOrderHistoryList(PojoOrderHistoryList pojo) throws SQLException {
        String sql = "INSERT INTO orderhistorylist(ordhistoryid, prdid, prdname, prdprize, prdqty, prdtotal, prdimgpath) VALUES (?,?,?,?,?,?,?)";
        
        int row = 0;
        conn = getConnection();
        PreparedStatement st;
        try {
            st = conn.prepareStatement(sql);
            st.setInt(1, pojo.getOrdhistoryid());
            st.setInt(2, pojo.getPrdid());
            st.setString(3, pojo.getPrdname());
            st.setInt(4, pojo.getPrdprize());
            st.setInt(5, pojo.getPrdqty());
            st.setInt(6, pojo.getPrdtotal());
            st.setString(7, pojo.getPrdimgpath());
            row = st.executeUpdate();
            
        } catch (SQLException ex) {
            Logger.getLogger(DaoStore.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            conn.close();
        }
        return row;
    }

    /* get all store from the stores table */
    public static List<PojoOrderHistoryList> getHistoryListByCstmid(int cstmid) throws SQLException {
        String sql = "SELECT * FROM orderhistorylist WHERE cstmid = ?";
        List<PojoOrderHistoryList> history = new ArrayList();
        PojoOrderHistoryList pojo;
        
        conn = getConnection();
        PreparedStatement st;
        try {
            st = conn.prepareStatement(sql);
            st.setInt(1, cstmid);
            ResultSet rs = st.executeQuery();
            
            while (rs.next()) {
                pojo = new PojoOrderHistoryList();
                pojo.setOrdhistorylistid(rs.getInt(1));
                pojo.setOrdhistoryid(rs.getInt(2));
                pojo.setPrdid(rs.getInt(3));
                pojo.setPrdname(rs.getString(4));
                pojo.setPrdprize(rs.getInt(5));
                pojo.setPrdqty(rs.getInt(6));
                pojo.setPrdtotal(rs.getInt(7));
                pojo.setPrdimgpath(rs.getString(8));
               
                history.add(pojo);
            }
        } catch (SQLException ex) {
            Logger.getLogger(DaoStore.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            conn.close();
        }
        return history;
    }
    
    public static List<PojoOrderHistoryList> getHistoryListByOrdhid(int ordhistoryid) throws SQLException {
        String sql = "SELECT * FROM orderhistorylist WHERE ordhistoryid = ?";
        List<PojoOrderHistoryList> history = new ArrayList();
        PojoOrderHistoryList pojo;
        
        conn = getConnection();
        PreparedStatement st;
        try {
            st = conn.prepareStatement(sql);
            st.setInt(1, ordhistoryid);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                pojo = new PojoOrderHistoryList();
                pojo.setOrdhistorylistid(rs.getInt(1));
                pojo.setOrdhistoryid(rs.getInt(2));
                pojo.setPrdid(rs.getInt(3));
                pojo.setPrdname(rs.getString(4));
                pojo.setPrdprize(rs.getInt(5));
                pojo.setPrdqty(rs.getInt(6));
                pojo.setPrdtotal(rs.getInt(7));
                pojo.setPrdimgpath(rs.getString(8));
               
                history.add(pojo);
            }
        } catch (SQLException ex) {
            Logger.getLogger(DaoStore.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            conn.close();
        }
        return history;
    }
    
    public static int getHistoryListCntByIds(int cstmid, int prdid) throws SQLException {
        String sql = "SELECT COUNT(*) FROM orderhistorylist JOIN  orderhistory ON orderhistorylist.ordhistoryid = orderhistory.ordhistoryid WHERE orderhistory.cstmid = ? AND orderhistorylist.prdid = ?";
        int row = 0;
        conn = getConnection();
        PreparedStatement st;
        try {
            st = conn.prepareStatement(sql);
            st.setInt(1, cstmid);
            st.setInt(2, prdid);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
               row = rs.getInt(1);
            }
        } catch (SQLException ex) {
            Logger.getLogger(DaoStore.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            conn.close();
        }
        return row;
    }
    
    
    String sql = "";
    
    public static List<PojoOrderHistoryList> getOrderHistoryListById(int ordhistorylistid) throws SQLException {
        String sql = "SELECT * FROM orderhistorylist WHERE ordhistorylistid = ?";
        List<PojoOrderHistoryList> history = new ArrayList();
        PojoOrderHistoryList pojo;
        
        conn = getConnection();
        PreparedStatement st;
        try {
            st = conn.prepareStatement(sql);
            st.setInt(1, ordhistorylistid);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                pojo = new PojoOrderHistoryList();
                pojo.setOrdhistorylistid(rs.getInt(1));
                pojo.setOrdhistoryid(rs.getInt(2));
                pojo.setPrdid(rs.getInt(3));
                pojo.setPrdname(rs.getString(4));
                pojo.setPrdprize(rs.getInt(5));
                pojo.setPrdqty(rs.getInt(6));
                pojo.setPrdtotal(rs.getInt(7));
                pojo.setPrdimgpath(rs.getString(8));
                history.add(pojo);
            }
        } catch (SQLException ex) {
            Logger.getLogger(DaoStore.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            conn.close();
        }
        return history;
    }
}
