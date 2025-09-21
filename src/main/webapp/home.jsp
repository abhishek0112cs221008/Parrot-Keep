<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Parrot Keep</title>

<!-- Fonts & Icons -->
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700&display=swap" rel="stylesheet">
<link rel="icon" href="https://img.icons8.com/ios-filled/50/ffffff/feather.png" type="image/png">

<style>
/* Global Variables and Box Sizing */
:root {
  --primary-color: #4CAF50;
  --primary-dark: #2E7D32;
  --accent-color: #E53935;
  --text-primary: #f0f0f0; /* Light text for dark background */
  --text-secondary: #b0b0b0; /* Lighter gray for secondary text */
  --background-dark: #121212;
  --card-background: #1e1e1e;
  --card-border: #333333;
  --shadow-dark: 0 4px 12px rgba(0,0,0,0.3);
  --border-radius: 12px;
}

* { margin:0; padding:0; box-sizing:border-box; }
body {
  font-family:'Poppins',sans-serif;
  background-color: var(--background-dark);
  color: var(--text-primary);
  min-height:100vh;
  display:flex;
  flex-direction:column;
  line-height:1.6;
}

/* Header */
header {
  background: var(--card-background);
  padding:1rem 2rem;
  box-shadow: 0 2px 8px rgba(0,0,0,0.3);
  position:sticky; top:0; z-index:100;
}
.header-content {
  max-width:1200px; margin:0 auto;
  display:flex; justify-content:space-between; align-items:center;
}
.logo { 
  font-size:1.75rem; font-weight:700; 
  color: var(--primary-color); 
  display:flex; align-items:center; gap:0.6rem; 
  transition: transform 0.2s ease-in-out;
}
.logo:hover {
  transform: translateY(-2px);
}
.logo i { font-size:1.8rem; color: var(--primary-color); }
.user-controls { display:flex; align-items:center; gap:1.2rem; }
.welcome-message { font-size:0.95rem; color: var(--text-secondary); }

/* Main Content Area */
main {
  max-width:1200px;
  margin:2rem auto;
  padding:0 1rem;
  flex:1;
  width:100%;
}
.notes-container {
  display:grid;
  grid-template-columns:repeat(auto-fill,minmax(280px,1fr));
  gap:1.5rem;
}

/* Note Card Styles */
.note-card {
  background:var(--card-background);
  border-radius:var(--border-radius);
  padding:1.5rem;
  box-shadow:var(--shadow-dark);
  transition:all 0.25s ease;
  cursor:pointer;
  display:flex;
  flex-direction:column;
  color:var(--text-primary);
  border:1px solid var(--card-border);
}
.note-card:hover { 
  transform:translateY(-4px); 
  box-shadow: 0 8px 20px rgba(0,0,0,0.4); 
}

/* Add Note Button */
.add-note {
  border:2px dashed var(--primary-color);
  text-align:center;
  display:flex; flex-direction:column; justify-content:center; align-items:center;
  gap:0.6rem;
  color:var(--primary-color);
  padding:2rem 1rem;
  border-radius: var(--border-radius);
  transition: 0.3s;
}
.add-note i { font-size:2.5rem; color:var(--primary-color); }
.add-note:hover { border-color:var(--primary-color); }
.add-note:hover i { transform: scale(1.1); }

/* Note Details */
.note-title { 
  font-size:1.15rem; font-weight:600; 
  margin-bottom:0.6rem; 
  color: var(--primary-color);
}
.note-content { 
  font-size:0.9rem; 
  color:var(--text-secondary); 
  line-height:1.5; 
  margin-bottom:0.8rem;
  overflow:hidden; 
  display:-webkit-box; 
  -webkit-line-clamp:4; 
  -webkit-box-orient:vertical; 
}
.note-date { 
  font-size:0.75rem; 
  color:var(--text-secondary); 
  margin-top:auto; 
}

/* Actions & Buttons */
.note-actions {
  margin-top:1rem;
  display:flex; justify-content:flex-end; align-items:center; gap:0.8rem;
  flex-wrap:wrap;
}
.action-btn {
  background:none; border:none; cursor:pointer;
  color:var(--text-secondary); font-size:1.1rem;
  transition:0.2s;
}
.action-btn:hover { color:var(--primary-color); }
.note-actions .action-btn { font-size:1rem; }
.note-actions .fa-trash-alt { color: var(--accent-color); }
.note-actions .fa-trash-alt:hover { color: #c62828; }

/* Public badge */
.public-badge {
  font-size:0.7rem;
  color:var(--primary-color);
  font-weight:600;
  margin-right:auto;
  display:flex; align-items:center; gap:0.3rem;
  background: rgba(76, 175, 80, 0.15);
  padding: 4px 8px;
  border-radius: 6px;
}

/* Responsive Styles */
@media(max-width:768px){
  .header-content { flex-direction:column; gap:0.8rem; }
  main { margin:1.2rem auto; }
}
@media(max-width:480px){
  .note-card { padding:1.2rem; }
  .note-title { font-size:1rem; }
  .note-content { font-size:0.85rem; -webkit-line-clamp:3; }
  .add-note { padding:1.5rem 0.8rem; }
  .logo { font-size:1.5rem; }
}
</style>
</head>
<body>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.NoteDAO,model.Note,java.util.List,java.text.SimpleDateFormat" %>
<%
    String username = null;
    if (session.getAttribute("username") != null) {
        username = (String) session.getAttribute("username");
    } else {
        response.sendRedirect("login.jsp");
        return;
    }

    List<Note> notes = NoteDAO.getNotesByUser(username);
    SimpleDateFormat sdf = new SimpleDateFormat("dd MMM yyyy HH:mm");
%>
<header>
  <div class="header-content">
    <div class="logo"><i class="fas fa-feather-alt"></i> Parrot Keep</div>
    <div class="user-controls">
      <div class="welcome-message">Hi, <%= username %></div>
      <form action="logout.jsp" method="post" style="margin:0;">
        <button type="submit" class="action-btn" title="Logout">
          <i class="fas fa-sign-out-alt"></i>
        </button>
      </form>
    </div>
  </div>
</header>

<main>
  <div class="notes-container">
    <a class="note-card add-note" href="note.jsp">
      <i class="fas fa-plus-circle"></i>
      <span>Create Note</span>
    </a>

    <% for(Note n : notes) { %>
    <div class="note-card" onclick="window.location.href='note.jsp?id=<%=n.getId()%>'">
      <div class="note-title"><%= n.getTitle() %></div>
      <div class="note-content"><%= n.getContent() %></div>
      <div class="note-date"><i class="fas fa-clock"></i> <%= sdf.format(n.getCreated_at()) %></div>

      <div class="note-actions">
        <% if(n.getIsPublic()) { %>
          <span class="public-badge"><i class="fas fa-globe"></i> Public</span>
          <a href="publicNote.jsp?id=<%= n.getPublicId() %>" target="_blank" class="action-btn" title="Share" onclick="event.stopPropagation();">
            <i class="fas fa-share-alt"></i>
          </a>
        <% } %>
        <form action="DeleteNoteServlet" onsubmit="event.stopPropagation();">
          <input type="hidden" name="id" value="<%= n.getId() %>">
          <button type="submit" class="action-btn" title="Delete">
            <i class="fas fa-trash-alt"></i>
          </button>
        </form>
      </div>
    </div>
    <% } %>
  </div>
</main>

</body>
</html>
