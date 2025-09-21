package servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import dao.NoteDAO;
import model.Note;

@WebServlet("/AddNoteServlet")
public class AddNoteServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if(session == null || session.getAttribute("username") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String username = (String) session.getAttribute("username");
        String title = request.getParameter("title");
        String content = request.getParameter("content");
        boolean isPublic = request.getParameter("isPublic") != null; // checkbox

        if(title != null && content != null && !title.isEmpty() && !content.isEmpty()) {

            // Create Note object, publicId = null, DAO will generate it if public
            Note note = new Note(username, title, content, isPublic, null);

            // Add note via DAO
            boolean success = NoteDAO.addNote(note);

            if(success) {
                response.sendRedirect("home.jsp");
            } else {
                response.sendRedirect("home.jsp?error=Unable to add note");
            }
        } else {
            response.sendRedirect("home.jsp?error=Title and content required");
        }
    }
}
