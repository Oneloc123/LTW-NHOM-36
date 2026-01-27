package vn.model;
import jakarta.mail.*;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;

import java.io.InputStream;
import java.util.Properties;

public class EmailUtil {
    private static final String EMAIL = "Oneloc123@gmail.com";
    private static final String APP_PASSWORD = "otda nuuj nyfd damj";

    public static void send(String to, String subject, String content) {
        Properties props = new Properties();

        // Gmail SMTP
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");

        Session session = Session.getInstance(props, new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(EMAIL, APP_PASSWORD);
            }
        });

        try {
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(EMAIL, "TechX Support"));
            message.setRecipients(
                    Message.RecipientType.TO,
                    InternetAddress.parse(to)
            );
            message.setSubject(subject);

            // HTML email
            message.setContent(content, "text/html; charset=UTF-8");

            Transport.send(message);

        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException("Không thể gửi email. Vui lòng thử lại sau.");
        }
    }
}
