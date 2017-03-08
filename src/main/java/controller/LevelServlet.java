package controller;

import model.User;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import persistence.LevelDAO;
import persistence.UserDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet(name = "LevelServlet")
public class LevelServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Variable containing the DAO
        LevelDAO dao = new LevelDAO();

        // Variable should contain the uploaded file
        FileItem upload = null;

        // Folder to store the upload in
        String storage =   getServletContext().getRealPath("") + File.separator + "download";
        File dir = new File(storage);

        // Container for all fields
        Map<String, String> fields = new HashMap<String, String>();

        try {
            // Get the request sent with the form
            List<FileItem> items = new ServletFileUpload(new DiskFileItemFactory()).parseRequest(request);

            // Iterate over all items in the request
            for (FileItem item : items) {
                if (item.isFormField()) {
                    // The item is a regular field
                    fields.put(item.getFieldName(), item.getString());
                } else {
                    // The item is a file upload field
                    String name = new File(item.getName()).getName();
                    fields.put(item.getFieldName(), name);
                    upload = item;
                }
            }
        } catch (FileUploadException fue) {
            fue.printStackTrace();
        }

        // Put all map values in a variable
        String filename = fields.get("file");
        String title = fields.get("title");
        String version = fields.get("version");
        String previousVersion = fields.get("previousVersion");
        String games = fields.get("games");
        String gametypes = fields.get("gametypes");
        String description = fields.get("description");

        try {
            // Get the user responsible for this action
            User user = new UserDAO().cookieLogin(request.getCookies());
            String userName = user.getName();

            if ("Add".equals(fields.get("mode"))) {
                boolean correctRequired = !("".equals(filename) && "".equals(title) && "".equals(version) && "".equals(games) && "".equals(gametypes) && "".equals(description));
                boolean correctPermission = user.getRole() > 0;
                boolean correctFile = dao.read(filename) == null && !new File(storage + File.separator + filename).exists();

                // Statements
                if (correctRequired && correctPermission && correctFile && upload != null) {
                    if (dao.create(filename, title, version, previousVersion, games, gametypes, description, userName)) {
                        upload.write(new File(storage + File.separator + filename));
                    } else {
                        request.setAttribute("error", "Unable to create the level.\n");
                        request.getRequestDispatcher("levelForm.jsp?filename=" + filename).forward(request, response);
                    }
                } else {
                    StringBuilder error = new StringBuilder();
                    if (!correctRequired) {
                        error.append("Please enter all required fields.\n");
                    }
                    if (!correctPermission) {
                        error.append("Seems like you're not allowed to perform this action.\n");
                    }
                    if (!correctFile) {
                        error.append("The file you're trying to upload already exists.\n");
                    }
                    request.setAttribute("error", error.toString());
                    request.getRequestDispatcher("levelForm.jsp?filename=" + filename).forward(request, response);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
