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

@WebServlet(name = "LoginServlet")
public class LoginServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        /**
         * Fields
         * ------------
         */

        String name = request.getParameter("name");
        String pass = request.getParameter("pass");

        try {

            UserDAO dao = new UserDAO();

            /**
             * Conditions
             * ------------
             */

            boolean usernameCorrect = name.matches("[\\w]+");
            boolean usernameExists = dao.usernameExists(name);
            Cookie cookie = dao.login(name, pass); // null == false


            /**
             * Statements
             * ------------
             */

            if (usernameCorrect && usernameExists && cookie != null) {
                response.addCookie(cookie);
                response.sendRedirect("profile.jsp");
            } else {
                StringBuilder error = new StringBuilder();
                if (!usernameCorrect) {
                    error.append("The username may only contain a-Z, 0-9 and _ characters.\n");
                }

                if (!usernameExists) {
                    error.append("The username doesn't exist.\n");
                }

                if (cookie == null) {
                    error.append("Incorrect password for the given username.\n");
                }

                // The submitted form contains errors, display the form again.
                request.setAttribute("error", error.toString());
                request.getRequestDispatcher("login.jsp").forward(request, response);
            }
        } catch (SQLException sqle) {
            sqle.printStackTrace();
        }
    }
}
