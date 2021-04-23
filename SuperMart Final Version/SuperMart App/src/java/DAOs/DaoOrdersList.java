package DAOs;

import POJOs.PojoOrdersList;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class DaoOrdersList {

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
    public static PojoOrdersList getOrdLsByIds(int ordid, int prdid) throws SQLException {
        String sql = "SELECT * FROM orderlist WHERE ordid=? and prdid=?";
        PojoOrdersList pojo = null;

        conn = getConnection();
        PreparedStatement st;
        try {
            st = conn.prepareStatement(sql);
            st.setInt(1, ordid);
            st.setInt(2, prdid);
            ResultSet row = st.executeQuery();
            if (row.next()) {
                pojo = new PojoOrdersList();
                pojo.setOrdid(row.getInt("ordlistid"));
                pojo.setOrdlistid(row.getInt("ordlistid"));
                pojo.setPrdid(row.getInt("prdid"));
                pojo.setPrdqty(row.getInt("prdqty"));
                pojo.setPrdtotalamount(row.getInt("prdtotalamount"));
            }
        } catch (SQLException ex) {
            Logger.getLogger(DaoStore.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            conn.close();
        }
        return pojo;
    }

    public static void insertOrderList(PojoOrdersList pojo) throws SQLException {

        String sql = "INSERT INTO orderlist (ordid, prdid, prdqty, prdtotalamount) VALUES (?,?,?,?)";
   
        
        conn = getConnection();
        PreparedStatement st;
        try {
            st = conn.prepareStatement(sql);
            st.setInt(1, pojo.getOrdid());
            st.setInt(2, pojo.getPrdid());
            st.setInt(3, pojo.getPrdqty());
            st.setInt(4, pojo.getPrdtotalamount());
            st.executeUpdate();

        } catch (SQLException ex) {
            Logger.getLogger(DaoStore.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            conn.close();
        }
    }
    
    public static PojoOrdersList getOrdLsByListId(int ordlistid) throws SQLException {
        String sql = "SELECT * FROM orderlist WHERE ordlistid = ?";
        PojoOrdersList pojo = null;

        conn = getConnection();
        PreparedStatement st;
        try {
            st = conn.prepareStatement(sql);
            st.setInt(1, ordlistid);
            ResultSet row = st.executeQuery();
            if (row.next()) {
                pojo = new PojoOrdersList();
                pojo.setOrdid(row.getInt("ordlistid"));
                pojo.setOrdlistid(row.getInt("ordlistid"));
                pojo.setPrdid(row.getInt("prdid"));
                pojo.setPrdqty(row.getInt("prdqty"));
                pojo.setPrdtotalamount(row.getInt("prdtotalamount"));
            }
        } catch (SQLException ex) {
            Logger.getLogger(DaoStore.class.getName()).log(Level.SEVERE, null, ex);
        } finally{
            conn.close();
        }
        return pojo;
    }
    
    public static int updateTotal(int ordlistid, int prdqty, int prdtotalamount) throws SQLException {
        String sql = "UPDATE orderlist SET prdqty = ?, prdtotalamount= ? WHERE ordlistid = ?";
        int row = 0;
        conn = getConnection();
        PreparedStatement st;
        try {
            st = conn.prepareStatement(sql);
            st.setInt(1, prdqty);
            st.setInt(2, prdtotalamount);
            st.setInt(3, ordlistid);
            row = st.executeUpdate();
            
        } catch (SQLException ex) {
            Logger.getLogger(DaoStore.class.getName()).log(Level.SEVERE, null, ex);
        } finally{
            conn.close();
        }
        return row;
    }
    
    public static List<PojoOrdersList> getOrdByOrdid(int ordid) throws SQLException {
        String sql = "SELECT * FROM orderlist WHERE ordid = ?";
        PojoOrdersList pojo = null;
        List<PojoOrdersList> list = new ArrayList();
        conn = getConnection();
        PreparedStatement st;
        try {
            st = conn.prepareStatement(sql);
            st.setInt(1, ordid);
            ResultSet row = st.executeQuery();
            while (row.next()) {
                pojo = new PojoOrdersList();
                pojo.setOrdid(row.getInt("ordlistid"));
                pojo.setOrdlistid(row.getInt("ordlistid"));
                pojo.setPrdid(row.getInt("prdid"));
                pojo.setPrdqty(row.getInt("prdqty"));
                pojo.setPrdtotalamount(row.getInt("prdtotalamount"));
                list.add(pojo);
            }
        } catch (SQLException ex) {
            Logger.getLogger(DaoStore.class.getName()).log(Level.SEVERE, null, ex);
        } finally{
            conn.close();
        }
        return list;
    }
    
    public static int deleteOrderById(int ordlistid) throws SQLException {
        String sql = "DELETE FROM orderlist WHERE ordlistid = ?";
        int row = 0;
        conn = getConnection();
        PreparedStatement st;
        try {
            st = conn.prepareStatement(sql);
            st.setInt(1, ordlistid);
            row = st.executeUpdate();
            
        } catch (SQLException ex) {
            Logger.getLogger(DaoStore.class.getName()).log(Level.SEVERE, null, ex);
        } finally{
            conn.close();
        }
        return row;
    }

}
