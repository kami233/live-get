import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;

public class FileMerge {

    public static void main(String[] args) throws IOException {
        String originalFilePath = "F:\\KuGou\\MicrosoftEdgeEnterpriseX64.msi";
        String partFileDirectoryPath = "F:\\KuGou";
        int partCount = 5;

        mergeFile(originalFilePath, partFileDirectoryPath, partCount);
    }

    public static void mergeFile(String originalFilePath, String partFileDirectoryPath, int partCount) throws IOException {
        File originalFile = new File(originalFilePath);
        if (originalFile.exists()) {
            throw new IOException("The original file already exists: " + originalFilePath);
        }

        try (FileOutputStream fos = new FileOutputStream(originalFile, true)) {
            for (int i = 1; i <= partCount; i++) {
                File partFile = new File(partFileDirectoryPath, originalFile.getName() + ".part" + i);
                try (FileInputStream fis = new FileInputStream(partFile)) {
                    byte[] buffer = new byte[1024];
                    int len;
                    while ((len = fis.read(buffer)) > 0) {
                        fos.write(buffer, 0, len);
                    }
                }
            }
        }
    }
}

