<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
    String id = request.getParameter("id");
    if (id == null || id.trim().isEmpty()) {
        response.sendRedirect("index.jsp");
        return;
    }
    
    // Process form update on POST
    if ("POST".equalsIgnoreCase(request.getMethod())) {
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        
        if (name != null && email != null) {
            Connection con = null;
            PreparedStatement ps = null;
            
            try {
                Class.forName("org.sqlite.JDBC");
                String url = "jdbc:sqlite:D:/Model-lab/vscode-jsp-crud/studentdb.db";
                con = DriverManager.getConnection(url);
                
                String query = "UPDATE students SET name=?, email=? WHERE id=?";
                ps = con.prepareStatement(query);
                ps.setString(1, name);
                ps.setString(2, email);
                ps.setInt(3, Integer.parseInt(id));
                ps.executeUpdate();
                
                response.sendRedirect("index.jsp");
                return;
            } catch(Exception e) {
                out.println("<p style='color:red;'>Error: " + e.getMessage() + "</p>");
            } finally {
                if(ps != null) try { ps.close(); } catch(SQLException e) {}
                if(con != null) try { con.close(); } catch(SQLException e) {}
            }
        }
    }
    
    // Fetch existing record for GET request
    String existingName = "";
    String existingEmail = "";
    Connection conSelect = null;
    PreparedStatement psSelect = null;
    ResultSet rsSelect = null;
    
    try {
        Class.forName("org.sqlite.JDBC");
        String url = "jdbc:sqlite:D:/Model-lab/vscode-jsp-crud/studentdb.db";
        conSelect = DriverManager.getConnection(url);
        
        String query = "SELECT * FROM students WHERE id=?";
        psSelect = conSelect.prepareStatement(query);
        psSelect.setInt(1, Integer.parseInt(id));
        rsSelect = psSelect.executeQuery();
        
        if (rsSelect.next()) {
            existingName = rsSelect.getString("name");
            existingEmail = rsSelect.getString("email");
        } else {
            response.sendRedirect("index.jsp"); // ID not found
            return;
        }
    } catch(Exception e) {
        out.println("Error: " + e.getMessage());
    } finally {
        if(rsSelect != null) try { rsSelect.close(); } catch(SQLException e) {}
        if(psSelect != null) try { psSelect.close(); } catch(SQLException e) {}
        if(conSelect != null) try { conSelect.close(); } catch(SQLException e) {}
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Edit Student</title>
</head>
<body>
    <h2>Edit Student</h2>
    <form action="edit.jsp?id=<%= id %>" method="POST">
        <label>Name:</label>
        <input type="text" name="name" value="<%= existingName %>" required><br><br>
        
        <label>Email:</label>
        <input type="email" name="email" value="<%= existingEmail %>" required><br><br>
        
        <input type="submit" value="Update Student">
    </form>
    <br>
    <a href="index.jsp">Back to List</a>
</body>
</html>
