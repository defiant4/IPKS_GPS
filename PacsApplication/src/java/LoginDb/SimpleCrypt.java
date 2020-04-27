/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package LoginDb;

/**
 *
 * @author Tcs Helpdesk10
 */
import javax.swing.*; 


public class SimpleCrypt 
{
  

  public static String doEnrcypt(String sArgument) {
  String encoded=null;
  
   
    try {
      
      String secret = new String(encrypt(sArgument));
      sun.misc.BASE64Encoder encoder = new sun.misc.BASE64Encoder();
      encoded=encoder.encode(secret.getBytes());
      System.out.println("the encrypted result : " + encoded);
      } 
    catch (Exception e){
      e.printStackTrace();
    }
    return encoded;

  }

public  static byte[] encrypt(String x)   throws Exception
  {
     java.security.MessageDigest d =null;
     d = java.security.MessageDigest.getInstance("SHA-1");
     d.reset();
     d.update(x.getBytes());
     return  d.digest();
  }

}




