
package DAOs;

import POJOs.PojoShopkeeper;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class DaoShopkeeper {
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
    
    
    public static int insertAdminId(int adid) throws SQLException {
        String sql = "INSERT INTO shopkeepers (adid) VALUES (?)";
        int row = 0;
        conn = getConnection();
        PreparedStatement st;
        try {
            st = conn.prepareStatement(sql);
            st.setInt(1, adid);
            
            row = st.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(DaoStore.class.getName()).log(Level.SEVERE, null, ex);
        } finally{
            conn.close();
        }
        return row;
    }
    
    public static int updateStrid(int strid, int skid) throws SQLException {
        String sql = "Update shopkeepers SET strid=? WHERE skid = ?";
        int row = 0;
        conn = getConnection();
        PreparedStatement st;
        try {
            st = conn.prepareStatement(sql);
            st.setInt(1,strid);
            st.setInt(2,skid);
           
            row = st.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(DaoStore.class.getName()).log(Level.SEVERE, null, ex);
        } finally{
            conn.close();
        }
        return row;
    }
    
    public static int deleteShopkeeperByAdId(int adid) throws SQLException {
        String sql = "DELETE FROM shopkeepers WHERE adid = ?";
        int row = 0;
        conn = getConnection();
        PreparedStatement st;
        try {
            st = conn.prepareStatement(sql);
            st.setInt(1,adid);
           
            row = st.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(DaoStore.class.getName()).log(Level.SEVERE, null, ex);
        } finally{
            conn.close();
        }
        return row;
    }
    
    public static PojoShopkeeper getShopkeeperById(int adid) throws SQLException {
       String sql = "SELECT * FROM shopkeepers WHERE adid = ?";
        int row = 0;
        PojoShopkeeper pojo = null;
        conn = getConnection();
        PreparedStatement st;
        try {
            st = conn.prepareStatement(sql);
            st.setInt(1, adid);
            ResultSet set = st.executeQuery();
            if(set.next()){
                pojo = new PojoShopkeeper();
                pojo.setSkid(set.getInt(1));
                pojo.setAdid(set.getInt(2));
                pojo.setStrid(set.getInt(3));
                pojo.setUpdatedtime(set.getString(4));
            }
        } catch (SQLException ex) {
            Logger.getLogger(DaoStore.class.getName()).log(Level.SEVERE, null, ex);
        } finally{
            conn.close();
        }
        return pojo;
    }

    public static PojoShopkeeper getShopkeeperBySkid(int skid) throws SQLException {
       String sql = "SELECT * FROM shopkeepers WHERE skid = ?";
        PojoShopkeeper pojo = null;
        conn = getConnection();
        PreparedStatement st;
        try {
            st = conn.prepareStatement(sql);
            st.setInt(1, skid);
            ResultSet set = st.executeQuery();
            if(set.next()){
                pojo = new PojoShopkeeper();
                pojo.setSkid(set.getInt(1));
                pojo.setAdid(set.getInt(2));
                pojo.setStrid(set.getInt(3));
                pojo.setUpdatedtime(set.getString(4));
            }
        } catch (SQLException ex) {
            Logger.getLogger(DaoStore.class.getName()).log(Level.SEVERE, null, ex);
        } finally{
            conn.close();
        }
        return pojo;
    }
    public static List getShopkeeper() throws SQLException {
        String sql = "SELECT * FROM shopkeepers";
        List<PojoShopkeeper> stores = new ArrayList();
        PojoShopkeeper pojo = null;

        conn = getConnection();
        PreparedStatement st;
        try {
            st = conn.prepareStatement(sql);
            ResultSet row = st.executeQuery();
            while (row.next()) {
                pojo = new PojoShopkeeper();
                pojo.setSkid(row.getInt(1));
                pojo.setAdid(row.getInt(2));
                pojo.setStrid(row.getInt(3));
                pojo.setUpdatedtime(row.getString(4));
                stores.add(pojo); 
            }
        } catch (SQLException ex) {
            Logger.getLogger(DaoStore.class.getName()).log(Level.SEVERE, null, ex);
        } finally{
            conn.close();
        }
        return stores;
    }
    
    
    public static List getShopkeeperStrid() throws SQLException {
        String sql = "SELECT * FROM shopkeepers WHERE strid = ?";
        List<PojoShopkeeper> stores = new ArrayList();
        PojoShopkeeper pojo = null;

        conn = getConnection();
        PreparedStatement st;
        try {
            st = conn.prepareStatement(sql);
            st.setInt(1, 0);
            ResultSet row = st.executeQuery();
            while (row.next()) {
                pojo = new PojoShopkeeper();
                pojo.setSkid(row.getInt(1));
                pojo.setAdid(row.getInt(2));
                pojo.setStrid(row.getInt(3));
                pojo.setUpdatedtime(row.getString(4));
                stores.add(pojo); 
            }
        } catch (SQLException ex) {
            Logger.getLogger(DaoStore.class.getName()).log(Level.SEVERE, null, ex);
        } finally{
            conn.close();
        }
        return stores;
    }
    
}
