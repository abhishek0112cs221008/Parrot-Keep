<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.NoteDAO, model.Note, java.util.List, java.sql.*" %>
<%
    if(session == null || session.getAttribute("username") == null){
        response.sendRedirect("login.jsp");
        return;
    }

    String username = (String) session.getAttribute("username");
    String idStr = request.getParameter("id");
    if(idStr == null) {
        response.sendRedirect("home.jsp");
        return;
    }
    int id = Integer.parseInt(idStr);

    // Fetch note from DB
    Note note = null;
    List<Note> notes = NoteDAO.getNotesByUser(username);
    for(Note n: notes){
        if(n.getId() == id){
            note = n;
            break;
        }
    }
    if(note == null){
        response.sendRedirect("home.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Edit Note - My Keep</title>
<style>
    body { margin:0; font-family: Arial; background:linear-gradient(135deg, #9fd4a3, #d4f1be); display:flex; justify-content:center; align-items:center; min-height:100vh; }
    .edit-container { background:#fff; padding:30px; border-radius:12px; width:400px; box-shadow:0 4px 12px rgba(0,0,0,0.2); }
    .edit-container h2 { color:#d32f2f; margin-bottom:20px; text-align:center; }
    input, textarea { width:100%; padding:10px; margin-bottom:10px; border-radius:6px; border:1px solid #ccc; }
    button { width:100%; padding:12px; background:#d32f2f; color:#fff; border:none; border-radius:6px; font-size:16px; cursor:pointer; }
    button:hover { background:#b71c1c; }
    .btn-back { background:#777; margin-bottom:10px; }
    .btn-back:hover { background:#555; }
</style>
</head>
<body>
<div class="edit-container">
    <h2>Edit Note</h2>
    <form action="UpdateNoteServlet" method="post">
        <input type="hidden" name="id" value="<%= note.getId() %>">
        <input type="text" name="title" value="<%= note.getTitle() %>" required>
        <textarea name="content" rows="6" required><%= note.getContent() %></textarea>
        <button type="submit">Update Note</button>
    </form>
    <form action="home.jsp" method="get">
        <button type="submit" class="btn-back">Back to Home</button>
    </form>
</div>
</body>
</html>
