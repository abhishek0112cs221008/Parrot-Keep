<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.NoteDAO, model.Note, java.text.SimpleDateFormat" %>
<%
    String publicId = request.getParameter("id");
    if(publicId == null || publicId.isEmpty()){
        response.sendRedirect("publicNotes.jsp");
        return;
    }

    Note note = NoteDAO.getNoteByPublicId(publicId);
    if(note == null){
        response.getWriter().println("Note not found or private.");
        return;
    }

    SimpleDateFormat sdf = new SimpleDateFormat("dd MMM yyyy HH:mm");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><%= note.getTitle() %> - Public Note</title>
    
    <!-- Fonts & Icons -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Architects+Daughter&family=Roboto+Slab:wght@400;700&display=swap" rel="stylesheet">
    
    <!-- Favicon -->
    <link rel="icon" href="https://img.icons8.com/ios-filled/50/ffffff/feather.png" type="image/png">

    <style>
        :root {
            --primary-color: #4CAF50; /* Parrot Green */
            --primary-dark: #2E7D32;
            --accent-color: #E53935;
            --text-primary: #f0f0f0;
            --text-secondary: #b0b0b0;
            --background-dark: #0e1f0e; /* darker greenish bg */
            --card-background: #1a2e1a;
            --card-border: #2e4730;
            --shadow-dark: 0 4px 12px rgba(0,0,0,0.4);
            --shadow-hover: 5px 5px 0 var(--primary-dark);
            --border-radius: 12px;
            --transition: all 0.2s cubic-bezier(0.4, 0.0, 0.2, 1);
        }

        * { margin: 0; padding: 0; box-sizing: border-box; }

        body {
            font-family: 'Roboto Slab', serif;
            background-color: var(--background-dark);
            min-height: 100vh;
            display: flex;
            flex-direction: column;
            align-items: center;
            padding: 3rem 1rem;
        }

        /* Note Container */
        .note-container {
            background-color: var(--card-background);
            padding: 40px 50px;
            box-shadow: var(--shadow-dark);
            border-radius: var(--border-radius);
            border: 2px solid var(--card-border);
            max-width: 800px;
            width: 100%;
            animation: flyIn 0.8s ease-in-out;
        }

        @keyframes flyIn {
            from { transform: scale(0.8) rotate(-3deg); opacity: 0; }
            to { transform: scale(1) rotate(0); opacity: 1; }
        }

        /* Title */
        .note-title {
            font-family: 'Architects Daughter', cursive;
            font-size: 2.5rem;
            color: var(--primary-color);
            margin-bottom: 1rem;
        }

        /* Meta info */
        .note-meta {
            display: flex;
            gap: 1.5rem;
            margin-bottom: 1.5rem;
            font-size: 0.9rem;
            color: var(--text-secondary);
        }
        .note-meta i { color: var(--primary-color); }

        /* Content */
        .note-content {
            font-family: 'Architects Daughter', cursive;
            font-size: 1.2rem;
            color: var(--text-primary);
            white-space: pre-wrap;
            margin-bottom: 2rem;
        }

        /* Action Buttons */
        .action-bar {
            display: flex;
            gap: 15px;
            justify-content: center;
            flex-wrap: wrap;
        }

        .action-btn {
            padding: 12px 25px;
            border: 2px solid var(--primary-color);
            border-radius: 8px;
            font-weight: bold;
            cursor: pointer;
            transition: var(--transition);
            background: transparent;
            color: var(--primary-color);
        }

        .action-btn:hover {
            transform: translateY(-4px);
            box-shadow: var(--shadow-hover);
        }

        .btn-copy { background: var(--primary-color); color: #fff; border: none; }

        /* Footer */
        .public-footer {
            margin-top: 2rem;
            text-align: center;
            font-size: 0.9rem;
            color: var(--text-secondary);
        }
        .public-footer a { color: var(--primary-color); text-decoration: none; }
        .public-footer a:hover { text-decoration: underline; }

        /* Responsive */
        @media (max-width: 768px) {
            .note-container { padding: 20px; }
            .note-title { font-size: 1.8rem; }
            .note-content { font-size: 1rem; }
            .action-btn { width: 100%; }
        }
    </style>
</head>
<body>

    <div class="note-container">
        <div class="note-title"><i class="fas fa-feather-alt"></i> <%= note.getTitle() %></div>
        
        <div class="note-meta">
            <div><i class="far fa-calendar-alt"></i> Created: <%= sdf.format(note.getCreated_at()) %></div>
            <div><i class="fas fa-eye"></i> Public View</div>
        </div>
        
        <div class="note-content"><%= note.getContent() %></div>
        
        <div class="action-bar">
            <button class="action-btn btn-copy" onclick="copyToClipboard()"><i class="fas fa-copy"></i> Copy</button>
            <button class="action-btn" onclick="shareNote()"><i class="fas fa-share-alt"></i> Share</button>
            <button class="action-btn" onclick="window.print()"><i class="fas fa-print"></i> Print</button>
        </div>
    </div>

    <div class="public-footer">
        <p>Made with <i class="fas fa-feather-alt"></i> in <span style="color:var(--primary-color);">Parrot Keep</span> | <a href="index.html">Go Home</a></p>
    </div>

<script>
    // Copy note
    async function copyToClipboard() {
        const text = `<%= note.getTitle() %>\n\n<%= note.getContent() %>`;
        try {
            await navigator.clipboard.writeText(text);
            alert("Copied to clipboard!");
        } catch (err) {
            console.error(err);
        }
    }

    // Share note
    async function shareNote() {
        const shareData = {
            title: "<%= note.getTitle() %>",
            text: "Check out this note!",
            url: window.location.href
        };
        try {
            if (navigator.share) {
                await navigator.share(shareData);
            } else {
                await navigator.clipboard.writeText(window.location.href);
                alert("Link copied to clipboard!");
            }
        } catch (err) {
            console.error(err);
        }
    }
</script>
</body>
</html>
