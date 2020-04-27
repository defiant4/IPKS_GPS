package LoginDb;

/**
 *
 * @author 590685
 */


public class passwordEncryption {

    public static String Encr_pass(String plainText,String secretKey)
  {
     {
		StringBuffer encryptedString = new StringBuffer();
		int encryptedInt;
                secretKey+=plainText;
		for (int i = 0; i < plainText.length(); i++) {
			int plainTextInt = (int) (plainText.charAt(i) - 'A');
			int secretKeyInt = (int) (secretKey.charAt(i) - 'A');
			encryptedInt = (plainTextInt + secretKeyInt) % 26;
			encryptedString.append((char) ((encryptedInt) + (int) 'A'));
		}
		return encryptedString.toString();
	}
  }

}

