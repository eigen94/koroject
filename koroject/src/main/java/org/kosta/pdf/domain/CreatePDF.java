package org.kosta.pdf.domain;

import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.net.MalformedURLException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;

import com.itextpdf.text.Document;
import com.itextpdf.text.DocumentException;
import com.itextpdf.text.Element;
import com.itextpdf.text.Font;
import com.itextpdf.text.Image;
import com.itextpdf.text.Paragraph;
import com.itextpdf.text.Phrase;
import com.itextpdf.text.pdf.PdfPCell;
import com.itextpdf.text.pdf.PdfPTable;
import com.itextpdf.text.pdf.PdfWriter;

public class CreatePDF {
	private static Font TIME_ROMAN = new Font(Font.FontFamily.TIMES_ROMAN, 18,Font.BOLD);
	private static Font TIME_ROMAN_SMALL = new Font(Font.FontFamily.TIMES_ROMAN, 12, Font.BOLD);
	/**
	 * @param args
	 */
	public static Document createPDF(String file,HttpServletRequest req)throws Exception {
 
		Document document = null;
 
		try {
			//com.itextpdf.text.Document 클래스 인스턴스를 생성
			document = new Document();
			
			//Writer 와 Document 사이의 연관을 맺어줌. Writer를 이용하여 문서를 하드디스크 상에 써넣을 수 있다.
			PdfWriter.getInstance(document, new FileOutputStream(file));
			
			//문서를 오픈
			document.open();
		
			
			//문서에 내용 첨부
	//		addMetaData(document);
			addTitlePage(document);
			addImageData(document, req);
			createTable(document);
			
			//문서를 닫음
			document.close();
 
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (DocumentException e) {
			e.printStackTrace();
		} 
		return document; //createTable(document);
 
	}
	//내용 첨부 메소드 0
		private static void addImageData(Document document,HttpServletRequest req) throws DocumentException, MalformedURLException, IOException{
			String uploadPath = req.getSession().getServletContext().getRealPath("/");
			System.out.println("uploadPath"+ uploadPath.toString());
		
			Image img = Image.getInstance(uploadPath + "images\\banner.jpg");
				
			//img.scaleAbsolute(PageSize.A4.getHeight()*(float)0.9, PageSize.A4.getWidth()*(float)0.9);
			img.scaleAbsolute(530, 300);
			img.setAlignment(img.MIDDLE);
			document.add(img);
			
		}
	//내용 첨부 메소드 1
	/*private static void addMetaData(Document document) {
		document.addTitle("Generate PDF report");
		document.addSubject("Generate PDF report");
		document.addAuthor("Java Ryu");
		document.addCreator("Java Ryu");
	}*/
	//내용 첨부 메소드 2 
	private static void addTitlePage(Document document) throws DocumentException {
 
		Paragraph preface = new Paragraph();
		creteEmptyLine(preface, 1);
		preface.add(new Paragraph("PDF Report", TIME_ROMAN));
 
		creteEmptyLine(preface, 1);
		SimpleDateFormat simpleDateFormat = new SimpleDateFormat("MM/dd/yyyy");
		preface.add(new Paragraph("Report created on "
				+ simpleDateFormat.format(new Date()), TIME_ROMAN_SMALL));
		document.add(preface);
 
	}

	private static void creteEmptyLine(Paragraph paragraph, int number) {
		for (int i = 0; i < number; i++) {
			paragraph.add(new Paragraph(" "));
		}
	}
	
	private static void createTable(Document document) throws DocumentException {
		Paragraph paragraph = new Paragraph();
		creteEmptyLine(paragraph, 2);
		document.add(paragraph);
		PdfPTable table = new PdfPTable(3);
 
		PdfPCell c1 = new PdfPCell(new Phrase("First Name"));
		c1.setHorizontalAlignment(Element.ALIGN_CENTER);
		table.addCell(c1);
 
		c1 = new PdfPCell(new Phrase("Last Name"));
		c1.setHorizontalAlignment(Element.ALIGN_CENTER);
		table.addCell(c1);
 
		c1 = new PdfPCell(new Phrase("Test"));
		c1.setHorizontalAlignment(Element.ALIGN_CENTER);
		table.addCell(c1);
		table.setHeaderRows(1);
 
		for (int i = 0; i < 5; i++) {
			table.setWidthPercentage(100);
			table.getDefaultCell().setHorizontalAlignment(Element.ALIGN_CENTER);
			table.getDefaultCell().setVerticalAlignment(Element.ALIGN_MIDDLE);
			table.addCell("Java");
			table.addCell("Ryu");
			table.addCell("Success");
		}
 
		document.add(table);
	}
		
}

