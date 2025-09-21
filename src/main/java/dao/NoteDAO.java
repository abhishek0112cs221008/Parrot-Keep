package dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import model.Note;

public class NoteDAO {

    public static boolean addNote(Note note) {
        boolean result = false;

        // If note is public and publicId is null, generate one
        if(note.getIsPublic() && (note.getPublicId() == null || note.getPublicId().isEmpty())) {
            note.setPublicId(java.util.UUID.randomUUID().toString());
        }

        String sql = "INSERT INTO notes (username, title, content, is_public, public_id) VALUES (?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, note.getUsername());
            ps.setString(2, note.getTitle());
            ps.setString(3, note.getContent());
            ps.setBoolean(4, note.getIsPublic());
            ps.setString(5, note.getPublicId());

            int rows = ps.executeUpdate();
            result = rows > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }

    public static List<Note> getNotesByUser(String username) {
        List<Note> list = new ArrayList<>();
        String sql = "SELECT * FROM notes WHERE username=? ORDER BY created_at DESC";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, username);
            ResultSet rs = ps.executeQuery();

            while(rs.next()) {
                Note note = new Note();
                note.setId(rs.getInt("id"));
                note.setUsername(rs.getString("username"));
                note.setTitle(rs.getString("title"));
                note.setContent(rs.getString("content"));
                note.setCreated_at(rs.getTimestamp("created_at"));
                note.setIsPublic(rs.getBoolean("is_public"));
                note.setPublicId(rs.getString("public_id"));
                list.add(note);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public static boolean updateNote(Note note) {
        boolean flag = false;
        String sql = "UPDATE notes SET title=?, content=?, is_public=?, public_id=? WHERE id=? AND username=?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            // Generate publicId if public
            if(note.getIsPublic() && (note.getPublicId() == null || note.getPublicId().isEmpty())) {
                note.setPublicId(java.util.UUID.randomUUID().toString());
            }

            ps.setString(1, note.getTitle());
            ps.setString(2, note.getContent());
            ps.setBoolean(3, note.getIsPublic());
            ps.setString(4, note.getPublicId());
            ps.setInt(5, note.getId());
            ps.setString(6, note.getUsername());

            flag = ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }
        return flag;
    }

    public static Note getNoteByPublicId(String publicId) {
        Note note = null;
        String sql = "SELECT * FROM notes WHERE public_id=? AND is_public=1";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, publicId);
            ResultSet rs = ps.executeQuery();

            if(rs.next()) {
                note = new Note();
                note.setId(rs.getInt("id"));
                note.setUsername(rs.getString("username"));
                note.setTitle(rs.getString("title"));
                note.setContent(rs.getString("content"));
                note.setCreated_at(rs.getTimestamp("created_at"));
                note.setIsPublic(rs.getBoolean("is_public"));
                note.setPublicId(rs.getString("public_id"));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return note;
    }

    public static boolean deleteNote(int id, String username) {
        boolean flag = false;
        String sql = "DELETE FROM notes WHERE id=? AND username=?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, id);
            ps.setString(2, username);
            flag = ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }
        return flag;
    }
}
