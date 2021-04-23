
package DAOs;

import POJOs.PojoServicer;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

public class DaoServicer {
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
    public static int inserteAdminId(int id) throws SQLException {
        String sql = "INSERT INTO servicer (adid) VALUES (?)";
        int row = 0;

        conn = getConnection();
        PreparedStatement st;
        try {
            st = conn.prepareStatement(sql);
            st.setInt(1, id);
            row = st.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(DaoStore.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            conn.close();
        }
        return row;
    }
    
    public static PojoServicer getServicerById(int adid) throws SQLException {
       String sql = "SELECT * FROM servicer WHERE adid = ?";
        PojoServicer pojo = null;
        conn = getConnection();
        PreparedStatement st;
        try {
            st = conn.prepareStatement(sql);
            st.setInt(1, adid);
            ResultSet set = st.executeQuery();
            if(set.next()){
                pojo = new PojoServicer();
                pojo.setServicerid(set.getInt(1));
                pojo.setAdid(set.getInt(2));
            }
        } catch (SQLException ex) {
            Logger.getLogger(DaoStore.class.getName()).log(Level.SEVERE, null, ex);
        } finally{
            conn.close();
        }
        return pojo;
    }
}
