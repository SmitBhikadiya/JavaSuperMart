
package DAOs;

import POJOs.PojoProductsReview;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class DaoProductsReview {
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
    public static List getReviewByPrdid(int prdid) throws SQLException {
        String sql = "SELECT * FROM product_review WHERE prdid = ? ORDER BY rrating";
        List<PojoProductsReview> stores = new ArrayList();
        PojoProductsReview pojo = null;

        conn = getConnection();
        PreparedStatement st;
        try {
            st = conn.prepareStatement(sql);
            st.setInt(1, prdid);
            ResultSet row = st.executeQuery();
            while (row.next()) {
                pojo = new PojoProductsReview();
                pojo.setReviewid(row.getInt(1));
                pojo.setCstmid(row.getInt(2));
                pojo.setPrdid(row.getInt(3));
                pojo.setRname(row.getString(4));
                pojo.setRemail(row.getString(5));
                pojo.setRmsg(row.getString(6));
                pojo.setRrating(row.getInt(7));
                pojo.setTimestamp(row.getString(8));
                stores.add(pojo); 
            }
        } catch (SQLException ex) {
            Logger.getLogger(DaoStore.class.getName()).log(Level.SEVERE, null, ex);
        } finally{
            conn.close();
        }
        return stores;
    }
    
    public static PojoProductsReview getReviewByCstmid(int cstmid) throws SQLException {
        String sql = "SELECT * FROM product_review WHERE cstmid = ?";
        PojoProductsReview pojo = null;

        conn = getConnection();
        PreparedStatement st;
        try {
            st = conn.prepareStatement(sql);
            st.setInt(1, cstmid);
            ResultSet row = st.executeQuery();
            if (row.next()) {
                pojo = new PojoProductsReview();
                pojo.setReviewid(row.getInt(1));
                pojo.setCstmid(row.getInt(2));
                pojo.setPrdid(row.getInt(3));
                pojo.setRname(row.getString(4));
                pojo.setRemail(row.getString(5));
                pojo.setRmsg(row.getString(6));
                pojo.setRrating(row.getInt(7));
                pojo.setTimestamp(row.getString(8));
            }
        } catch (SQLException ex) {
            Logger.getLogger(DaoStore.class.getName()).log(Level.SEVERE, null, ex);
        } finally{
            conn.close();
        }
        return pojo;
    }
    
    public static int getOverallReviewBYprdid(int prdid) throws SQLException {
        String sql = "SELECT AVG(rrating) FROM product_review WHERE prdid=?";
        int rating = 0;

        conn = getConnection();
        PreparedStatement st;
        try {
            st = conn.prepareStatement(sql);
            st.setInt(1, prdid);
            ResultSet row = st.executeQuery();
            if (row.next()) {
               rating = row.getInt(1);
            }
        } catch (SQLException ex) {
            Logger.getLogger(DaoStore.class.getName()).log(Level.SEVERE, null, ex);
        } finally{
            conn.close();
        }
        return rating;
    }

    public static PojoProductsReview getReviewByIds(int cstmid, int prdid) throws SQLException {
        String sql = "SELECT * FROM product_review WHERE cstmid = ? AND prdid = ?";
        PojoProductsReview pojo = null;

        conn = getConnection();
        PreparedStatement st;
        try {
            st = conn.prepareStatement(sql);
            st.setInt(1, cstmid);
            st.setInt(2, prdid);
            ResultSet row = st.executeQuery();
            if (row.next()) {
                pojo = new PojoProductsReview();
                pojo.setReviewid(row.getInt(1));
                pojo.setCstmid(row.getInt(2));
                pojo.setPrdid(row.getInt(3));
                pojo.setRname(row.getString(4));
                pojo.setRemail(row.getString(5));
                pojo.setRmsg(row.getString(6));
                pojo.setRrating(row.getInt(7));
                pojo.setTimestamp(row.getString(8));
            }
        } catch (SQLException ex) {
            Logger.getLogger(DaoStore.class.getName()).log(Level.SEVERE, null, ex);
        } finally{
            conn.close();
        }
        return pojo;
    }

    
    public static int insertReview(PojoProductsReview pojo) throws SQLException {
        String sql = "INSERT INTO product_review (cstmid, prdid, rname, remail, rmsg, rrating) VALUES (?, ?, ?, ?, ?, ?)";
       
        int row = 0;
        conn = getConnection();
        PreparedStatement st;
        try {
            st = conn.prepareStatement(sql);
            st.setInt(1, pojo.getCstmid());
            st.setInt(2, pojo.getPrdid());
            st.setString(3, pojo.getRname());
            st.setString(4, pojo.getRemail());
            st.setString(5, pojo.getRmsg());
            st.setInt(6, pojo.getRrating());
            row = st.executeUpdate();
            
        } catch (SQLException ex) {
            Logger.getLogger(DaoStore.class.getName()).log(Level.SEVERE, null, ex);
        } finally{
            conn.close();
        }
        return row;
    }

    public static int updateProduct(int reviewid,String name,String email,String msg,int rating) throws SQLException {
       String sql = "UPDATE product_review SET rname=?, remail=?, rmsg=?, rrating=? WHERE reviewid=?";
       
        int row = 0;
        conn = getConnection();
        PreparedStatement st;
        try {
            st = conn.prepareStatement(sql);
            st.setString(1, name);
            st.setString(2, email);
            st.setString(3, msg);
            st.setInt(4, rating);
            st.setInt(5, reviewid);
            row = st.executeUpdate();
            
        } catch (SQLException ex) {
            Logger.getLogger(DaoStore.class.getName()).log(Level.SEVERE, null, ex);
        } finally{
            conn.close();
        }
        return row;
    }
    
    public static List<PojoProductsReview> getToprated(int limit) throws SQLException{
        String sql = "SELECT prdid, AVG(rrating) FROM product_review GROUP BY prdid ORDER BY AVG(rrating) DESC LIMIT ?";
        List<PojoProductsReview> top = new ArrayList();
        PojoProductsReview pojo = null;

        conn = getConnection();
        PreparedStatement st;
        try {
            st = conn.prepareStatement(sql);
            st.setInt(1, limit);
            ResultSet row = st.executeQuery();
            while (row.next()) {
                pojo = new PojoProductsReview();
                pojo.setPrdid(row.getInt(1));
                pojo.setPrdrating(row.getInt(2));
                top.add(pojo); 
            }
        } catch (SQLException ex) {
            Logger.getLogger(DaoStore.class.getName()).log(Level.SEVERE, null, ex);
        } finally{
            conn.close();
        }
        return top;
    }
    
    public static int deleteProductById(int reviewid) throws SQLException {
       String sql = "DELETE FROM product_review WHERE reviewid = ?";
       
        int row = 0;
        conn = getConnection();
        PreparedStatement st;
        try {
            st = conn.prepareStatement(sql);
            st.setInt(1, reviewid);
            
            row = st.executeUpdate();
            
        } catch (SQLException ex) {
            Logger.getLogger(DaoStore.class.getName()).log(Level.SEVERE, null, ex);
        } finally{
            conn.close();
        }
        return row;
    }
}
