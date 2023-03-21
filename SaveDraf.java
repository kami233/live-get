import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Properties;

import javax.activation.DataHandler;
import javax.activation.FileDataSource;
import javax.mail.*;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;

public class SaveDraf {

    public static String host = "smtp.qq.com"; // 发件服务器
    public static String username = "";//邮箱账户
    public static String password = "";//密码
    public static String filePath = "F:\\KuGou\\MicrosoftEdgeEnterpriseX64.msi"; // 文件路径
    public static String fileName = "MicrosoftEdgeEnterpriseX64.msi"; // 文件名
    public static int partSize = 25 * 1024 * 1024; // 每个 part 文件大小（字节）
    public static String mailContent = "7p~ 140M"; // 邮件内容

    public static void main(String[] args) {
        sendMail("", fileName, mailContent);
    }

    /**
     * @param to      收件人
     * @param title   主题
     * @param content 内容
     */
    public static void sendMail(String to, String title, String content) {
        Properties props = System.getProperties();
        props.put("mail.smtp.host", host);
        props.put("mail.smtp.port", "465");
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.ssl.enable", "true"); // 开启SSL加密
        Session session = Session.getInstance(props, new Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(username, password);
            }
        });
        try {
            List<File> fileList = splitFile(filePath);   //拆分大文件
            // 连接IMAP服务器
            Store store = session.getStore("imap");
            store.connect(host, username, password);
            for (int i = 0; i < fileList.size(); i++) {  //part附件设置
                Folder folder = store.getFolder("Drafts");// 打开草稿箱
                folder.open(Folder.READ_WRITE);
                MimeMessage mmessage = new MimeMessage(session);
                mmessage.setFrom(new InternetAddress(username));
                mmessage.setRecipient(Message.RecipientType.TO, new InternetAddress(to));
                mmessage.setSubject(title);
                Multipart mainPart = new MimeMultipart();
                BodyPart html = new MimeBodyPart();
                html.setContent(content, "text/html; charset=utf-8");
                mainPart.addBodyPart(html);
                BodyPart attach = new MimeBodyPart();  //创建邮件附件
                DataHandler dh = new DataHandler(new FileDataSource(fileList.get(i).getAbsolutePath()));
                attach.setDataHandler(dh);
                attach.setFileName(dh.getName());  //
                mainPart.addBodyPart(attach);   //添加附件
                mmessage.setContent(mainPart);
                mmessage.setSentDate(new Date());
                mmessage.saveChanges();
                mmessage.setFlag(Flags.Flag.DRAFT, true);
                MimeMessage draftMessages[] = {mmessage};
                folder.appendMessages(draftMessages);
                System.out.println("保存成功" + i);
                folder.close(true); // 关闭Folder
            }
            store.close(); // 关闭Store
            for (int i=0; i<fileList.size(); i++) {  //删除part文件
                fileList.get(i).delete();
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        }
    }
    
    /**
     * 拆分文件
     * @param filePath
     * @return
     */
    private static List<File> splitFile(String filePath) {
        List<File> fileList = new ArrayList<>();
        try {
            File file = new File(filePath);
            long fileSize = file.length();
            int partCount = (int) Math.ceil((double) fileSize / (double) partSize);   // 计算分块数量
            FileInputStream fis = new FileInputStream(file);
            byte[] buffer = new byte[partSize];
            int len;
            int count = 1;
            while ((len = fis.read(buffer)) > 0) {
                File partFile = new File(file.getParentFile(), file.getName() + ".part" + String.format("%0" + (int) Math.ceil(Math.log10(partCount)) + "d", count));
                FileOutputStream fos = new FileOutputStream(partFile);
                fos.write(buffer, 0, len);
                fos.close();
                fileList.add(partFile);
                if (++count > partCount) {
                    break;
                }
            }
            fis.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return fileList;
    }
}
