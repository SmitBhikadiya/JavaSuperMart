
package DAOs;

import POJOs.PojoFeedback;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class DaoFeedback {
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
    public static int insertFeedback(PojoFeedback pojo) throws SQLException {
        String sql = "INSERT INTO feedback (ordid, overall_rat, products_rat, delivery_service, review_msg) VALUES (?, ?, ?, ?, ?)";
        int row = 0;

        conn = getConnection();
        PreparedStatement st;
        try {
            st = conn.prepareStatement(sql);
            st.setInt(1, pojo.getOrdid());
            st.setInt(2, pojo.getOverall_rat());
            st.setInt(3, pojo.getProducts_rat());
            st.setString(4, pojo.getDelivery_service());
            st.setString(5, pojo.getReview_msg());
            row = st.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(DaoStore.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            conn.close();
        }
        return row;
    }
    
    public static int updateFeedback(PojoFeedback pojo) throws SQLException {
        String sql = "UPDATE feedback SET overall_rat=?, products_rat=?, delivery_service=?, review_msg=? WHERE ordid=?";
        int row = 0;

        conn = getConnection();
        PreparedStatement st;
        try {
            st = conn.prepareStatement(sql);
            st.setInt(5, pojo.getOrdid());
            st.setInt(1, pojo.getOverall_rat());
            st.setInt(2, pojo.getProducts_rat());
            st.setString(3, pojo.getDelivery_service());
            st.setString(4, pojo.getReview_msg());
            row = st.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(DaoStore.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            conn.close();
        }
        return row;
    }
    
    public static PojoFeedback getFeedbackByordid(int ordid) throws SQLException {
       String sql = "SELECT * FROM feedback WHERE ordid = ?";
        PojoFeedback pojo = null;
        conn = getConnection();
        PreparedStatement st;
        try {
            st = conn.prepareStatement(sql);
            st.setInt(1, ordid);
            ResultSet set = st.executeQuery();
            if(set.next()){
                pojo = new PojoFeedback();
                pojo.setOrdratid(set.getInt(1));
                pojo.setOrdid(set.getInt(2));
                pojo.setOverall_rat(set.getInt(3));
                pojo.setProducts_rat(set.getInt(4));
                pojo.setDelivery_service(set.getString(5));
                pojo.setReview_msg(set.getString(6));
                pojo.setTimestamp(set.getString(7));
                pojo.setIsTestimonial(set.getInt(8));
            }
        } catch (SQLException ex) {
            Logger.getLogger(DaoStore.class.getName()).log(Level.SEVERE, null, ex);
        } finally{
            conn.close();
        }
        return pojo;
    }
    
    public static PojoFeedback getFeedbackByFeedid(int feedid) throws SQLException {
       String sql = "SELECT * FROM feedback WHERE ordratid = ?";
        PojoFeedback pojo = null;
        conn = getConnection();
        PreparedStatement st;
        try {
            st = conn.prepareStatement(sql);
            st.setInt(1, feedid);
            ResultSet set = st.executeQuery();
            if(set.next()){
                pojo = new PojoFeedback();
                pojo.setOrdratid(set.getInt(1));
                pojo.setOrdid(set.getInt(2));
                pojo.setOverall_rat(set.getInt(3));
                pojo.setProducts_rat(set.getInt(4));
                pojo.setDelivery_service(set.getString(5));
                pojo.setReview_msg(set.getString(6));
                pojo.setTimestamp(set.getString(7));
                pojo.setIsTestimonial(set.getInt(8));
            }
        } catch (SQLException ex) {
            Logger.getLogger(DaoStore.class.getName()).log(Level.SEVERE, null, ex);
        } finally{
            conn.close();
        }
        return pojo;
    }
    
    public static List<PojoFeedback> getAllFeedback() throws SQLException {
       String sql = "SELECT * FROM feedback";
        PojoFeedback pojo = null;
        List<PojoFeedback> list = new ArrayList();
        conn = getConnection();
        PreparedStatement st;
        try {
            st = conn.prepareStatement(sql);
            ResultSet set = st.executeQuery();
            while(set.next()){
                pojo = new PojoFeedback();
                pojo.setOrdratid(set.getInt(1));
                pojo.setOrdid(set.getInt(2));
                pojo.setOverall_rat(set.getInt(3));
                pojo.setProducts_rat(set.getInt(4));
                pojo.setDelivery_service(set.getString(5));
                pojo.setReview_msg(set.getString(6));
                pojo.setTimestamp(set.getString(7));
                pojo.setIsTestimonial(set.getInt(8));
                list.add(pojo);
            }
        } catch (SQLException ex) {
            Logger.getLogger(DaoStore.class.getName()).log(Level.SEVERE, null, ex);
        } finally{
            conn.close();
        }
        return list;
    }
    
    public static List<PojoFeedback> getAllFeedbackBytest() throws SQLException {
       String sql = "SELECT * FROM feedback WHERE isTestimonial = 1";
        PojoFeedback pojo = null;
        List<PojoFeedback> list = new ArrayList();
        conn = getConnection();
        PreparedStatement st;
        try {
            st = conn.prepareStatement(sql);
            ResultSet set = st.executeQuery();
            while(set.next()){
                pojo = new PojoFeedback();
                pojo.setOrdratid(set.getInt(1));
                pojo.setOrdid(set.getInt(2));
                pojo.setOverall_rat(set.getInt(3));
                pojo.setProducts_rat(set.getInt(4));
                pojo.setDelivery_service(set.getString(5));
                pojo.setReview_msg(set.getString(6));
                pojo.setTimestamp(set.getString(7));
                pojo.setIsTestimonial(set.getInt(8));
                list.add(pojo);
            }
        } catch (SQLException ex) {
            Logger.getLogger(DaoStore.class.getName()).log(Level.SEVERE, null, ex);
        } finally{
            conn.close();
        }
        return list;
    }
    
    public static int updateTestimonial(int feedid, int sts) throws SQLException {
        String sql = "UPDATE feedback SET isTestimonial=? WHERE ordratid=?";
        int row = 0;

        conn = getConnection();
        PreparedStatement st;
        try {
            st = conn.prepareStatement(sql);
            st.setInt(1, sts);
            st.setInt(2, feedid);
            row = st.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(DaoStore.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            conn.close();
        }
        return row;
    }

    public static int deleteFeedback(int id) throws SQLException {
    String sql = "DELETE FROM feedback WHERE ordratid = ?";
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
    
}
