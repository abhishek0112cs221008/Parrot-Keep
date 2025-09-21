<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.NoteDAO, model.Note, java.util.List" %>
<%
    if(session == null || session.getAttribute("username") == null){
        response.sendRedirect("login.jsp");
        return;
    }

    String username = (String) session.getAttribute("username");
    String idStr = request.getParameter("id");
    Note note = null;
    boolean isEdit = false;

    if(idStr != null && !idStr.isEmpty()) {
        int id = Integer.parseInt(idStr);
        // Fetch note from DB
        List<Note> notes = NoteDAO.getNotesByUser(username);
        for(Note n: notes){
            if(n.getId() == id){
                note = n;
                isEdit = true;
                break;
            }
        }
        if(note == null){
            response.sendRedirect("home.jsp");
            return;
        }
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title><%= isEdit ? "Edit Note" : "New Note" %> - Parrot Keep</title>
<link href="https://fonts.googleapis.com/css2?family=Architects+Daughter&family=Roboto+Slab:wght@400;700&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
<link rel="icon" href="https://img.icons8.com/material-outlined/24/000000/note.png" type="image/png">

<style>
    :root {
        --primary-color: #4CAF50;
        --primary-dark: #2E7D32;
        --accent-color: #E53935;
        --text-primary: #f0f0f0;
        --text-secondary: #b0b0b0;
        --background-dark: #121212;
        --card-background: #1e1e1e;
        --card-border: #333333;
        --shadow-dark: 0 4px 12px rgba(0,0,0,0.3);
        --border-radius: 12px;
    }

    body {
        margin: 0;
        font-family: 'Roboto Slab', serif;
        background-color: var(--background-dark);
        background-image: none; /* Removed grid for a cleaner look */
        color: var(--text-primary);
        display: flex;
        align-items: center;
        justify-content: center;
        min-height: 100vh;
        padding: 40px;
    }

    .sketchbook-container {
        width: 800px;
        max-width: 100%;
        background-color: var(--card-background);
        padding: 50px 70px;
        box-shadow: 10px 10px 30px rgba(0, 0, 0, 0.5);
        border-radius: var(--border-radius);
        border: 2px solid var(--card-border);
        position: relative;
        animation: flyIn 0.8s ease-in-out;
    }

    @keyframes flyIn {
        from { transform: scale(0.8) rotate(-2deg); opacity: 0; }
        to { transform: scale(1) rotate(0); opacity: 1; }
    }

    .sketchbook-container::before {
        content: '';
        position: absolute;
        top: 0;
        left: 20px;
        height: 100%;
        width: 5px;
        background-color: var(--primary-color);
        transform: skewY(-4deg);
    }
    .sketchbook-container::after {
        content: '';
        position: absolute;
        top: 0;
        left: 28px;
        height: 100%;
        width: 2px;
        background-color: var(--primary-color);
        transform: skewY(-4deg);
    }

    h2 {
        font-family: 'Architects Daughter', cursive;
        font-size: 2.5rem;
        text-align: center;
        color: var(--primary-color);
        margin-bottom: 30px;
        position: relative;
    }

    h2::after {
        content: '';
        display: block;
        width: 100px;
        height: 3px;
        background-color: var(--primary-color);
        margin: 10px auto 0;
        transform: rotate(-1deg);
    }

    input[type="text"], textarea {
        width: 100%;
        padding: 15px;
        border: none;
        background: transparent;
        border-bottom: 2px solid var(--text-secondary);
        font-family: 'Architects Daughter', cursive;
        font-size: 1.2rem;
        color: var(--text-primary);
        transition: border-bottom 0.2s ease, transform 0.2s ease;
        line-height: 1.5;
        outline: none;
        box-shadow: none;
    }

    input[type="text"]:focus, textarea:focus {
        border-bottom: 2px solid var(--primary-color);
        transform: scale(1.01);
    }

    input[type="text"] {
        margin-bottom: 30px;
    }

    textarea {
        min-height: 350px;
        resize: none;
        margin-bottom: 30px;
    }

    .checkbox-container {
        display: flex;
        align-items: center;
        justify-content: center;
        margin-bottom: 40px;
    }

    .checkbox-container input[type="checkbox"] {
        margin-right: 10px;
        transform: scale(1.5);
    }

    .checkbox-container label {
        font-family: 'Roboto Slab', serif;
        font-size: 1rem;
        color: var(--text-secondary);
        cursor: pointer;
    }

    .button-container {
        display: flex;
        justify-content: center;
        gap: 20px;
    }

    .button-container button {
        padding: 15px 30px;
        border: 2px solid var(--primary-color);
        border-radius: 5px;
        background-color: transparent;
        font-family: 'Roboto Slab', serif;
        font-size: 1rem;
        font-weight: 700;
        cursor: pointer;
        transition: transform 0.2s ease, background-color 0.2s ease, box-shadow 0.2s ease;
        position: relative;
    }

    .button-container button:hover {
        transform: translateY(-5px);
        box-shadow: 5px 5px 0 var(--primary-dark);
    }

    .button-primary {
        background-color: var(--primary-color);
        color: #fff;
        border: none;
    }

    .button-primary:hover {
        transform: translateY(-5px);
        box-shadow: 5px 5px 0 var(--primary-dark);
    }

    .button-secondary {
        background-color: transparent;
        color: var(--text-primary);
        border: 2px solid var(--text-primary);
    }

    .button-secondary:hover {
        transform: translateY(-5px);
        box-shadow: 5px 5px 0 var(--text-secondary);
    }
    
    /* Responsive Styles */
    @media (max-width: 768px) {
        body {
            padding: 20px 10px;
        }
        .sketchbook-container {
            padding: 30px 20px;
            box-shadow: 5px 5px 15px rgba(0, 0, 0, 0.2);
        }
        .sketchbook-container::before, .sketchbook-container::after {
            left: 10px;
        }
        h2 {
            font-size: 2rem;
        }
        input[type="text"], textarea {
            font-size: 1rem;
        }
        .button-container {
            flex-direction: column;
            gap: 10px;
        }
    }
</style>
   
</head>
<body>

<div class="sketchbook-container">
    <h2><%= isEdit ? "Edit Entry" : "New Note" %></h2>

    <form action="<%= isEdit ? "UpdateNoteServlet" : "AddNoteServlet" %>" method="post">
        <% if(isEdit){ %>
            <input type="hidden" name="id" value="<%= note.getId() %>">
        <% } %>
        
        <input type="text" name="title" placeholder="Title" value="<%= isEdit ? note.getTitle() : "" %>" required>
        <textarea name="content" placeholder="Write your note..." required><%= isEdit ? note.getContent() : "" %></textarea>

        <div class="checkbox-container">
            <input type="checkbox" id="isPublic" name="isPublic" <%= (isEdit && note.getIsPublic()) ? "checked" : "" %>>
            <label for="isPublic">Make this note public</label>
        </div>
        
        <div class="button-container">
            <button type="submit" class="button-primary">
                <%= isEdit ? "Update" : "Save" %>
            </button>
            <a href="home.jsp" style="text-decoration: none;">
                <button type="button" class="button-secondary">Cancel</button>
            </a>
        </div>
    </form>
</div>

</body>
</html>