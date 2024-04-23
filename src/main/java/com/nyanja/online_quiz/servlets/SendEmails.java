package com.nyanja.online_quiz.servlets;

import javax.mail.*;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

public class SendEmails {

    public void sendEmail(String to, String subject, String body) {
        // Set mail properties
        java.util.Properties properties = System.getProperties();
        properties.setProperty("mail.smtp.host", "smtp.gmail.com");
        properties.setProperty("mail.smtp.port", "587");
        properties.setProperty("mail.smtp.auth", "true");
        properties.setProperty("mail.smtp.starttls.enable", "true");
        properties.setProperty("mail.smtp.tsl.trust", "smtp.gmail.com");
        //properties.setProperty("mail.smtp.password", "NyanjaCyane");

        // Create session
        Session session = Session.getInstance(properties, new Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication("ishimwe.nyanja@gmail.com", "lueb sbmw dkdm nulx");
            }
        });

        try {
            // Create message
            MimeMessage mimeMessage = new MimeMessage(session);
            mimeMessage.setFrom(new InternetAddress("ishimwe.nyanja@gmail.com"));
            mimeMessage.addRecipient(Message.RecipientType.TO, new InternetAddress(to));
            mimeMessage.setSubject(subject);
            mimeMessage.setText(body);
            // Send the message
            Transport.send(mimeMessage);

            System.out.println("Email sent successfully!");
        } catch (MessagingException e) {
            e.printStackTrace();
        }
    }
}
