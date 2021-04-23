package DAOs;

import POJOs.PojoATC;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class DaoATC {

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
    public static List getATCByCstmId(int cstmid) throws SQLException {
        String sql = "SELECT orders.cstmid, orders.ordid,"
                + "orderlist.prdid, orderlist.ordlistid, orderlist.prdqty, orderlist.prdtotalamount,"
                + "products.imgpath, products.prdname, products.prdprize, products.prdunit, products.prddiscount, products.prdtotalqty, products.prdcategory, products.prddescription "
                + "FROM orders "
                + "JOIN orderlist ON orderlist.ordid = orders.ordid "
                + "JOIN orderstatus ON orderstatus.ordid = orders.ordid "
                + "JOIN products ON products.prdid = orderlist.prdid "
                + "WHERE orders.cstmid = ? AND orderstatus.ordstatus = 0";
        List<PojoATC> atc = new ArrayList();
        PojoATC pojo = null;

        conn = getConnection();
        PreparedStatement st;
        try {
            st = conn.prepareStatement(sql);
            st.setInt(1, cstmid);
            ResultSet row = st.executeQuery();
            while (row.next()) {
                pojo = new PojoATC();
                pojo.setCstmid(row.getInt(1));
                pojo.setOrdid(row.getInt(2));
                pojo.setPrdid(row.getInt(3));
                pojo.setOrdlistid(row.getInt(4));
                pojo.setPrdqty(row.getInt(5));
                pojo.setPrdtotalamount(row.getInt(6));
                pojo.setImgpath(row.getString(7));
                pojo.setPrdname(row.getString(8));
                pojo.setPrdprize(row.getInt(9));
                pojo.setPrdunit(row.getString(10));
                pojo.setPrddiscount(row.getInt(11));
                pojo.setStock(row.getInt(12));
                pojo.setPrdcategory(row.getString(13));
                pojo.setPrddescription(row.getString(14));
                atc.add(pojo);
            }
        } catch (SQLException ex) {
            Logger.getLogger(DaoStore.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            conn.close();
        }
        return atc;
    }

    public static List getATCByIds(int strid, int ordid, int orderstatus) throws SQLException {
        String sql = "SELECT orders.cstmid, orders.ordid, orderlist.prdid, orderlist.ordlistid, orderlist.prdqty, orderlist.prdtotalamount, products.imgpath, products.prdname, products.prdprize, products.prdunit, products.prddiscount, products.prdtotalqty, products.prdcategory, products.prddescription FROM orderlist JOIN products ON products.prdid = orderlist.prdid JOIN orders ON orders.ordid = orderlist.ordid JOIN orderstatus ON orderstatus.ordid = orders.ordid WHERE products.strid = ? AND orderlist.ordid = ? AND orderstatus.ordstatus = ?";
        List<PojoATC> atc = new ArrayList();
        PojoATC pojo = null;

        conn = getConnection();
        PreparedStatement st;
        try {
            st = conn.prepareStatement(sql);
            st.setInt(1, strid);
            st.setInt(2, ordid);
            st.setInt(3, orderstatus);
            ResultSet row = st.executeQuery();
            while (row.next()) {
                pojo = new PojoATC();
                pojo.setCstmid(row.getInt(1));
                pojo.setOrdid(row.getInt(2));
                pojo.setPrdid(row.getInt(3));
                pojo.setOrdlistid(row.getInt(4));
                pojo.setPrdqty(row.getInt(5));
                pojo.setPrdtotalamount(row.getInt(6));
                pojo.setImgpath(row.getString(7));
                pojo.setPrdname(row.getString(8));
                pojo.setPrdprize(row.getInt(9));
                pojo.setPrdunit(row.getString(10));
                pojo.setPrddiscount(row.getInt(11));
                pojo.setStock(row.getInt(12));
                pojo.setPrdcategory(row.getString(13));
                pojo.setPrddescription(row.getString(14));
                atc.add(pojo);
            }
        } catch (SQLException ex) {
            Logger.getLogger(DaoStore.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            conn.close();
        }
        return atc;
    }
    
    public static List getATCByAcsSts(int strid, int ordid, int acceptstatus) throws SQLException {
        String sql = "SELECT orders.cstmid, orders.ordid, orderlist.prdid, orderlist.ordlistid, orderlist.prdqty, orderlist.prdtotalamount, products.imgpath, products.prdname, products.prdprize, products.prdunit, products.prddiscount, products.prdtotalqty, products.prdcategory, products.prddescription, orders.ordcharge FROM orderlist JOIN products ON products.prdid = orderlist.prdid JOIN orders ON orders.ordid = orderlist.ordid JOIN orderstatus ON orderstatus.ordid = orders.ordid WHERE products.strid = ? AND orderlist.ordid = ? AND orderstatus.acceptstatus = ?";
        List<PojoATC> atc = new ArrayList();
        PojoATC pojo = null;

        conn = getConnection();
        PreparedStatement st;
        try {
            st = conn.prepareStatement(sql);
            st.setInt(1, strid);
            st.setInt(2, ordid);
            st.setInt(3, acceptstatus);
            ResultSet row = st.executeQuery();
            while (row.next()) {
                pojo = new PojoATC();
                pojo.setCstmid(row.getInt(1));
                pojo.setOrdid(row.getInt(2));
                pojo.setPrdid(row.getInt(3));
                pojo.setOrdlistid(row.getInt(4));
                pojo.setPrdqty(row.getInt(5));
                pojo.setPrdtotalamount(row.getInt(6));
                pojo.setImgpath(row.getString(7));
                pojo.setPrdname(row.getString(8));
                pojo.setPrdprize(row.getInt(9));
                pojo.setPrdunit(row.getString(10));
                pojo.setPrddiscount(row.getInt(11));
                pojo.setStock(row.getInt(12));
                pojo.setPrdcategory(row.getString(13));
                pojo.setPrddescription(row.getString(14));
                pojo.setOrdcharge(row.getInt(15));
                atc.add(pojo);
            }
        } catch (SQLException ex) {
            Logger.getLogger(DaoStore.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            conn.close();
        }
        return atc;
    }
    
    public static int getOrdSts(int cstmid, int prdid) throws SQLException{
        int sts = -1;
        String sql = "SELECT ordstatus FROM orderstatus " +
                     "JOIN orders ON orders.ordid = orderstatus.ordid " +
                     "JOIN orderlist ON orderlist.ordid = orders.ordid " +
                     "WHERE orderlist.prdid = ? AND orders.cstmid = ?";
        conn = getConnection();
        PreparedStatement st;
        try {
            st = conn.prepareStatement(sql);
            st.setInt(1, prdid);
            st.setInt(2, cstmid);
            ResultSet set = st.executeQuery();
            if(set.next()){
                sts = set.getInt(1);
            }
        } catch (SQLException ex) {
            Logger.getLogger(DaoStore.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            conn.close();
        }
        return sts;
    }
    
}
