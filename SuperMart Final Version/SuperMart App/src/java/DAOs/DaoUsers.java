/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DAOs;

import POJOs.PojoUsers;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class DaoUsers {

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
    public static PojoUsers getUser(String email, String password) throws SQLException {
        String sql = "SELECT * FROM customers WHERE cstmemail=? AND cstmpassword=?";
        PojoUsers pojo = null;

        conn = getConnection();
        PreparedStatement st;
        try {
            st = conn.prepareStatement(sql);
            st.setString(1, email);
            st.setString(2, password);
            ResultSet row = st.executeQuery();
            if (row.next()) {
                pojo = new PojoUsers();
                pojo.setCstmid(row.getInt("cstmid"));
                pojo.setCstmname(row.getString("cstmname"));
                pojo.setCstmemail(row.getString("cstmemail"));
                pojo.setCstmcontact(row.getString("cstmcontact"));
                pojo.setCstmaddress(row.getString("cstmaddress"));
                pojo.setCstmpassword(row.getString("cstmpassword"));
                pojo.setCstmupdatedtime(row.getString("cstmupdatedtime"));
            }
        } catch (SQLException ex) {
            Logger.getLogger(DaoStore.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            conn.close();
        }
        return pojo;
    }

    public static PojoUsers userEsits(String name, String email) throws SQLException {
        String sql = "SELECT * FROM customers WHERE cstmname=? AND cstmemail=?";
        PojoUsers pojo = null;

        conn = getConnection();
        PreparedStatement st;
        try {
            st = conn.prepareStatement(sql);
            st.setString(1, name);
            st.setString(2, email);
            ResultSet row = st.executeQuery();
            if (row.next()) {
                pojo = new PojoUsers();
                pojo.setCstmid(row.getInt("cstmid"));
                pojo.setCstmname(row.getString("cstmname"));
                pojo.setCstmemail(row.getString("cstmemail"));
                pojo.setCstmcontact(row.getString("cstmcontact"));
                pojo.setCstmaddress(row.getString("cstmaddress"));
                pojo.setCstmpassword(row.getString("cstmpassword"));
                pojo.setCstmupdatedtime(row.getString("cstmupdatedtime"));
            }
        } catch (SQLException ex) {
            Logger.getLogger(DaoStore.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            conn.close();
        }
        return pojo;
    }

    public static int insertUser(PojoUsers pojo) throws SQLException {
        String sql = "INSERT INTO customers (cstmname, cstmemail, cstmcontact, cstmaddress, cstmpassword) VALUES (?,?,?,?,?)";
        int row = 0;
        conn = getConnection();
        PreparedStatement st;
        try {
            st = conn.prepareStatement(sql);
            st.setString(1, pojo.getCstmname());
            st.setString(2, pojo.getCstmemail());
            st.setString(3, pojo.getCstmcontact());
            st.setString(4, pojo.getCstmaddress());
            st.setString(5, pojo.getCstmpassword());
            row = st.executeUpdate();

        } catch (SQLException ex) {
            Logger.getLogger(DaoStore.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            conn.close();
        }
        return row;
    }

    public static int updateUser(PojoUsers pojo) throws SQLException {
        String sql = "UPDATE customers SET cstmname=?, cstmemail=?, cstmcontact=?, cstmaddress=?, cstmpassword=? WHERE cstmid = ?";
        int row = 0;
        conn = getConnection();
        PreparedStatement st;
        try {
            st = conn.prepareStatement(sql);
            st.setString(1, pojo.getCstmname());
            st.setString(2, pojo.getCstmemail());
            st.setString(3, pojo.getCstmcontact());
            st.setString(4, pojo.getCstmaddress());
            st.setString(5, pojo.getCstmpassword());
            st.setInt(6, pojo.getCstmid());
            row = st.executeUpdate();

        } catch (SQLException ex) {
            Logger.getLogger(DaoStore.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            conn.close();
        }
        return row;
    }

    public static PojoUsers getUserById(int cstmid) throws SQLException {
        String sql = "SELECT * FROM customers WHERE cstmid=?";
        PojoUsers pojo = null;

        conn = getConnection();
        PreparedStatement st;
        try {
            st = conn.prepareStatement(sql);
            st.setInt(1, cstmid);
            ResultSet row = st.executeQuery();
            if (row.next()) {
                pojo = new PojoUsers();
                pojo.setCstmid(row.getInt("cstmid"));
                pojo.setCstmname(row.getString("cstmname"));
                pojo.setCstmemail(row.getString("cstmemail"));
                pojo.setCstmcontact(row.getString("cstmcontact"));
                pojo.setCstmaddress(row.getString("cstmaddress"));
                pojo.setCstmpassword(row.getString("cstmpassword"));
                pojo.setCstmupdatedtime(row.getString("cstmupdatedtime"));
            }
        } catch (SQLException ex) {
            Logger.getLogger(DaoStore.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            conn.close();
        }
        return pojo;
    }
    
    public static int updatePwd(int cstmid, String pwd) throws SQLException {
        String sql = "UPDATE customers SET cstmpassword=? WHERE cstmid = ?";
        int row = 0;
        conn = getConnection();
        PreparedStatement st;
        try {
            st = conn.prepareStatement(sql);
            st.setString(1, pwd);
            st.setInt(2, cstmid);
            row = st.executeUpdate();

        } catch (SQLException ex) {
            Logger.getLogger(DaoStore.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            conn.close();
        }
        return row;
    }

    public static List<PojoUsers> getCustomers() throws SQLException {
        String sql = "SELECT * FROM customers";
        List<PojoUsers> customers = new ArrayList();
        PojoUsers pojo;

        conn = getConnection();
        PreparedStatement st;
        try {
            st = conn.prepareStatement(sql);
            ResultSet row = st.executeQuery();
            while (row.next()) {
                pojo = new PojoUsers();
                pojo.setCstmid(row.getInt("cstmid"));
                pojo.setCstmname(row.getString("cstmname"));
                pojo.setCstmemail(row.getString("cstmemail"));
                pojo.setCstmcontact(row.getString("cstmcontact"));
                pojo.setCstmaddress(row.getString("cstmaddress"));
                pojo.setCstmpassword(row.getString("cstmpassword"));
                pojo.setCstmupdatedtime(row.getString("cstmupdatedtime"));

                customers.add(pojo);
                
            }
        } catch (SQLException ex) {
            Logger.getLogger(DaoStore.class.getName()).log(Level.SEVERE, null, ex);
        } finally{
            conn.close();
        }
        return customers;
    }
    
    public static int deleteCstmById(int cstmid) throws SQLException {
       String sql = "DELETE FROM customers WHERE cstmid = ?";
       
        int row = 0;
        conn = getConnection();
        PreparedStatement st;
        try {
            st = conn.prepareStatement(sql);
            st.setInt(1, cstmid);
            
            row = st.executeUpdate();
            
        } catch (SQLException ex) {
            Logger.getLogger(DaoStore.class.getName()).log(Level.SEVERE, null, ex);
        } finally{
            conn.close();
        }
        return row;
    }
}
