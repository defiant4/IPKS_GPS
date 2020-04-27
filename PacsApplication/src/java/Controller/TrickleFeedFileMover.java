/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package Controller;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.logging.Level;
import java.util.logging.Logger;
import org.apache.commons.io.FileUtils;

/**
 *
 * @author 590685
 */
public class TrickleFeedFileMover {

    public void TrickleFeedFileMover(String FileName, String PacsId) throws IOException {
        try {



            String DATE_FORMAT = "yyyyMMdd";
            SimpleDateFormat sdf = new SimpleDateFormat(DATE_FORMAT);
            Calendar c1 = Calendar.getInstance();
            String DirectoryDate = sdf.format(c1.getTime());



            File sourceFile = new File("E:\\TRICKLEFEED\\" + FileName);
            File destinationDir = new File("E:\\TRICKLEFEED\\" + PacsId + "\\" + DirectoryDate);

            if (!destinationDir.exists()) {
                destinationDir.mkdir();
            }

            FileUtils.copyFileToDirectory(sourceFile, destinationDir, true);
            sourceFile.delete();

        } catch (IOException ex) {
            Logger.getLogger(TrickleFeedFileMover.class.getName()).log(Level.SEVERE, null, ex);
        }

    }
    
    
    public static void CBSFileMover(String FileName) throws IOException {
        try {



            String DATE_FORMAT = "yyyyMMdd";
            SimpleDateFormat sdf = new SimpleDateFormat(DATE_FORMAT);
            Calendar c1 = Calendar.getInstance();
            String DirectoryDate = sdf.format(c1.getTime());



            File sourceFile = new File("E:\\CBS_EXTRACT\\" + FileName);
            File destinationDir = new File("E:\\CBS_EXTRACT\\Archived\\"+ DirectoryDate);

            if (!destinationDir.exists()) {
                destinationDir.mkdir();
            }

            FileUtils.copyFileToDirectory(sourceFile, destinationDir, true);
            

        } catch (IOException ex) {
            Logger.getLogger(TrickleFeedFileMover.class.getName()).log(Level.SEVERE, null, ex);
        }

    }
    
    
}
