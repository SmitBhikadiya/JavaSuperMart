package DAOs;

import POJOs.PojoOrderRequest;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class DaoOrderRequest {
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
    public static List<PojoOrderRequest> getOrderDataByStrid(int strid, int orderstatus, int acceptstatus, int havingser) throws SQLException {
        String sql = "SELECT orders.ordid, orders.cstmid, orders.paymentmethod, orders.ordtotalbill, orderstatus.ordstatus, orderstatus.ordarrivalat, customers.cstmname, customers.cstmemail, customers.cstmcontact, customers.cstmaddress, orders.ordcharge FROM orderstatus JOIN orders ON orders.ordid = orderstatus.ordid JOIN customers ON orders.cstmid = customers.cstmid JOIN stores ON orders.strid = stores.strid WHERE orders.strid = ? AND ordstatus=? AND acceptstatus=? AND strhavingserviser = ? ORDER BY orders.ordid DESC";
        List<PojoOrderRequest> order = new ArrayList();
        PojoOrderRequest pojo = null;

        conn = getConnection();
        PreparedStatement st;
        try {
            st = conn.prepareStatement(sql);
            st.setInt(1, strid);
            st.setInt(2, orderstatus);
            st.setInt(3, acceptstatus);
            st.setInt(4, havingser);
            System.out.println(strid+" "+orderstatus+" "+acceptstatus+" "+havingser);
            ResultSet row = st.executeQuery();
            while (row.next()) {
                pojo = new PojoOrderRequest();
                pojo.setOrdid(row.getInt(1));
                pojo.setCstmid(row.getInt(2));
                pojo.setPaymethod(row.getString(3));
                pojo.setOrdtotalbill(row.getInt(4));
                pojo.setOrdstatus(row.getInt(5));
                pojo.setOrdarrivalat(row.getString(6));
                pojo.setCstmname(row.getString(7));
                pojo.setCstmemail(row.getString(8));
                pojo.setCstmcontact(row.getString(9));
                pojo.setCstmaddress(row.getString(10));
                pojo.setOrdcharge(row.getInt(11));
                order.add(pojo);
            }
        } catch (SQLException ex) {
            Logger.getLogger(DaoStore.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            conn.close();
        }
        return order;
    }
    
    public static List<PojoOrderRequest> getOrderDataByHaving(int orderstatus, int acceptstatus, int havingser) throws SQLException {
        String sql = "SELECT orders.ordid, orders.cstmid, orders.paymentmethod, orders.ordtotalbill, orderstatus.ordstatus, orderstatus.ordarrivalat, customers.cstmname, customers.cstmemail, customers.cstmcontact, customers.cstmaddress FROM orderstatus JOIN orders ON orders.ordid = orderstatus.ordid JOIN customers ON orders.cstmid = customers.cstmid JOIN stores ON orders.strid = stores.strid WHERE ordstatus=? AND acceptstatus=? AND strhavingserviser = ? ORDER BY orders.ordid DESC";
        List<PojoOrderRequest> order = new ArrayList();
        PojoOrderRequest pojo = null;

        conn = getConnection();
        PreparedStatement st;
        try {
            st = conn.prepareStatement(sql);
            st.setInt(1, orderstatus);
            st.setInt(2, acceptstatus);
            st.setInt(3, havingser);
            System.out.println(orderstatus+" "+acceptstatus+" "+havingser);
            ResultSet row = st.executeQuery();
            while (row.next()) {
                pojo = new PojoOrderRequest();
                pojo.setOrdid(row.getInt(1));
                pojo.setCstmid(row.getInt(2));
                pojo.setPaymethod(row.getString(3));
                pojo.setOrdtotalbill(row.getInt(4));
                pojo.setOrdstatus(row.getInt(5));
                pojo.setOrdarrivalat(row.getString(6));
                pojo.setCstmname(row.getString(7));
                pojo.setCstmemail(row.getString(8));
                pojo.setCstmcontact(row.getString(9));
                pojo.setCstmaddress(row.getString(10));
                order.add(pojo);
            }
        } catch (SQLException ex) {
            Logger.getLogger(DaoStore.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            conn.close();
        }
        return order;
    }
    
    
}