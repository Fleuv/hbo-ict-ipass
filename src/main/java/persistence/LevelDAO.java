package persistence;

import model.Level;
import model.User;

import javax.servlet.http.Cookie;
import java.sql.*;
import java.util.ArrayList;

public class LevelDAO extends BaseDAO {
    public boolean create(String filename, String title, String version, String previousVersion, String games, String gametypes, String description, String userName) throws SQLException {
        Connection c = getConnection();
        PreparedStatement ps = c.prepareStatement("INSERT INTO `level` (`filename`, `title`, `version`, `history`, `game`, `gametype`, `description`, `user_name`) VALUES (?,?,?,?,?,?,?,?)");
        ps.setString(1, filename);
        ps.setString(2, title);
        ps.setString(3, version);
        ps.setString(4, previousVersion);
        ps.setString(5, games);
        ps.setString(6, gametypes);
        ps.setString(7, description);
        ps.setString(8, userName);
        boolean result = ps.executeUpdate() > 0;
        ps.close();
        c.close();
        return result;
    }

    public Level read(String filename) throws SQLException {
        UserDAO dao = new UserDAO();
        Level level = null;
        Connection c = super.getConnection();
        PreparedStatement ps = c.prepareStatement("SELECT * FROM `level` WHERE `filename`=?");
        ps.setString(1, filename);
        ResultSet rs = ps.executeQuery();
        while (rs.next()) {
            level = new Level(
                    rs.getString("filename"),
                    rs.getString("title"),
                    rs.getString("description"),
                    rs.getString("version"),
                    rs.getString("history"),
                    rs.getString("game").split(","),
                    rs.getString("gametype").split(","),
                    dao.read(rs.getString("user_name"))
            );
        }
        rs.close();
        ps.close();
        c.close();
        return level;
    }

    public boolean update(String filename, String title, String version, String previousVersion, String games, String gametypes, String description) throws  SQLException {
        Connection c = getConnection();
        PreparedStatement ps = c.prepareStatement("UPDATE `level` SET `title`=?, `version`=?, `history`=?, `game`=?, `gametype`=?, `description`=? WHERE `filename`=?");
        ps.setString(1, title);
        ps.setString(2, version);
        ps.setString(3, previousVersion);
        ps.setString(4, games);
        ps.setString(5, gametypes);
        ps.setString(6, description);
        ps.setString(7, filename);
        boolean result = ps.executeUpdate() > 0;
        ps.close();
        c.close();
        return result;
    }

    public boolean delete(String filename) throws SQLException {
        Connection c = getConnection();
        PreparedStatement ps = c.prepareStatement("DELETE FROM `level` WHERE `filename`=?");
        ps.setString(1, filename);
        boolean result = ps.executeUpdate() > 0;
        ps.close();
        c.close();
        return result;
    }

    public ArrayList<Level> readAll() throws SQLException {
        UserDAO dao = new UserDAO();
        ArrayList<Level> levels = new ArrayList<Level>();
        Connection c = super.getConnection();
        Statement s = c.createStatement();
        ResultSet rs = s.executeQuery("SELECT * FROM `level`");
        while (rs.next()) {
            levels.add(new Level(
                    rs.getString("filename"),
                    rs.getString("title"),
                    rs.getString("description"),
                    rs.getString("version"),
                    rs.getString("history"),
                    rs.getString("game").split(","),
                    rs.getString("gametype").split(","),
                    dao.read(rs.getString("user_name"))
            ));
        }
        rs.close();
        s.close();
        c.close();
        return levels;
    }
    public ArrayList<Level> readWhereUser(String userName) throws SQLException {
        UserDAO dao = new UserDAO();
        ArrayList<Level> levels = new ArrayList<Level>();
        Connection c = super.getConnection();
        PreparedStatement ps = c.prepareStatement("SELECT * FROM `level` WHERE `user_name`=?");
        ps.setString(1, userName);
        ResultSet rs = ps.executeQuery();
        while (rs.next()) {
            levels.add(new Level(
                    rs.getString("filename"),
                    rs.getString("title"),
                    rs.getString("description"),
                    rs.getString("version"),
                    rs.getString("history"),
                    rs.getString("game").split(","),
                    rs.getString("gametype").split(","),
                    dao.read(rs.getString("user_name"))
            ));
        }
        rs.close();
        ps.close();
        c.close();
        return levels;
    }
}
