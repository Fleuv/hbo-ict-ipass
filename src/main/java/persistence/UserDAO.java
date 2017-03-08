package persistence;

import model.User;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.PreparedStatement;

public class UserDAO extends BaseDAO {

    public Cookie create(String name, String pass, String avatar, String about, int role) throws SQLException {
        Connection c = getConnection();
        PreparedStatement ps = c.prepareStatement("INSERT INTO `user` (`name`,`password`,`avatar`,`about`,`role`) VALUES (?,?,?,?,?)");
        ps.setString(1, name);
        ps.setString(2, createHash(pass));
        ps.setString(3, avatar);
        ps.setString(4, about);
        ps.setInt(5, role);
        ps.executeUpdate();
        ps.close();
        c.close();
        return login(name, pass);
    }

    public User read(String name) throws SQLException {
        User user = null;
        Connection c = super.getConnection();
        PreparedStatement ps = c.prepareStatement("SELECT * FROM `user` WHERE `name`=?");
        ps.setString(1, name);
        ResultSet rs = ps.executeQuery();
        while (rs.next()) {
            user = new User(
                rs.getString("name"),
                rs.getString("password"),
                rs.getString("avatar"),
                rs.getString("about"),
                rs.getInt("role")
            );
        }
        rs.close();
        ps.close();
        c.close();
        return user;
    }

    public Cookie update(String where, String name, String pass, String avatar, String about) throws SQLException {
        Connection c = getConnection();
        PreparedStatement ps = c.prepareStatement("UPDATE `user` SET `name`=?, `password`=?, `avatar`=?, `about`=? WHERE `name`=?");
        ps.setString(1, name);
        ps.setString(2, createHash(pass));
        ps.setString(3, avatar);
        ps.setString(4, about);
        ps.setString(5, where);
        ps.executeUpdate();
        ps.close();
        c.close();
        return login(name, pass);
    }

    public boolean delete(String name, String pass) throws SQLException {
        Connection c = getConnection();
        PreparedStatement ps = c.prepareStatement("DELETE FROM `user` WHERE `name`=? AND `password`=?");
        ps.setString(1, name);
        ps.setString(2, createHash(pass));
        boolean result = ps.executeUpdate() > 0;
        ps.close();
        c.close();
        return result;
    }

    public Cookie login(String name, String pass) throws SQLException {
        pass = createHash(pass);

        Connection c = super.getConnection();
        PreparedStatement ps = c.prepareStatement("SELECT `name` FROM `user` WHERE `name`=? AND `password`=?");
        ps.setString(1, name);
        ps.setString(2, pass);
        ResultSet rs = ps.executeQuery();
        boolean correct = rs.next();
        rs.close();
        ps.close();
        c.close();
        return correct ? new Cookie("user", name+":"+pass) : null;
    }

    public User cookieLogin(Cookie[] cookies) throws SQLException {
        User user = null;
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if ("user".equals(cookie.getName())) {
                    int separator = cookie.getValue().lastIndexOf(":");
                    String name = cookie.getValue().substring(0, separator);
                    String hash = cookie.getValue().substring(separator + 1);

                    Connection c = super.getConnection();
                    PreparedStatement ps = c.prepareStatement("SELECT * FROM `user` WHERE `name`=? AND `password`=?");
                    ps.setString(1, name);
                    ps.setString(2, hash);
                    ResultSet rs = ps.executeQuery();
                    while (rs.next()) {
                        user = new User(
                                rs.getString("name"),
                                rs.getString("password"),
                                rs.getString("avatar"),
                                rs.getString("about"),
                                rs.getInt("role")
                        );
                    }
                    rs.close();
                    ps.close();
                    c.close();
                }
            }
        }
        return user;
    }

    public boolean usernameExists(String name) throws SQLException {
        Connection c = super.getConnection();
        PreparedStatement ps = c.prepareStatement("SELECT `name` FROM `user` WHERE `name`=?");
        ps.setString(1, name);
        ResultSet rs = ps.executeQuery();
        boolean out = rs.next();
        rs.close();
        ps.close();
        c.close();
        return out;
    }

    public String createHash(String pass) {
        String hash = null;
        try {
            // Create MessageDigest instance for MD5
            MessageDigest md = MessageDigest.getInstance("SHA-256");

            //Add password bytes to digest
            md.update(pass.getBytes());

            //Get the hash's bytes
            byte[] bytes = md.digest();

            // Convert it to hexadecimal format
            StringBuilder sb = new StringBuilder();
            for(int i=0; i< bytes.length ;i++) {
                sb.append(Integer.toString((bytes[i] & 0xff) + 0x100, 16).substring(1));
            }

            // Get complete hashed password in hex format
            hash = sb.toString();
        } catch (NoSuchAlgorithmException nsae) {
            nsae.printStackTrace();
        }
        return hash;
    }
}
