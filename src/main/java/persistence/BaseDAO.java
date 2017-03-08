package persistence;


import com.mysql.jdbc.jdbc2.optional.MysqlDataSource;

import javax.naming.InitialContext;
import javax.sql.DataSource;
import java.sql.Connection;
import java.sql.SQLException;

public class BaseDAO {
    public Connection getConnection() {
        Connection c = null;
        try {
            /**
             * OpenShift
             * ------------
             */

            InitialContext ic = new InitialContext();
            DataSource ds = (DataSource) ic.lookup("java:comp/env/jdbc/MySQLDS");

            /**
             * Local
             * ------------
             *

            int port = 3306;
            String host = "localhost";
            String dbname = "edu_ipass";
            String dbuser = "root";
            String dbpass = "r158Lwb5E4j34pA";

            MysqlDataSource ds = new MysqlDataSource();
            ds.setPort(port);
            ds.setServerName(host);
            ds.setDatabaseName(dbname);
            ds.setUser(dbuser);
            ds.setPassword(dbpass);
            /**/

            c = ds.getConnection();
        } catch (Exception e) {
            e.printStackTrace();
        }


        /**
         * Return the connection
         * ------------
         */

        return c;
    }
}
