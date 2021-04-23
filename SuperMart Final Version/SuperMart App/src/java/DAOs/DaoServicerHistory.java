
package DAOs;

import POJOs.PojoServicerHistory;
import POJOs.PojoStore;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class DaoServicerHistory {
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

    /* get all store from the stores table */
    public static int insertOrder(int sid, int ordhisid, int strid, int payment) throws SQLException {
        String sql = "INSERT INTO servicerhistory (servicerid, ordhistoryid, strid, payment) VALUES (?, ?, ?, ?)";

        int row = 0;
        conn = getConnection();
        PreparedStatement st;
        try {
            st = conn.prepareStatement(sql);
            st.setInt(1, sid);
            st.setInt(2, ordhisid);
            st.setInt(3, strid);
            st.setInt(4, payment);
            row = st.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(DaoStore.class.getName()).log(Level.SEVERE, null, ex);
        } finally{
            conn.close();
        }
        return row;
    }
    
    public static List<PojoServicerHistory> getHistoryByServicerId(int sid) throws SQLException {
        String sql = "SELECT * FROM servicerhistory WHERE servicerid = ?";
        List<PojoServicerHistory> hist = new ArrayList();
        PojoServicerHistory pojo;
        conn = getConnection();
        PreparedStatement st;
        try {
            st = conn.prepareStatement(sql);
            st.setInt(1, sid);
            ResultSet row = st.executeQuery();
            while(row.next()){
                pojo = new PojoServicerHistory();
                pojo.setServicerid(row.getInt(1));
                pojo.setOrdhistoryid(row.getInt(2));
                pojo.setStrid(row.getInt(3));
                hist.add(pojo);
            }
        } catch (SQLException ex) {
            Logger.getLogger(DaoStore.class.getName()).log(Level.SEVERE, null, ex);
        } finally{
            conn.close();
        }
        return hist;
    }
    
    public static PojoServicerHistory getHistoryByIds(int sid, int hisid) throws SQLException {
        String sql = "SELECT * FROM servicerhistory WHERE servicerid = ? AND ordhistoryid = ?";
        PojoServicerHistory pojo = null;
        conn = getConnection();
        PreparedStatement st;
        try {
            st = conn.prepareStatement(sql);
            st.setInt(1, sid);
            ResultSet row = st.executeQuery();
            if(row.next()){
                pojo = new PojoServicerHistory();
                pojo.setServicerid(row.getInt(1));
                pojo.setOrdhistoryid(row.getInt(2));
                pojo.setStrid(row.getInt(3));
            }
        } catch (SQLException ex) {
            Logger.getLogger(DaoStore.class.getName()).log(Level.SEVERE, null, ex);
        } finally{
            conn.close();
        }
        return pojo;
    }
    
    public static int getHistoryPayment(int sid) throws SQLException {
        String sql = "SELECT payment FROM servicerhistory WHERE servicerid = ?";
        int row = 0;
        conn = getConnection();
        PreparedStatement st;
        try {
            st = conn.prepareStatement(sql);
            st.setInt(1, sid);
            ResultSet set = st.executeQuery();
            if(set.next()){
               row = set.getInt(1);
            }
        } catch (SQLException ex) {
            Logger.getLogger(DaoStore.class.getName()).log(Level.SEVERE, null, ex);
        } finally{
            conn.close();
        }
        return row;
    }
    
    public static int updateHistoryPayment(int sid, int payment) throws SQLException {
        String sql = "UPDATE servicerhistory SET payment=? WHERE servicerid = ?";
        int row = 0;
        conn = getConnection();
        PreparedStatement st;
        try {
            st = conn.prepareStatement(sql);
            st.setInt(1, payment);
            st.setInt(2, sid);
            
            row = st.executeUpdate();
            
        } catch (SQLException ex) {
            Logger.getLogger(DaoStore.class.getName()).log(Level.SEVERE, null, ex);
        } finally{
            conn.close();
        }
        return row;
    }
    
    
     public static int getCntHistoryByServicerid(int sid) throws SQLException {
        String sql = "SELECT COUNT(*) FROM servicerhistory WHERE servicerid=?";
        conn = getConnection();
        int count = 0;
        PreparedStatement st;
        try {
            st = conn.prepareStatement(sql);
            st.setInt(1, sid);
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
