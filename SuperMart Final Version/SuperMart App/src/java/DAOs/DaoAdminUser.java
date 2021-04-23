package DAOs;

import POJOs.PojoAdminUser;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import java.util.logging.Level;
import java.util.logging.Logger;

public class DaoAdminUser {

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
    public static PojoAdminUser getAdminBy(String usertype, String email, String password) throws SQLException {
        String sql = "SELECT * FROM adminuser WHERE adtype = ? AND ademail = ? AND adpassword = ?";
        PojoAdminUser pojo = null;

        conn = getConnection();
        PreparedStatement st;
        try {
            st = conn.prepareStatement(sql);
            st.setString(1, usertype);
            st.setString(2, email);
            st.setString(3, password);
            ResultSet row = st.executeQuery();
            if (row.next()) {
                pojo = new PojoAdminUser();
                pojo.setAdid(row.getInt(1));
                pojo.setAdname(row.getString(2));
                pojo.setAdemail(row.getString(3));
                pojo.setAdcontact(row.getString(4));
                pojo.setAdtype(row.getString(5));
                pojo.setAdpassword(row.getString(6));
                pojo.setAdaddress(row.getString(7));
            }
        } catch (SQLException ex) {
            Logger.getLogger(DaoStore.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            conn.close();
        }
        return pojo;
    }

    public static PojoAdminUser getAdminBy(String usertype, String email) throws SQLException {
        String sql = "SELECT * FROM adminuser WHERE adtype = ? AND ademail = ?";
        PojoAdminUser pojo = null;

        conn = getConnection();
        PreparedStatement st;
        try {
            st = conn.prepareStatement(sql);
            st.setString(1, usertype);
            st.setString(2, email);
            ResultSet row = st.executeQuery();
            if (row.next()) {
                pojo = new PojoAdminUser();
                pojo.setAdid(row.getInt(1));
                pojo.setAdname(row.getString(2));
                pojo.setAdemail(row.getString(3));
                pojo.setAdcontact(row.getString(4));
                pojo.setAdtype(row.getString(5));
                pojo.setAdpassword(row.getString(6));
                pojo.setAdaddress(row.getString(7));
            }
        } catch (SQLException ex) {
            Logger.getLogger(DaoStore.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            conn.close();
        }
        return pojo;
    }

    public static PojoAdminUser getAdminById(int adid) throws SQLException {
        String sql = "SELECT * FROM adminuser WHERE adid = ?";
        PojoAdminUser pojo = null;

        conn = getConnection();
        PreparedStatement st;
        try {
            st = conn.prepareStatement(sql);
            st.setInt(1, adid);
            ResultSet row = st.executeQuery();
            if (row.next()) {
                pojo = new PojoAdminUser();
                pojo.setAdid(row.getInt(1));
                pojo.setAdname(row.getString(2));
                pojo.setAdemail(row.getString(3));
                pojo.setAdcontact(row.getString(4));
                pojo.setAdtype(row.getString(5));
                pojo.setAdpassword(row.getString(6));
                pojo.setAdaddress(row.getString(7));
            }
        } catch (SQLException ex) {
            Logger.getLogger(DaoStore.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            conn.close();
        }
        return pojo;
    }

    public static int insertAdmin(PojoAdminUser pojo) throws SQLException {
        String sql = "INSERT INTO adminuser (adname, ademail, adcontact, adtype, adpassword, adaddress) VALUES (?,?,?,?,?,?)";
        int row = 0;
        conn = getConnection();
        PreparedStatement st;
        try {
            st = conn.prepareStatement(sql);
            st.setString(1, pojo.getAdname());
            st.setString(2, pojo.getAdemail());
            st.setString(3, pojo.getAdcontact());
            st.setString(4, pojo.getAdtype());
            st.setString(5, pojo.getAdpassword());
            st.setString(6, pojo.getAdaddress());
            row = st.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(DaoStore.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            conn.close();
        }
        return row;
    }

    public static int updateAdmin(PojoAdminUser pojo) throws SQLException {
        String sql = "Update adminuser SET adname=?, ademail=?, adcontact=?, adtype=?, adpassword=?, adaddress=? WHERE adid = ?";
        int row = 0;
        conn = getConnection();
        PreparedStatement st;
        try {
            st = conn.prepareStatement(sql);
            st.setString(1, pojo.getAdname());
            st.setString(2, pojo.getAdemail());
            st.setString(3, pojo.getAdcontact());
            st.setString(4, pojo.getAdtype());
            st.setString(5, pojo.getAdpassword());
            st.setString(6, pojo.getAdaddress());
            st.setInt(7, pojo.getAdid());
            row = st.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(DaoStore.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            conn.close();
        }
        return row;
    }

    public static int getLastInsertedData() throws SQLException {
        String sql = "SELECT adid FROM adminuser WHERE adid = (SELECT MAX(adid) FROM adminuser)";
        conn = getConnection();
        int adid = 0;
        PreparedStatement st;
        try {
            st = conn.prepareStatement(sql);

            ResultSet row = st.executeQuery();
            if (row.next()) {
                adid = row.getInt(1);
            }
        } catch (SQLException ex) {
            Logger.getLogger(DaoStore.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            conn.close();
        }
        return adid;
    }

    public static int updateAdminBy(PojoAdminUser pojo) throws SQLException {
        String sql = "Update adminuser SET adname=?, ademail=?, adcontact=?, adpassword=?, adaddress=? WHERE adid = ?";
        int row = 0;
        conn = getConnection();
        PreparedStatement st;
        try {
            st = conn.prepareStatement(sql);
            st.setString(1, pojo.getAdname());
            st.setString(2, pojo.getAdemail());
            st.setString(3, pojo.getAdcontact());
            st.setString(4, pojo.getAdpassword());
            st.setString(5, pojo.getAdaddress());
            st.setInt(6, pojo.getAdid());
            row = st.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(DaoStore.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            conn.close();
        }
        return row;
    }

    public static List<PojoAdminUser> getadUser(String adtype) throws SQLException {
        String sql = "SELECT * FROM adminuser WHERE adtype = ?";
        List<PojoAdminUser> adUser = new ArrayList();
        PojoAdminUser pojo;

        conn = getConnection();
        PreparedStatement st;
        try {
            st = conn.prepareStatement(sql);
            st.setString(1, adtype);
            ResultSet row = st.executeQuery();
            while (row.next()) {
                pojo = new PojoAdminUser();
                pojo.setAdid(row.getInt("adid"));
                pojo.setAdname(row.getString("adname"));
                pojo.setAdemail(row.getString("ademail"));
                pojo.setAdcontact(row.getString("adcontact"));
                pojo.setAdpassword(row.getString("adaddress"));
                pojo.setAdaddress(row.getString("adpassword"));

                adUser.add(pojo);

            }
        } catch (SQLException ex) {
            Logger.getLogger(DaoStore.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            conn.close();
        }
        return adUser;
    }

    public static int deleteAdminById(int Adid) throws SQLException {
        String sql = "DELETE FROM adminuser WHERE adid = ?";

        int row = 0;
        conn = getConnection();
        PreparedStatement st;
        try {
            st = conn.prepareStatement(sql);
            st.setInt(1, Adid);

            row = st.executeUpdate();

        } catch (SQLException ex) {
            Logger.getLogger(DaoStore.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            conn.close();
        }
        return row;
    }
}
