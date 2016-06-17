package org.kosta.pdf.controller;

import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
 
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.kosta.pdf.domain.CreatePDF;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

 

@Controller
public class PdfController {

	@RequestMapping(value = "/downloadPDF2")
	public String indexPDF(){
		return "/pdf/pdfIndex";
	}
	
	@RequestMapping(value = "/downloadPDF")
	public void downloadPDF(HttpServletRequest request, HttpServletResponse response) throws IOException {
 
		final ServletContext servletContext = request.getSession().getServletContext();
	    final File tempDirectory = (File) servletContext.getAttribute("javax.servlet.context.tempdir");
	    final String temperotyFilePath = tempDirectory.getAbsolutePath();
 
	    String fileName = "total.pdf";
	    response.setContentType("application/pdf");
	    response.setHeader("Content-disposition", "attachment; fileName="+ fileName);
 
	    try {
	    	System.out.println("temperotyFilePath :" + temperotyFilePath.toString() +"\\" + fileName);
	    	System.out.println(servletContext);
	        CreatePDF.createPDF(temperotyFilePath+"\\"+fileName, request);
	        ByteArrayOutputStream baos = new ByteArrayOutputStream();
	        baos = convertPDFToByteArrayOutputStream(temperotyFilePath+"\\"+fileName);
	        OutputStream os = response.getOutputStream();
	        baos.writeTo(os);
	        os.flush();
	    } catch (Exception e1) {
	        e1.printStackTrace();
	    }
 
	}
	
	private ByteArrayOutputStream convertPDFToByteArrayOutputStream(String fileName) {
 
		InputStream inputStream = null;
		ByteArrayOutputStream baos = new ByteArrayOutputStream();
		try {
 
			inputStream = new FileInputStream(fileName);
			byte[] buffer = new byte[1024];
			baos = new ByteArrayOutputStream();
 
			int bytesRead;
			while ((bytesRead = inputStream.read(buffer)) != -1) {
				baos.write(buffer, 0, bytesRead);
			}
 
		} catch (FileNotFoundException e1) {
			e1.printStackTrace();
		} catch (IOException e2) {
			e2.printStackTrace();
		} finally {
			if (inputStream != null) {
				try {
					inputStream.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}
		return baos;
	}
 
}