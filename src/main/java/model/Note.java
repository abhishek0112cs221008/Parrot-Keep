package model;

import java.sql.Timestamp;

public class Note {
    private int id;
    private String username;
    private String title;
    private String content;
    private Timestamp created_at; 
    private boolean isPublic;
    private String publicId;

    // Default constructor
    public Note() {}

    // Constructor for adding a new note
    public Note(String username, String title, String content, boolean isPublic, String publicId) {
        this.username = username;
        this.title = title;
        this.content = content;
        this.isPublic = isPublic;
        this.publicId = publicId;
    }

    // Getters and setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getUsername() { return username; }
    public void setUsername(String username) { this.username = username; }

    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }

    public String getContent() { return content; }
    public void setContent(String content) { this.content = content; }

    public Timestamp getCreated_at() { return created_at; }
    public void setCreated_at(Timestamp created_at) { this.created_at = created_at; }

    public boolean getIsPublic() { return isPublic; }
    public void setIsPublic(boolean isPublic) { this.isPublic = isPublic; }

    public String getPublicId() { return publicId; }
    public void setPublicId(String publicId) { this.publicId = publicId; }
}
