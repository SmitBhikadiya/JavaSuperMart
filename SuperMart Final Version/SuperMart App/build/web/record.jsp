<%@page import="POJOs.PojoStore"%>
<%@page import="DAOs.DaoStore"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    if (request.getParameter("key") != null) {
        String key = request.getParameter("key");
        String wild = "%" + key + "%";

        Connection conn = null;

        try {
            Class.forName("com.mysql.jdbc.Driver");
            conn = (Connection) DriverManager.getConnection("jdbc:mysql://localhost:3306/supermartjava?user=root");
            PreparedStatement store = null;
            PreparedStatement item = null;
            PreparedStatement category = null;
            
            store = conn.prepareStatement("SELECT * FROM stores JOIN varifystore ON varifystore.strid=stores.strid WHERE strname LIKE ? AND varified=1");
            store.setString(1, wild);
            ResultSet rows = store.executeQuery();
            
            item = conn.prepareStatement("SELECT * FROM products JOIN varifystore ON varifystore.strid=products.strid WHERE prdname LIKE ? AND varified=1");
            item.setString(1, wild);
            ResultSet rows1 = item.executeQuery();
            
            category = conn.prepareStatement("SELECT * FROM category WHERE category LIKE ?");
            category.setString(1, wild);
            ResultSet rows2 = category.executeQuery();

            while (rows.next()) { %>
                <a href='shop-grid-full-4-col.jsp?cid=<%=rows.getInt("strid")%>'><%=rows.getString("strname")%></a>
            <% }
            while (rows1.next()) {
                int strid = rows1.getInt("strid");
                PojoStore pojo1 = DaoStore.getStoreById(strid);
            %>
                <a href='single-product.jsp?prdid=<%=rows1.getInt("prdid")%>&prdname=<%=rows1.getString("prdname")%>' title="<%=pojo1.getStrname()%>"><%=rows1.getString("prdname")%><br><%= pojo1.getStrname()%></a>
            <% }
            while(rows2.next()){ %>
                <a href='single-product.jsp?ctid=<%=rows2.getInt("ctid")%>&category=<%=rows2.getString("category")%>'><%=rows2.getString("category")%></a>
            <% }
        } catch (Exception e) {
                e.printStackTrace();
        } finally{
            conn.close();
        }
    }
%>