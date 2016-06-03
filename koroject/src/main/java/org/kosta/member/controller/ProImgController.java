package org.kosta.member.controller;

import java.io.File;
import java.io.IOException;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.kosta.member.domain.ImageUtill;
import org.kosta.member.domain.Member;
import org.kosta.member.service.MemberService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;

@Controller
public class ProImgController {

	private static final Logger logger = LoggerFactory.getLogger(ProImgController.class);
	
	@Inject
	private MemberService service;

	@Autowired
	public void setService(MemberService service) {
		this.service = service;
	}
	
	@RequestMapping(value="proImg", method = RequestMethod.POST)
	public void upload(MultipartFile file, Model model,HttpServletRequest request) throws IOException{
		
		System.out.println("-----------------");
		System.out.println("originalName: " + file.getOriginalFilename());
		  String filename = file.getOriginalFilename();      //업로드 파일 이름 받음
		  		String path = "C:/Intel";
	         File tempfile =new File(path, file.getOriginalFilename());   //파일 생성후 

	         if(tempfile.exists() && tempfile.isFile()){   // 이미 존재하는 파일일경우 현재시간을 가져와서 리네임

	            filename =System.currentTimeMillis()  +"_"+ file.getOriginalFilename() ;

	            tempfile = new File(path,filename);   //리네임된 파일이름으로 재생성

	         }
	         file.transferTo(tempfile);

	         Member member = (Member) request.getSession().getAttribute("member"); 
	         System.out.println(member.getM_id());
	            // 업로드 디렉토리로 파일 이동
	         
	            //이미지 리사이즈
	            String imgePath = path+"/"+filename;
	            File src  = new File(imgePath);
	            String headName = filename.substring(0, filename.lastIndexOf("."));
	            String pattern = filename.substring(filename.lastIndexOf(".")+1);
	            String reImagePath = path+"_resize."+pattern;
	            File dest = new File(reImagePath);
	         
	            ImageUtill.resize(src, dest, 100, ImageUtill.RATIO);


	            member.setM_image(filename);   // 업로드된 파일이름 등록

	}
}
