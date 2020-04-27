/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package LoginDb;

/**
 *
 * @author 590685
 */

import java.text.ParseException;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.sql.*;
import javax.naming.*;
import javax.sql.*;

public class DbHandler {

//	private static final String DB_DRIVER = "oracle.jdbc.driver.OracleDriver";
//	private static final String DB_CONNECTION = "jdbc:oracle:thin:@172.18.15.109:1521:INSP";
//	private static final String DB_USER = "pacsdata";
//	private static final String DB_PASSWORD = "pacsdata";

          public static Connection getDBConnection()
        {
            Connection dbConnection = null;
//            try {
//                    Class.forName(DB_DRIVER);
//                }catch (ClassNotFoundException e) {
//                    System.out.println(e.getMessage());
//                }
//            try {
//                    dbConnection = DriverManager.getConnection(DB_CONNECTION, DB_USER,DB_PASSWORD);
//			return dbConnection;
//                }catch (SQLException e) {
//                    System.out.println(e.getMessage());
//                }
             String DATASOURCE_CONTEXT = "java:comp/env/jdbc/conDS";
                try {
                    Context initialContext = new InitialContext();
                    if ( initialContext == null){
                    System.out.println("JNDI problem. Cannot get InitialContext.");
                    }
            DataSource datasource = (DataSource)initialContext.lookup(DATASOURCE_CONTEXT);
                    if (datasource != null) {
                    dbConnection = datasource.getConnection();
                    }
                else {
                System.out.println("Failed to lookup datasource.");
                     }
                    }catch ( NamingException ex ) {
                    System.out.println("Cannot get connection: " + ex);
                    }catch(SQLException ex){
                    System.out.println("Cannot get connection: " + ex);
                    }

           return dbConnection;
        }

     public static void closeDbConnection (Connection conn) throws SQLException{
        try
        {
         conn.close();
        }catch (SQLException ex)
        {

            ex.printStackTrace();

        }

     }
}
