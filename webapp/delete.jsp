<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
    String id = request.getParameter("id");
    
    // Only delete if ID is provided and not empty
    if (id != null && !id.trim().isEmpty()) {
        Connection con = null;
        PreparedStatement ps = null;
        
        try {
            Class.forName("org.sqlite.JDBC");
            String url = "jdbc:sqlite:D:/Model-lab/vscode-jsp-crud/studentdb.db";
            con = DriverManager.getConnection(url);
            
            String query = "DELETE FROM students WHERE id=?";
            ps = con.prepareStatement(query);
            ps.setInt(1, Integer.parseInt(id));
            ps.executeUpdate();
            
        } catch(Exception e) {
            // Log error
            System.out.println("Error deleting record: " + e.getMessage());
        } finally {
            if(ps != null) try { ps.close(); } catch(SQLException e) {}
            if(con != null) try { con.close(); } catch(SQLException e) {}
        }
    }
    
    // Redirect back to index.jsp after delete
    response.sendRedirect("index.jsp");
%>
