/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Classes;


import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.util.Properties;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

/**
 *
 * @author Mechri
 */
public class Model {

    /*
    static DbHandler db;
    static Connection connection;

    public static int Newline(String table,String id) {
        db = new DbHandler();
        connection = db.getConnection();
        int max = 1;

        try {
            ResultSet rs = connection.createStatement().executeQuery("select max("+id+") from `"+table+"`");
            while (rs.next()) {
                max = rs.getInt(1);
            }
            max++;
        } catch (Exception e) {
        }
        return max;
    }
    
    
    public static void main(String[] args) {
        System.out.println(Model.Newline("structure","id_structure"));
    }
     */
    public static boolean SendMail(String mail, String subject, String txt) {
        final String username = "a.mechri@imtrade-dz.com"; //ur email
        final String password = "ESSetif30072004";

        Properties props = new Properties();
        props.put("mail.smtp.auth", true);
        props.put("mail.smtp.starttls.enable", true);

        props.put("mail.smtp.host", "smtp.yandex.com");
        props.put("mail.smtp.port", "587");
        /* 
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");
         */
        Session session = Session.getInstance(props, new javax.mail.Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(username, password);
            }
        });

        try {

            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(username));//ur email
            message.setRecipients(Message.RecipientType.TO,
                    InternetAddress.parse(mail));//u will send to
            message.setSubject(subject);
            message.setText(txt);
            System.out.println("sending");
            Transport.send(message);
            System.out.println("Done");
            return true;
        } catch (MessagingException e) {
            return false;

        }
    }

    
    public static String gethash(String password) {
        MessageDigest alg;
        try {
            alg = MessageDigest.getInstance("sha-512");
            //String password = "UNVconstantine30072004";

            alg.reset();
            alg.update(password.getBytes());

            byte[] digest = alg.digest();
            StringBuffer hashedpasswd = new StringBuffer();
            String hx;
            for (int i = 0; i < digest.length; i++) {
                hx = Integer.toHexString(0xFF & digest[i]);
                //0x03 is equal to 0x3, but we need 0x03 for our md5sum
                if (hx.length() == 1) {
                    hx = "0" + hx;
                }
                hashedpasswd.append(hx);
            }

// Print out the string hex version of the md5 hash
            return hashedpasswd.toString();
        } catch (NoSuchAlgorithmException ex) {
            Logger.getLogger(Model.class.getName()).log(Level.SEVERE, null, ex);
        }
        return password;
    }
    
    
    
    
    

}
