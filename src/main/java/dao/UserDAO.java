package dao;

import java.sql.*;

public class UserDAO {

    // validate login
    public boolean validateUser(String username, String password) {
        boolean isValid = false;
        String sql = "SELECT * FROM users WHERE username=? AND password=?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, username);
            ps.setString(2, password);

            ResultSet rs = ps.executeQuery();
            isValid = rs.next();

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return isValid;
    }

    // register new user
    public boolean registerUser(String username, String password, String email) {
        boolean isRegistered = false;
        String sql = "INSERT INTO users (username, password, email) VALUES (?, ?, ?)";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, username);
            ps.setString(2, password);
            ps.setString(3, email);

            int rows = ps.executeUpdate();
            isRegistered = rows > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return isRegistered;
    }
    
    public boolean isUserExists(String username, String email) {
        String sql = "SELECT COUNT(*) FROM users WHERE username = ? OR email = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, username);
            stmt.setString(2, email);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) > 0;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
}
