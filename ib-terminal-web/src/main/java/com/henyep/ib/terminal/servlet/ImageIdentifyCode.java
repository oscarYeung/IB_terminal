package com.henyep.ib.terminal.servlet;

import java.awt.Color;
import java.awt.Font;
import java.awt.Graphics;
import java.awt.image.BufferedImage;
import java.io.IOException;
import java.util.Random;

import javax.imageio.ImageIO;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.henyep.ib.terminal.utils.RandomSymbol;



public class ImageIdentifyCode extends HttpServlet{
	
	 private static final long serialVersionUID = 1L;

	    private static Color getRandColor(int fc, int bc) {
	        Random random = new Random();
	        if (fc > 255) {
	            fc = 255;
	        }
	        if (bc > 255) {
	            bc = 255;
	        }
	        int r = fc + random.nextInt(bc - fc);
	        int g = fc + random.nextInt(bc - fc);
	        int b = fc + random.nextInt(bc - fc);
	        return new Color(r, g, b);
	    }

	    public void init() throws ServletException {
	    }

	    public void doPost(HttpServletRequest request, HttpServletResponse response)
	            throws ServletException {
	        doGet(request, response);
	    }

	    public void doGet(HttpServletRequest request, HttpServletResponse response)
	            throws ServletException {
	        response.setContentType("image/jpeg; charset=GBK");
	        response.setHeader("Pragma", "No-cache");
	        response.setHeader("Cache-Control", "no-cache");
	        response.setDateHeader("Expires", 0);
	        try {
	            int width = 70, height = 22;
	            BufferedImage image = new BufferedImage(width, height,
	                    BufferedImage.TYPE_INT_RGB);
	            Graphics g = image.getGraphics();
	            Random random = new Random();
	            g.setColor(getRandColor(245, 250));
	            g.fillRect(0, 0, width, height);
	            g.setFont(new Font("Arial", Font.PLAIN, 20));
	            g.setColor(getRandColor(150, 250));
	            for (int i = 0; i < 300; i++) {
	                int x = random.nextInt(width);
	                int y = random.nextInt(height);
	                int xl = random.nextInt(12);
	                int yl = random.nextInt(12);
	                g.drawLine(x, y, (x + xl), (y + yl));
	            }
	            String sRand = RandomSymbol.getPartSymbol(3);
	            for (int i = 0; i < sRand.length(); i++) {
	                g.setColor(new Color(10 + new Random().nextInt(100),
	                        10 + new Random().nextInt(100), 10 + new Random()
	                                .nextInt(100)));
	                if(i==0)
	                   g.drawString(" ", 1, 18);
	                g.drawString(sRand.substring(i, i + 1), (15 * i +9), 18);
	            }
	            request.getSession(true).setAttribute("imagesCode", sRand);
	            g.dispose();
	            ImageIO.write(image, "JPEG", response.getOutputStream());
	        } catch (IOException e) {
	           e.printStackTrace();
	        }
	    }

}
