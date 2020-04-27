/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package LoginDb;

import java.text.ParseException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author 590685
 */
public class DbConnection {

        public String validateUserLogin (String userId, String password, String PacsId) throws SQLException{
        Connection connection = null;
        ResultSet resultset = null;
        Statement statement = null;

        String ExistPassword ="";

       
         
        try {

           
            connection =DbHandler.getDBConnection();


            statement = connection.createStatement();

             //look at " for table name
            ResultSet rs = statement.executeQuery("SELECT password FROM login_details where login_id= '" + userId + "' and pacs_id='" + PacsId + "'");
            

            //print the result set
            while (rs.next())
            {
                
            ExistPassword =  rs.getString("password");

            }

           

            statement.close();
            connection.close();


        } catch (SQLException ex)
        {

            ex.printStackTrace();
            
        } 

         return ExistPassword;
        }

}