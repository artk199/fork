package pl.fork.file

import grails.transaction.Transactional

import javax.imageio.ImageIO
import java.awt.Color
import java.awt.Image
import java.awt.image.BufferedImage

@Transactional
class ImageScaleService {

    /**
     * Scales intelligently, keeping the aspect ratio intact. Will only downscale.
     * @param fileData byte array representing image to scale
     * @param maxLength
     * @return byte array of scaled image
     */
    public byte[] scale(byte[] fileData, int maxLength ){
        ByteArrayInputStream input = new ByteArrayInputStream(fileData)
        try {
            BufferedImage img = ImageIO.read(input)

            int height = img.getHeight()
            int width = img.getWidth()
            if( height < maxLength && width < maxLength ){
                return fileData
            }

            int biggerDimension = height > width ? height : width;

            double ratio = maxLength / biggerDimension;
            ratio = ((double)maxLength / (double)biggerDimension);

            int newWidth = width*ratio
            int newHeight = height*ratio

            Image scaledImage = img.getScaledInstance(newWidth, newHeight, Image.SCALE_SMOOTH)

            BufferedImage imageBuff = new BufferedImage(newWidth, newHeight, BufferedImage.TYPE_INT_RGB);

            imageBuff.getGraphics().drawImage(scaledImage, 0, 0, new Color(0, 0, 0), null);

            ByteArrayOutputStream buffer = new ByteArrayOutputStream();

            ImageIO.write(imageBuff, "jpg", buffer);

            return buffer.toByteArray();
        } catch (IOException e) {
            throw new Exception("IOException in scale");
        }
    }

    /**
     * Scales without any common reason. Will either downscale or upscale depending on given size
     * @param fileData byte array representing image to scale
     * @param width width of new image in pixels
     * @param height height of new image in pixels
     * @return byte array of scaled image
     */
    public byte[] scale(byte[] fileData, int width, int height) {
        ByteArrayInputStream input = new ByteArrayInputStream(fileData);
        try {
            BufferedImage img = ImageIO.read(input)

            int imgHeight = img.getHeight()
            int imgWidth = img.getWidth()

            if (height == 0) {
                height = (width * imgHeight  ) / imgWidth;
            }
            if (width == 0) {
                width = (height * imgWidth) / imgHeight ;
            }
            Image scaledImage = img.getScaledInstance(width, height, Image.SCALE_SMOOTH);
            BufferedImage imageBuff = new BufferedImage(width, height, BufferedImage.TYPE_INT_RGB);
            imageBuff.getGraphics().drawImage(scaledImage, 0, 0, new Color(0, 0, 0), null);

            ByteArrayOutputStream buffer = new ByteArrayOutputStream();

            ImageIO.write(imageBuff, "jpg", buffer);

            return buffer.toByteArray();
        } catch (IOException e) {
            throw new Exception("IOException in scale");
        }
    }
}
