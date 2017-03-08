package controller;

import model.User;
import persistence.UserDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet(name = "ProfileServlet")
public class ProfileServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        /**
         * Fields
         * ------------
         */

        String name = request.getParameter("name") != null ? request.getParameter("name") : "";
        String pass = request.getParameter("pass") != null ? request.getParameter("pass") : "";
        String passRepeat = request.getParameter("passRepeat") != null ? request.getParameter("passRepeat") : "";
        String avatar = request.getParameter("avatar") != null ? request.getParameter("avatar") : "";
        String about = request.getParameter("about") != null ? request.getParameter("about") : "";
        String delete = request.getParameter("delete") != null ? request.getParameter("delete") : "";
        String where = request.getParameter("where") != null ? request.getParameter("where") : "";

        try {

            UserDAO dao = new UserDAO();

            /**
             * Conditions
             * ------------
             */

            User user = dao.cookieLogin(request.getCookies()); // null == false
            boolean correctUsername = name.matches("[\\w]+");
            boolean correctPermission = where.equals(user.getName()) || user.getRole() < 1;
            boolean correctRequired = !("".equals(name) && "".equals(pass) && "".equals(passRepeat));
            boolean passwordRepeated = pass.equals(passRepeat);
            boolean usernameExists = dao.usernameExists(name);


            /**
             * Statements
             * ------------
             */
            if (!"".equals(delete)) {
                if (dao.delete(where, pass)) {
                    Cookie cookie = new Cookie("user", "");
                    cookie.setMaxAge(0);
                    response.addCookie(cookie);
                    response.sendRedirect("register.jsp");
                } else {
                    request.setAttribute("error", "Incorrect password, enter your current password to delete the user.");
                    request.getRequestDispatcher("profileForm.jsp").forward(request, response);
                }
            } else {
                if (correctUsername && correctPermission && correctRequired && passwordRepeated && usernameExists && user != null) {
                    Cookie cookie = dao.update(where, name, pass, avatar, about);
                    if (cookie != null) {
                        response.addCookie(cookie);
                        response.sendRedirect("profile.jsp");
                    } else {
                        request.setAttribute("error", "Unable to update the user");
                        request.getRequestDispatcher("profileForm.jsp").forward(request, response);
                    }
                } else {
                    StringBuilder error = new StringBuilder();
                    if (!correctUsername) {
                        error.append("The username may only contain a-Z, 0-9 and _ characters.\n");
                    }

                    if (!correctPermission) {
                        error.append("You don't have permissions to edit this user.\n");
                    }

                    if (!correctRequired) {
                        error.append("Please enter all required fields.\n");
                    }

                    if (!passwordRepeated) {
                        error.append("The password, doesn't match the repeated password.\n");
                    }

                    if (!usernameExists) {
                        error.append("The username is does not exists.\n");
                    }

                    if (user == null) {
                        error.append("Unable to update the user.\n");
                    }

                    // The submitted form contains errors, display the form again.
                    request.setAttribute("error", error.toString());
                    request.getRequestDispatcher("profileForm.jsp").forward(request, response);
                }
            }
        } catch (SQLException sqle) {
            sqle.printStackTrace();
        }
    }
}
