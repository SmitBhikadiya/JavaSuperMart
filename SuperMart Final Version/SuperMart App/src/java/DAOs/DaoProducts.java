
package DAOs;

import POJOs.PojoProducts;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class DaoProducts {
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
    public static List<PojoProducts> getProducts() throws SQLException {
        String sql = "SELECT * FROM products ORDER BY RAND()";
        List<PojoProducts> stores = new ArrayList();
        PojoProducts pojo = null;

        conn = getConnection();
        PreparedStatement st;
        try {
            st = conn.prepareStatement(sql);
            ResultSet row = st.executeQuery();
            while (row.next()) {
                pojo = new PojoProducts();
                pojo.setPrdid(row.getInt("prdid"));
                pojo.setStrid(row.getInt("strid"));
                pojo.setImgpath(row.getString("imgpath"));
                pojo.setPrdname(row.getString("prdname"));
                pojo.setPrdprize(row.getInt("prdprize"));
                pojo.setPrdunit(row.getString("prdunit"));
                pojo.setPrddiscount(row.getInt("prddiscount"));
                pojo.setPrdtotalqty(row.getInt("prdtotalqty"));
                pojo.setPrdcategory(row.getString("prdcategory"));
                pojo.setPrddescription(row.getString("prddescription"));
                pojo.setPrdpurchasedbycstm(row.getInt("prdpurchasedbycstm"));
                pojo.setPrdupdatedtime(row.getString("prdupdatedtime"));
                stores.add(pojo); 
            }
        } catch (SQLException ex) {
            Logger.getLogger(DaoStore.class.getName()).log(Level.SEVERE, null, ex);
        } finally{
            conn.close();
        }
        return stores;
    }
    
    public static List<PojoProducts> getNewProducts(int limit) throws SQLException {
        String sql = "SELECT * FROM products ORDER BY prdid DESC LIMIT ?";
        List<PojoProducts> prd = new ArrayList();
        PojoProducts pojo = null;

        conn = getConnection();
        PreparedStatement st;
        try {
            st = conn.prepareStatement(sql);
            st.setInt(1, limit);
            ResultSet row = st.executeQuery();
            while (row.next()) {
                pojo = new PojoProducts();
                pojo.setPrdid(row.getInt("prdid"));
                pojo.setStrid(row.getInt("strid"));
                pojo.setImgpath(row.getString("imgpath"));
                pojo.setPrdname(row.getString("prdname"));
                pojo.setPrdprize(row.getInt("prdprize"));
                pojo.setPrdunit(row.getString("prdunit"));
                pojo.setPrddiscount(row.getInt("prddiscount"));
                pojo.setPrdtotalqty(row.getInt("prdtotalqty"));
                pojo.setPrdcategory(row.getString("prdcategory"));
                pojo.setPrddescription(row.getString("prddescription"));
                pojo.setPrdpurchasedbycstm(row.getInt("prdpurchasedbycstm"));
                pojo.setPrdupdatedtime(row.getString("prdupdatedtime"));
                prd.add(pojo); 
            }
        } catch (SQLException ex) {
            Logger.getLogger(DaoStore.class.getName()).log(Level.SEVERE, null, ex);
        } finally{
            conn.close();
        }
        return prd;
    }
  
    public static List<PojoProducts> getPopulerCategory(int limit) throws SQLException {
        String sql = "SELECT COUNT(*), prdid, category.ctid, prdcategory FROM products JOIN category ON category.category = products.prdcategory GROUP BY prdcategory ORDER BY COUNT(*) DESC LIMIT ?";
        List<PojoProducts> prd = new ArrayList();
        PojoProducts pojo = null;

        conn = getConnection();
        PreparedStatement st;
        try {
            st = conn.prepareStatement(sql);
            st.setInt(1, limit);
            ResultSet row = st.executeQuery();
            while (row.next()) {
                pojo = new PojoProducts();
                pojo.setCount(row.getInt(1));
                pojo.setPrdid(row.getInt(2));
                pojo.setCatid(row.getInt(3));
                pojo.setPrdcategory(row.getString(4));
                prd.add(pojo); 
            }
        } catch (SQLException ex) {
            Logger.getLogger(DaoStore.class.getName()).log(Level.SEVERE, null, ex);
        } finally{
            conn.close();
        }
        return prd;
    }
  
    
     public static List getHighestSelling(int limit) throws SQLException {
        String sql = "SELECT * FROM products ORDER BY prdpurchasedbycstm DESC LIMIT ?";
        List<PojoProducts> prd = new ArrayList();
        PojoProducts pojo = null;

        conn = getConnection();
        PreparedStatement st;
        try {
            st = conn.prepareStatement(sql);
            st.setInt(1, limit);
            ResultSet row = st.executeQuery();
            while (row.next()) {
                pojo = new PojoProducts();
                pojo.setPrdid(row.getInt("prdid"));
                pojo.setStrid(row.getInt("strid"));
                pojo.setImgpath(row.getString("imgpath"));
                pojo.setPrdname(row.getString("prdname"));
                pojo.setPrdprize(row.getInt("prdprize"));
                pojo.setPrdunit(row.getString("prdunit"));
                pojo.setPrddiscount(row.getInt("prddiscount"));
                pojo.setPrdtotalqty(row.getInt("prdtotalqty"));
                pojo.setPrdcategory(row.getString("prdcategory"));
                pojo.setPrddescription(row.getString("prddescription"));
                pojo.setPrdpurchasedbycstm(row.getInt("prdpurchasedbycstm"));
                pojo.setPrdupdatedtime(row.getString("prdupdatedtime"));
                prd.add(pojo); 
            }
        } catch (SQLException ex) {
            Logger.getLogger(DaoStore.class.getName()).log(Level.SEVERE, null, ex);
        } finally{
            conn.close();
        }
        return prd;
    }
  
    
    public static List<PojoProducts> getProductsByType(String type) throws SQLException {
        String sql = "SELECT * FROM products WHERE prdcategory = ?";
        List<PojoProducts> stores = new ArrayList();
        PojoProducts pojo = null;

        conn = getConnection();
        PreparedStatement st;
        try {
            st = conn.prepareStatement(sql);
            st.setString(1, type);
            ResultSet row = st.executeQuery();
            while (row.next()) {
                pojo = new PojoProducts();
                pojo.setPrdid(row.getInt("prdid"));
                pojo.setStrid(row.getInt("strid"));
                pojo.setImgpath(row.getString("imgpath"));
                pojo.setPrdname(row.getString("prdname"));
                pojo.setPrdprize(row.getInt("prdprize"));
                pojo.setPrdunit(row.getString("prdunit"));
                pojo.setPrddiscount(row.getInt("prddiscount"));
                pojo.setPrdtotalqty(row.getInt("prdtotalqty"));
                pojo.setPrdcategory(row.getString("prdcategory"));
                pojo.setPrddescription(row.getString("prddescription"));
                pojo.setPrdpurchasedbycstm(row.getInt("prdpurchasedbycstm"));
                pojo.setPrdupdatedtime(row.getString("prdupdatedtime"));
                stores.add(pojo); 
            }
        } catch (SQLException ex) {
            Logger.getLogger(DaoStore.class.getName()).log(Level.SEVERE, null, ex);
        } finally{
            conn.close();
        }
        return stores;
    }

    public static PojoProducts getProductsById(int prdid) throws SQLException {
        String sql = "SELECT * FROM products WHERE prdid = ?";
        PojoProducts pojo = null;
        System.out.println(prdid);
        conn = getConnection();
        PreparedStatement st;
        try {
            st = conn.prepareStatement(sql);
            st.setInt(1, prdid);
            ResultSet row = st.executeQuery();
            if (row.next()) {
                pojo = new PojoProducts();
                pojo.setPrdid(row.getInt("prdid"));
                pojo.setStrid(row.getInt("strid"));
                pojo.setImgpath(row.getString("imgpath"));
                pojo.setPrdname(row.getString("prdname"));
                pojo.setPrdprize(row.getInt("prdprize"));
                pojo.setPrdunit(row.getString("prdunit"));
                pojo.setPrddiscount(row.getInt("prddiscount"));
                pojo.setPrdtotalqty(row.getInt("prdtotalqty"));
                pojo.setPrdcategory(row.getString("prdcategory"));
                pojo.setPrddescription(row.getString("prddescription"));
                pojo.setPrdpurchasedbycstm(row.getInt("prdpurchasedbycstm"));
                pojo.setPrdupdatedtime(row.getString("prdupdatedtime"));
            }
        } catch (SQLException ex) {
            Logger.getLogger(DaoStore.class.getName()).log(Level.SEVERE, null, ex);
        } finally{
            conn.close();
        }
        return pojo;
    }
    
    public static  List<PojoProducts> getProductByStrid(int strid) throws SQLException {
        String sql = "SELECT * FROM products WHERE strid = ?";
        List<PojoProducts> products = new ArrayList();
        PojoProducts pojo = null;

        conn = getConnection();
        PreparedStatement st;
        try {
            st = conn.prepareStatement(sql);
            st.setInt(1, strid);
            ResultSet row = st.executeQuery();
            while (row.next()) {
                pojo = new PojoProducts();
                pojo.setPrdid(row.getInt("prdid"));
                pojo.setStrid(row.getInt("strid"));
                pojo.setImgpath(row.getString("imgpath"));
                pojo.setPrdname(row.getString("prdname"));
                pojo.setPrdprize(row.getInt("prdprize"));
                pojo.setPrdunit(row.getString("prdunit"));
                pojo.setPrddiscount(row.getInt("prddiscount"));
                pojo.setPrdtotalqty(row.getInt("prdtotalqty"));
                pojo.setPrdcategory(row.getString("prdcategory"));
                pojo.setPrddescription(row.getString("prddescription"));
                pojo.setPrdpurchasedbycstm(row.getInt("prdpurchasedbycstm"));
                pojo.setPrdupdatedtime(row.getString("prdupdatedtime"));
                products.add(pojo); 
            }
        } catch (SQLException ex) {
            Logger.getLogger(DaoStore.class.getName()).log(Level.SEVERE, null, ex);
        } finally{
            conn.close();
        }
        return products;
    }

    public static PojoProducts getProductsByName(int strid, String prdname) throws SQLException {
        String sql = "SELECT * FROM products WHERE strid = ? AND prdname = ?";
        PojoProducts pojo = null;

        conn = getConnection();
        PreparedStatement st;
        try {
            st = conn.prepareStatement(sql);
            st.setInt(1, strid);
            st.setString(2, prdname);
            ResultSet row = st.executeQuery();
            if (row.next()) {
                pojo = new PojoProducts();
                pojo.setPrdid(row.getInt("prdid"));
                pojo.setStrid(row.getInt("strid"));
                pojo.setImgpath(row.getString("imgpath"));
                pojo.setPrdname(row.getString("prdname"));
                pojo.setPrdprize(row.getInt("prdprize"));
                pojo.setPrdunit(row.getString("prdunit"));
                pojo.setPrddiscount(row.getInt("prddiscount"));
                pojo.setPrdtotalqty(row.getInt("prdtotalqty"));
                pojo.setPrdcategory(row.getString("prdcategory"));
                pojo.setPrddescription(row.getString("prddescription"));
                pojo.setPrdpurchasedbycstm(row.getInt("prdpurchasedbycstm"));
                pojo.setPrdupdatedtime(row.getString("prdupdatedtime"));
            }
        } catch (SQLException ex) {
            Logger.getLogger(DaoStore.class.getName()).log(Level.SEVERE, null, ex);
        } finally{
            conn.close();
        }
        return pojo;
    }
    
    public static PojoProducts getProductsByName(int strid, String prdname, int prdprize, String prdunit) throws SQLException {
        String sql = "SELECT * FROM products WHERE strid = ? AND prdname = ? AND prdprize = ? AND prdunit = ?";
        PojoProducts pojo = null;

        conn = getConnection();
        PreparedStatement st;
        try {
            st = conn.prepareStatement(sql);
            st.setInt(1, strid);
            st.setString(2, prdname);
            st.setInt(3, prdprize);
            st.setString(4, prdunit);
            ResultSet row = st.executeQuery();
            if (row.next()) {
                pojo = new PojoProducts();
                pojo.setPrdid(row.getInt("prdid"));
                pojo.setStrid(row.getInt("strid"));
                pojo.setImgpath(row.getString("imgpath"));
                pojo.setPrdname(row.getString("prdname"));
                pojo.setPrdprize(row.getInt("prdprize"));
                pojo.setPrdunit(row.getString("prdunit"));
                pojo.setPrddiscount(row.getInt("prddiscount"));
                pojo.setPrdtotalqty(row.getInt("prdtotalqty"));
                pojo.setPrdcategory(row.getString("prdcategory"));
                pojo.setPrddescription(row.getString("prddescription"));
                pojo.setPrdpurchasedbycstm(row.getInt("prdpurchasedbycstm"));
                pojo.setPrdupdatedtime(row.getString("prdupdatedtime"));
            }
        } catch (SQLException ex) {
            Logger.getLogger(DaoStore.class.getName()).log(Level.SEVERE, null, ex);
        } finally{
            conn.close();
        }
        return pojo;
    }

    public static int insertProduct(PojoProducts pojo) throws SQLException {
        String sql = "INSERT INTO products (strid, imgpath, prdname, prdprize, prdunit, prddiscount, prdtotalqty, prdcategory, prddescription) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
       
        int row = 0;
        conn = getConnection();
        PreparedStatement st;
        try {
            st = conn.prepareStatement(sql);
            st.setInt(1, pojo.getStrid());
            st.setString(2, pojo.getImgpath());
            st.setString(3, pojo.getPrdname());
            st.setInt(4, pojo.getPrdprize());
            st.setString(5, pojo.getPrdunit());
            st.setInt(6, pojo.getPrddiscount());
            st.setInt(7, pojo.getPrdtotalqty());
            st.setString(8, pojo.getPrdcategory());
            st.setString(9, pojo.getPrddescription());
            row = st.executeUpdate();
            
        } catch (SQLException ex) {
            Logger.getLogger(DaoStore.class.getName()).log(Level.SEVERE, null, ex);
        } finally{
            conn.close();
        }
        return row;
    }

    public static int updateProduct(PojoProducts pojo) throws SQLException {
       String sql = "UPDATE products SET strid=?, imgpath=?, prdname=?, prdprize=?, prdunit=?, prddiscount=?, prdtotalqty=?, prdcategory=?, prddescription=? WHERE prdid = ?";
       
        int row = 0;
        conn = getConnection();
        PreparedStatement st;
        try {
            st = conn.prepareStatement(sql);
            st.setInt(1, pojo.getStrid());
            st.setString(2, pojo.getImgpath());
            st.setString(3, pojo.getPrdname());
            st.setInt(4, pojo.getPrdprize());
            st.setString(5, pojo.getPrdunit());
            st.setInt(6, pojo.getPrddiscount());
            st.setInt(7, pojo.getPrdtotalqty());
            st.setString(8, pojo.getPrdcategory());
            st.setString(9, pojo.getPrddescription());
            st.setInt(10, pojo.getPrdid());
            row = st.executeUpdate();
            
        } catch (SQLException ex) {
            Logger.getLogger(DaoStore.class.getName()).log(Level.SEVERE, null, ex);
        } finally{
            conn.close();
        }
        return row;
    }
    
    public static int deleteProductById(int prdid) throws SQLException {
       String sql = "DELETE FROM products WHERE prdid = ?";
       
        int row = 0;
        conn = getConnection();
        PreparedStatement st;
        try {
            st = conn.prepareStatement(sql);
            st.setInt(1, prdid);
            
            row = st.executeUpdate();
            
        } catch (SQLException ex) {
            Logger.getLogger(DaoStore.class.getName()).log(Level.SEVERE, null, ex);
        } finally{
            conn.close();
        }
        return row;
    }
    
    public static List<PojoProducts> getProductsByName(String prdname) throws SQLException {
        String sql = "SELECT * FROM products WHERE prdname = ?";
        List<PojoProducts> products = new ArrayList();
        PojoProducts pojo = null;

        conn = getConnection();
        PreparedStatement st;
        try {
            st = conn.prepareStatement(sql);
            st.setString(1, prdname);
            ResultSet row = st.executeQuery();
            while (row.next()) {
                pojo = new PojoProducts();
                pojo.setPrdid(row.getInt("prdid"));
                pojo.setStrid(row.getInt("strid"));
                pojo.setImgpath(row.getString("imgpath"));
                pojo.setPrdname(row.getString("prdname"));
                pojo.setPrdprize(row.getInt("prdprize"));
                pojo.setPrdunit(row.getString("prdunit"));
                pojo.setPrddiscount(row.getInt("prddiscount"));
                pojo.setPrdtotalqty(row.getInt("prdtotalqty"));
                pojo.setPrdcategory(row.getString("prdcategory"));
                pojo.setPrddescription(row.getString("prddescription"));
                pojo.setPrdpurchasedbycstm(row.getInt("prdpurchasedbycstm"));
                pojo.setPrdupdatedtime(row.getString("prdupdatedtime"));
                products.add(pojo);
            }
        } catch (SQLException ex) {
            Logger.getLogger(DaoStore.class.getName()).log(Level.SEVERE, null, ex);
        } finally{
            conn.close();
        }
        return products;
    }

    public static int updateStock(int prdid, int prdqty, String type) throws SQLException {
        String sign;
        if(type.equals("dec") || type=="des"){
            sign = "-";
        } else{
            sign = "+";
        }
        String sql = "UPDATE products SET prdtotalqty=prdtotalqty"+sign+"? WHERE prdid = ?";
        //System.out.println(sql + " " + prdqty);
        int row = 0;
        conn = getConnection();
        PreparedStatement st;
        try {
            st = conn.prepareStatement(sql);
            st.setInt(1, prdqty);
            st.setInt(2, prdid);
            row = st.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(DaoStore.class.getName()).log(Level.SEVERE, null, ex);
        } finally{
            conn.close();
        }
        return row;
    }

    public static int updatePurchased(int prdid) throws SQLException {
 
        String sql = "UPDATE products SET prdpurchasedbycstm=prdpurchasedbycstm+1 WHERE prdid = ?";
        //System.out.println(sql + " " + prdqty);
        int row = 0;
        conn = getConnection();
        PreparedStatement st;
        try {
            st = conn.prepareStatement(sql);
            st.setInt(1, prdid);
            row = st.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(DaoStore.class.getName()).log(Level.SEVERE, null, ex);
        } finally{
            conn.close();
        }
        return row;
    }
    
    

    
    public static int deleteProductByStoreId(int strid) throws SQLException {
       String sql = "DELETE FROM products WHERE strid = ?";
       
        int row = 0;
        conn = getConnection();
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
    
    public static int getTotalProductBystrid(int strid) throws SQLException {
       String sql = "SELECT COUNT(*) FROM products WHERE strid=?";
       
        int row = 0;
        conn = getConnection();
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
    
}
