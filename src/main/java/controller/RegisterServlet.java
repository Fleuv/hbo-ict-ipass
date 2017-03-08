package controller;

import persistence.UserDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet(name = "RegisterServlet")
public class RegisterServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        /**
         * Fields
         * ------------
         */

        String name         = request.getParameter("name");
        String pass         = request.getParameter("pass");
        String passRepeat   = request.getParameter("passRepeat");
        String avatar       = request.getParameter("avatar");
        String about        = request.getParameter("about");

        try {

            UserDAO dao = new UserDAO();

            /**
             * Conditions
             * ------------
             */

            boolean usernameCorrect = name.matches("[\\w]+");
            boolean passwordRepeated = pass.equals(passRepeat);
            boolean usernameAvailable = !dao.usernameExists(name);


        /**
         * Statements
         * ------------
         */

            if (usernameCorrect && passwordRepeated && usernameAvailable) {
                Cookie cookie = dao.create(name, pass, avatar, about, 1);
                if (cookie != null) {
                    response.addCookie(cookie);
                    response.sendRedirect("profile.jsp");
                } else {
                    request.setAttribute("error", "Unable to create the user");
                    request.getRequestDispatcher("register.jsp").forward(request, response);
                }
            } else {
                StringBuilder error = new StringBuilder();
                if (!usernameCorrect) {
                    error.append("The username may only contain a-Z, 0-9 and _ characters.\n");
                }

                if (!usernameAvailable) {
                    error.append("The username is not available anymore.\n");
                }

                if (!passwordRepeated) {
                    error.append("The password, doesn't match the repeated password.\n");
                }

                // The submitted form contains errors, display the form again.
                request.setAttribute("error", error.toString());
                request.getRequestDispatcher("register.jsp").forward(request, response);
            }
        } catch (SQLException sqle) {
            sqle.printStackTrace();
        }
    }
}
