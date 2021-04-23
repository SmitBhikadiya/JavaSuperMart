
package DAOs;

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

public class DaoStore {

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
    public static List<PojoStore> getStores() throws SQLException {
        String sql = "SELECT * FROM stores ORDER BY RAND()";
        List<PojoStore> stores = new ArrayList();
        PojoStore pojo;

        conn = getConnection();
        PreparedStatement st;
        try {
            st = conn.prepareStatement(sql);
            ResultSet row = st.executeQuery();
            while (row.next()) {
                pojo = new PojoStore();
                pojo.setStrid(row.getInt("strid"));
                pojo.setSkid(row.getInt("skid"));
                pojo.setImgpath(row.getString("imgpath"));
                pojo.setStrname(row.getString("strname"));
                pojo.setStrcontact(row.getString("strcontact"));
                pojo.setStraddress(row.getString("straddress"));
                pojo.setStrhavingserviser(row.getInt("strhavingserviser"));
                pojo.setStropentime(row.getString("stropentime"));
                pojo.setStrclosetime(row.getString("strclosetime"));
                pojo.setStrupdatedtime(row.getString("strupdatedtime"));
                stores.add(pojo);
                
            }
        } catch (SQLException ex) {
            Logger.getLogger(DaoStore.class.getName()).log(Level.SEVERE, null, ex);
        } finally{
            conn.close();
        }
        return stores;
    }
    
    public static PojoStore getStoreById(int strid) throws SQLException{
        PojoStore pojo = null;
        conn = getConnection();
        String sql = "SELECT * FROM stores WHERE strid=?";
        try {
            PreparedStatement st = conn.prepareStatement(sql);
            st.setInt(1, strid);
            ResultSet row = st.executeQuery();
            if(row.next()){
                pojo = new PojoStore();
                pojo.setStrid(row.getInt("strid"));
                pojo.setSkid(row.getInt("skid"));
                pojo.setImgpath(row.getString("imgpath"));
                pojo.setStrname(row.getString("strname"));
                pojo.setStrcontact(row.getString("strcontact"));
                pojo.setStraddress(row.getString("straddress"));
                pojo.setStrhavingserviser(row.getInt("strhavingserviser"));
                pojo.setStropentime(row.getString("stropentime"));
                pojo.setStrclosetime(row.getString("strclosetime"));
                pojo.setStrupdatedtime(row.getString("strupdatedtime"));
                System.out.println(row.getString(4));
            }
        } catch (SQLException ex) {
            Logger.getLogger(DaoStore.class.getName()).log(Level.SEVERE, null, ex);
        } finally{
            conn.close();
        }
        return pojo;
    }
    
    /* get product count by using strore id */
    public static int productCnt(int strid) throws SQLException{
        int totalprd = 0;
        String sql = "SELECT COUNT(prdid) FROM products WHERE strid=?";
        conn = getConnection();
        try {
            PreparedStatement st = conn.prepareStatement(sql);
            st.setInt(1, strid);
            ResultSet set = st.executeQuery();
            if(set.next()){
                totalprd = set.getInt("COUNT(prdid)");
            }
        } catch (SQLException ex) {
            Logger.getLogger(DaoStore.class.getName()).log(Level.SEVERE, null, ex);
        } finally{
            conn.close();
        }
        
        return totalprd;
    }

    public static int getLastInsertedStrid() throws SQLException {
        String sql = "SELECT strid FROM stores WHERE strid = (SELECT MAX(strid) FROM stores)";
        conn = getConnection();
        int strid = 0;
        PreparedStatement st;
        try {
            st = conn.prepareStatement(sql);
          
            ResultSet row = st.executeQuery();
            if (row.next()) {
               strid = row.getInt("strid");
            }
        } catch (SQLException ex) {
            Logger.getLogger(DaoStore.class.getName()).log(Level.SEVERE, null, ex);
        } finally{
            conn.close();
        }
        return strid;
    }

    public static int insertStore(PojoStore pojo) throws SQLException {
       String sql = "INSERT INTO stores (skid, imgpath, strname, strcontact, straddress, stropentime, strclosetime, strhavingserviser) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        conn = getConnection();
        int row = 0;
        PreparedStatement st;
        try {
            st = conn.prepareStatement(sql);
            st.setInt(1, pojo.getSkid());
            st.setString(2, pojo.getImgpath());
            st.setString(3, pojo.getStrname());
            st.setString(4, pojo.getStrcontact());
            st.setString(5, pojo.getStraddress());
            st.setString(6, pojo.getStropentime());
            st.setString(7, pojo.getStrclosetime());
            st.setInt(8, pojo.getStrhavingserviser());
            row = st.executeUpdate();
            
        } catch (SQLException ex) {
            Logger.getLogger(DaoStore.class.getName()).log(Level.SEVERE, null, ex);
        } finally{
            conn.close();
        }
        return row;
    }

    public static int updateStore(PojoStore pojo) throws SQLException {
        String sql = "UPDATE stores SET skid=?, imgpath=?, strname=?, strcontact=?, straddress=?, stropentime=?, strclosetime=?, strhavingserviser=? WHERE strid = ?";
        conn = getConnection();
        int row = 0;
        PreparedStatement st;
        try {
            st = conn.prepareStatement(sql);
            st.setInt(1, pojo.getSkid());
            st.setString(2, pojo.getImgpath());
            st.setString(3, pojo.getStrname());
            st.setString(4, pojo.getStrcontact());
            st.setString(5, pojo.getStraddress());
            st.setString(6, pojo.getStropentime());
            st.setString(7, pojo.getStrclosetime());
            st.setInt(8, pojo.getStrhavingserviser());
            st.setInt(9, pojo.getStrid());
            row = st.executeUpdate();
            
        } catch (SQLException ex) {
            Logger.getLogger(DaoStore.class.getName()).log(Level.SEVERE, null, ex);
        } finally{
            conn.close();
        }
        return row;
    }

    public static int deleteShopById(int shopid) throws SQLException {
       String sql = "DELETE FROM stores WHERE strid = ?";
       
        int row = 0;
        conn = getConnection();
        PreparedStatement st;
        try {
            st = conn.prepareStatement(sql);
            st.setInt(1, shopid);
            
            row = st.executeUpdate();
            
        } catch (SQLException ex) {
            Logger.getLogger(DaoStore.class.getName()).log(Level.SEVERE, null, ex);
        } finally{
            conn.close();
        }
        return row;
    }
}
