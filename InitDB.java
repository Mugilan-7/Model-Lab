import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.Statement;

public class InitDB {
    public static void main(String[] args) {
        String url = "jdbc:sqlite:D:/Model-lab/vscode-jsp-crud/studentdb.db";

        try {
            Class.forName("org.sqlite.JDBC");
            try (Connection con = DriverManager.getConnection(url);
                 Statement stmt = con.createStatement()) {

                // Create table
                String createTable = "CREATE TABLE IF NOT EXISTS students (" +
                        "id INTEGER PRIMARY KEY AUTOINCREMENT, " +
                        "name VARCHAR(50) NOT NULL, " +
                        "email VARCHAR(50) NOT NULL" +
                        ")";
                stmt.executeUpdate(createTable);
                System.out.println("Table 'students' created or already exists.");

                // Insert sample data if empty
                var rs = stmt.executeQuery("SELECT COUNT(*) FROM students");
                if (rs.next() && rs.getInt(1) == 0) {
                    String insertData = "INSERT INTO students (name, email) VALUES " +
                            "('Alice Smith', 'alice@example.com'), " +
                            "('Bob Johnson', 'bob@example.com'), " +
                            "('Charlie Brown', 'charlie@example.com')";
                    stmt.executeUpdate(insertData);
                    System.out.println("Sample data inserted.");
                } else {
                    System.out.println("Data already exists in table.");
                }
            }
        } catch (Exception e) {
            System.err.println("Error setting up database: " + e.getMessage());
            e.printStackTrace();
        }
    }
}
