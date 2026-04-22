<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Student Management System</title>
</head>
<body>
    <h2>Student Management System</h2>
    <a href="add.jsp">Add New Student</a><br><br>
    
    <table border="1" width="60%" cellpadding="5">
        <tr>
            <th>ID</th>
            <th>Name</th>
            <th>Email</th>
            <th>Action</th>
        </tr>
        <%
            Connection con = null;
            PreparedStatement ps = null;
            ResultSet rs = null;
            
            try {
                Class.forName("org.sqlite.JDBC");
                String url = "jdbc:sqlite:D:/Model-lab/vscode-jsp-crud/studentdb.db";
                con = DriverManager.getConnection(url);
                
                String query = "SELECT * FROM students";
                ps = con.prepareStatement(query);
                rs = ps.executeQuery();
                
                while(rs.next()) {
        %>
        <tr>
            <td><%= rs.getInt("id") %></td>
            <td><%= rs.getString("name") %></td>
            <td><%= rs.getString("email") %></td>
            <td>
                <a href="edit.jsp?id=<%= rs.getInt("id") %>">Edit</a> | 
                <a href="delete.jsp?id=<%= rs.getInt("id") %>" onclick="return confirm('Are you sure you want to delete this record?')">Delete</a>
            </td>
        </tr>
        <%
                }
            } catch(Exception e) {
                out.println("<tr><td colspan='4'>Error: " + e.getMessage() + "</td></tr>");
            } finally {
                // Always close connections in finally block
                if(rs != null) try { rs.close(); } catch(SQLException e) {}
                if(ps != null) try { ps.close(); } catch(SQLException e) {}
                if(con != null) try { con.close(); } catch(SQLException e) {}
            }
        %>
    </table>
</body>
</html>
