package servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import dao.NoteDAO;
import model.Note;

@WebServlet("/UpdateNoteServlet")
public class UpdateNoteServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if(session == null || session.getAttribute("username") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String username = (String) session.getAttribute("username");
        String idStr = request.getParameter("id");
        String title = request.getParameter("title");
        String content = request.getParameter("content");
        boolean isPublic = request.getParameter("isPublic") != null; // checkbox

        if(idStr != null && !idStr.isEmpty() && title != null && !title.isEmpty() && content != null && !content.isEmpty()) {
            int id = Integer.parseInt(idStr);

            Note note = new Note();
            note.setId(id);
            note.setUsername(username);
            note.setTitle(title);
            note.setContent(content);
            note.setIsPublic(isPublic);

            boolean success = NoteDAO.updateNote(note);

            if(success) {
                response.sendRedirect("home.jsp");
            } else {
                response.sendRedirect("note.jsp?id=" + id + "&error=Unable to update note");
            }

        } else {
            response.sendRedirect("note.jsp?id=" + idStr + "&error=All fields are required");
        }
    }
}
