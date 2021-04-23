package DAOs;

import POJOs.PojoCompare;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class DaoCompare {

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
    public static List<PojoCompare> getComparison(int cstmid) throws SQLException {
        String sql = "SELECT * FROM compare WHERE cstmid=?";
        List<PojoCompare> orders = new ArrayList();
        PojoCompare pojo;

        conn = getConnection();
        PreparedStatement st;
        try {
            st = conn.prepareStatement(sql);
            st.setInt(1, cstmid);
            ResultSet row = st.executeQuery();
            while (row.next()) {
                pojo = new PojoCompare();
                pojo.setCmprid(row.getInt("cmprid"));
                pojo.setPrdid(row.getInt("prdid"));
                pojo.setCstmid(row.getInt("cstmid"));
                orders.add(pojo);
            }
        } catch (SQLException ex) {
            Logger.getLogger(DaoStore.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            conn.close();
        }
        return orders;
    }
    
    public static PojoCompare getComparisonByIds(int prdid, int cstmid) throws SQLException {
        String sql = "SELECT * FROM compare WHERE prdid=? and cstmid=?";
        conn = getConnection();
        PojoCompare pojo = null;
        PreparedStatement st;
        try {
            st = conn.prepareStatement(sql);
            st.setInt(1, prdid);
            st.setInt(2, cstmid);
            ResultSet row = st.executeQuery();
            if (row.next()) {
                pojo = new PojoCompare();
                pojo.setCmprid(row.getInt("cmprid"));
                pojo.setPrdid(row.getInt("prdid"));
                pojo.setCstmid(row.getInt("cstmid"));
            }
        } catch (SQLException ex) {
            Logger.getLogger(DaoStore.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            conn.close();
        }
        return pojo;
    }

    public static int addComparison(PojoCompare pojo) throws SQLException {
        String sql = "INSERT INTO compare (prdid, cstmid) VALUES (?, ?)";
        conn = getConnection();
        int row = 0;
        PreparedStatement st;
        try {
            st = conn.prepareStatement(sql);
            st.setInt(1, pojo.getPrdid());
            st.setInt(2, pojo.getCstmid());
            row = st.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(DaoStore.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            conn.close();
        }
        return row;
    }
    
    public static int removeComparison(int cmprid) throws SQLException{
        String sql = "DELETE FROM compare WHERE cmprid = ?";
        conn = getConnection();
        int row = 0;
        PreparedStatement st;
        try {
            st = conn.prepareStatement(sql);
            st.setInt(1, cmprid);
            row = st.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(DaoStore.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            conn.close();
        }
        return row;
    }
}
