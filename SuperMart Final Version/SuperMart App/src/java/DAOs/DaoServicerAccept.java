
package DAOs;

import POJOs.PojoServicerAccept;
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

public class DaoServicerAccept {
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
    public static List<PojoServicerAccept> getAllAcceptedByServicer(int id) throws SQLException {
        String sql = "SELECT * FROM serviceraccept WHERE servicerid = ?";
        List<PojoServicerAccept> ord = null;
        PojoServicerAccept pojo;

        conn = getConnection();
        PreparedStatement st;
        try {
            ord = new ArrayList();
            st = conn.prepareStatement(sql);
            st.setInt(1, id);
            ResultSet row = st.executeQuery();
            while (row.next()) {
                pojo = new PojoServicerAccept();
                pojo.setSaid(row.getInt(1));
                pojo.setServicerid(row.getInt(2));
                pojo.setOrdid(row.getInt(3));
                ord.add(pojo); 
            }
        } catch (SQLException ex) {
            Logger.getLogger(DaoStore.class.getName()).log(Level.SEVERE, null, ex);
        } finally{
            conn.close();
        }
        return ord;
    }
    
    public static PojoServicerAccept checkOrderIsInserted(int ordid) throws SQLException {
        String sql = "SELECT * FROM serviceraccept WHERE ordid = ?";
       
        PojoServicerAccept pojo = null;

        conn = getConnection();
        PreparedStatement st;
        try {
            
            st = conn.prepareStatement(sql);
            st.setInt(1, ordid);
            ResultSet row = st.executeQuery();
            if (row.next()) {
                pojo = new PojoServicerAccept();
                pojo.setSaid(row.getInt(1));
                pojo.setServicerid(row.getInt(2));
                pojo.setOrdid(row.getInt(3));
            }
        } catch (SQLException ex) {
            Logger.getLogger(DaoStore.class.getName()).log(Level.SEVERE, null, ex);
        } finally{
            conn.close();
        }
        return pojo;
    }
    
    public static int insertOrderById(int servicerid, int ordid) throws SQLException {
        String sql = "INSERT INTO serviceraccept (servicerid, ordid) VALUES (?,?) ";
        conn = getConnection();
        int row = 0;
        PreparedStatement st;
        try {
            st = conn.prepareStatement(sql);
            st.setInt(1, servicerid);
            st.setInt(2, ordid);
            row = st.executeUpdate();
            
        } catch (SQLException ex) {
            Logger.getLogger(DaoStore.class.getName()).log(Level.SEVERE, null, ex);
        } finally{
            conn.close();
        }
        return row;
    }
    
    /* get all store from the stores table */
    public static int countAccepted(int id) throws SQLException {
        String sql = "SELECT COUNT(*) FROM serviceraccept WHERE servicerid = ?";
        conn = getConnection();
        int row = 0;
        PreparedStatement st;
        try {
           
            st = conn.prepareStatement(sql);
            st.setInt(1, id);
            ResultSet set = st.executeQuery();
            if (set.next()) {
                row = set.getInt(1);
            }
        } catch (SQLException ex) {
            Logger.getLogger(DaoStore.class.getName()).log(Level.SEVERE, null, ex);
        } finally{
            conn.close();
        }
        return row;
    }
    
    /* get all store from the stores table */
    public static int deleteOrder(int ordid) throws SQLException {
        String sql = "DELETE FROM serviceraccept WHERE ordid = ?";
        conn = getConnection();
        int row = 0;
        PreparedStatement st;
        try {
           
            st = conn.prepareStatement(sql);
            st.setInt(1, ordid);
            row = st.executeUpdate();
            
        } catch (SQLException ex) {
            Logger.getLogger(DaoStore.class.getName()).log(Level.SEVERE, null, ex);
        } finally{
            conn.close();
        }
        return row;
    }    
}
