
package DAOs;

import POJOs.PojoVarifyStore;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

public class DaoVarifyStore {
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

     public static int insertVarifyStore(PojoVarifyStore pojo) throws SQLException {
       String sql = "INSERT INTO varifystore (strid, varified) VALUES (?, ?)";
        conn = getConnection();
        int row = 0;
        PreparedStatement st;
        try {
            st = conn.prepareStatement(sql);
            st.setInt(1, pojo.getStrid());
            st.setInt(2, pojo.getVarified());
            row = st.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(DaoStore.class.getName()).log(Level.SEVERE, null, ex);
        } finally{
            conn.close();
        }
        return row;
    }

      
    public static int updateVerified(int sts, int strid) throws SQLException{
    String sql = "UPDATE varifystore SET varified=? WHERE strid = ?";
        conn = getConnection();
        int row = 0;
        PreparedStatement st;
        try {
            st = conn.prepareStatement(sql);
            st.setInt(1, sts);
            st.setInt(2, strid);
            row = st.executeUpdate();
            
        } catch (SQLException ex) {
            Logger.getLogger(DaoStore.class.getName()).log(Level.SEVERE, null, ex);
        } finally{
            conn.close();
        }
        return row;
    }
    
    public static int getVerified(int strid) throws SQLException{
    String sql = "SELECT varified FROM varifystore WHERE strid = ?";
        conn = getConnection();
        int row = 0;
        PreparedStatement st;
        try {
            st = conn.prepareStatement(sql);
            st.setInt(1, strid);
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
    
    public static int deleteVarifiedByStrid(int strid) throws SQLException{
    String sql = "DELETE FROM varifystore WHERE strid = ?";
        conn = getConnection();
        int row = 0;
        PreparedStatement st;
        try {
            st = conn.prepareStatement(sql);
            st.setInt(1, strid);
            row = st.executeUpdate();
            
        } catch (SQLException ex) {
            Logger.getLogger(DaoStore.class.getName()).log(Level.SEVERE, null, ex);
        } finally{
            conn.close();
        }
        return row;
    }
    
}
