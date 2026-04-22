<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
    // Process form when submitted
    if ("POST".equalsIgnoreCase(request.getMethod())) {
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        
        // Check for null to avoid errors
        if (name != null && email != null && !name.trim().isEmpty() && !email.trim().isEmpty()) {
            Connection con = null;
            PreparedStatement ps = null;
            
            try {
                Class.forName("org.sqlite.JDBC");
                String url = "jdbc:sqlite:D:/Model-lab/vscode-jsp-crud/studentdb.db";
                con = DriverManager.getConnection(url);
                
                String query = "INSERT INTO students (name, email) VALUES (?, ?)";
                ps = con.prepareStatement(query);
                ps.setString(1, name);
                ps.setString(2, email);
                ps.executeUpdate();
                
                response.sendRedirect("index.jsp");
                return; // Stop further execution after redirect
            } catch(Exception e) {
                out.println("<p style='color:red;'>Error: " + e.getMessage() + "</p>");
            } finally {
                if(ps != null) try { ps.close(); } catch(SQLException e) {}
                if(con != null) try { con.close(); } catch(SQLException e) {}
            }
        } else {
            out.println("<p style='color:red;'>Fields cannot be empty.</p>");
        }
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Add Student</title>
</head>
<body>
    <h2>Add Student</h2>
    <form action="add.jsp" method="POST">
        <label>Name:</label>
        <input type="text" name="name" required><br><br>
        
        <label>Email:</label>
        <input type="email" name="email" required><br><br>
        
        <input type="submit" value="Add Student">
    </form>
    <br>
    <a href="index.jsp">Back to List</a>
</body>
</html>
