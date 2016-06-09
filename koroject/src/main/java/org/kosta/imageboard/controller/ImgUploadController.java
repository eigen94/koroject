package org.kosta.imageboard.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;
import java.util.UUID;

import javax.annotation.Resource;
import javax.servlet.ServletRequest;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.io.IOUtils;
import org.kosta.imageboard.util.ImgMediaUtils;
import org.kosta.imageboard.util.ImgUploadFileUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;


@Controller
@RequestMapping("/projectBoard/{p_id}/checklist/{check_id}/*")
public class ImgUploadController {

  private static final Logger logger = LoggerFactory.getLogger(ImgUploadController.class);
  
  //@Resource(name = "uploadPath")
//  private String uploadPath = "C:\\Users\\Ryu\\Pictures\\Screenshots";
//  private String uploadPath = "http://dinky.iptime.org:10000/";

  @RequestMapping(value = "uploadForm", method = RequestMethod.GET)
  public void uploadForm() {
	
  } 

 
  @RequestMapping(value = "uploadForm", method = RequestMethod.POST)
  public String uploadForm(MultipartFile file, Model model, HttpServletRequest req) throws Exception {
	  System.out.println("originalName: " + file.getOriginalFilename());
	  System.out.println("size: " + file.getSize());
	  System.out.println("contentType: " + file.getContentType());
	  String uploadPath = req.getSession().getServletContext().getRealPath("/uploadImage");
    String savedName = uploadFile(file.getOriginalFilename(), file.getBytes(), uploadPath);

    model.addAttribute("savedName", uploadPath+savedName);

    return "uploadResult";
  }
  
  private String uploadFile(String originalName, byte[] fileData, String uploadPath) throws Exception {

	    UUID uid = UUID.randomUUID();

	    String savedName = uid.toString() + "_" + originalName;

	    File target = new File(uploadPath, savedName);

	    FileCopyUtils.copy(fileData, target);

	    return savedName;

	  }
  
  @RequestMapping(value = "uploadAjax", method = RequestMethod.GET)
  public void uploadAjax() {
  }

 
  @ResponseBody
  @RequestMapping(value ="register/uploadAjax", method=RequestMethod.POST, 
                  produces = "text/plain;charset=UTF-8")
  public ResponseEntity<String> uploadAjax(MultipartFile file, HttpServletRequest req)throws Exception{
	  
    logger.info("originalName: " + file.getOriginalFilename());
    String uploadPath = req.getSession().getServletContext().getRealPath("/uploadImage");
    //return new ResponseEntity<>(file.getOriginalFilename(), HttpStatus.CREATED);
    System.out.println("file : "+file);
   System.out.println("uploadPath : "+uploadPath);
   return 
      new ResponseEntity<>(
          ImgUploadFileUtils.uploadFile(uploadPath, 
                file.getOriginalFilename(), 
                file.getBytes()), 
          HttpStatus.CREATED);
  }
  
 
    
  @ResponseBody
  @RequestMapping("register/displayFile")
  public ResponseEntity<byte[]>  displayFile(String fileName, HttpServletRequest req)throws Exception{
    
    InputStream in = null; 
    ResponseEntity<byte[]> entity = null;
    
    logger.info("FILE NAME: " + fileName);
    
    try{
      
    	String uploadPath = req.getSession().getServletContext().getRealPath("/uploadImage");
    	
      String formatName = fileName.substring(fileName.lastIndexOf(".")+1);
      
      MediaType mType = ImgMediaUtils.getMediaType(formatName);
      
      HttpHeaders headers = new HttpHeaders();
      
      in = new FileInputStream(uploadPath+fileName);
      
      if(mType != null){
        headers.setContentType(mType);
      }else{
        
        fileName = fileName.substring(fileName.indexOf("_")+1);       
        headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);
        headers.add("Content-Disposition", "attachment; filename=\""+ 
          new String(fileName.getBytes("UTF-8"), "ISO-8859-1")+"\"");
      }

        entity = new ResponseEntity<byte[]>(IOUtils.toByteArray(in), 
          headers, 
          HttpStatus.CREATED);
    }catch(Exception e){
      e.printStackTrace();
      entity = new ResponseEntity<byte[]>(HttpStatus.BAD_REQUEST);
    }finally{
      in.close();
    }
      return entity;    
  }

  @ResponseBody
  @RequestMapping(value="deleteFile", method=RequestMethod.POST)
  public ResponseEntity<String> deleteFile(String fileName, HttpServletRequest req){
    
    logger.info("delete file: "+ fileName);
    
    String formatName = fileName.substring(fileName.lastIndexOf(".")+1);
    
    String uploadPath = req.getSession().getServletContext().getRealPath("/uploadImage");
    
    MediaType mType = ImgMediaUtils.getMediaType(formatName);
    
    if(mType != null){      
      
      String front = fileName.substring(0,12);
      String end = fileName.substring(14);
      new File(uploadPath + (front+end).replace('/', File.separatorChar)).delete();
    }
    
    new File(uploadPath + fileName.replace('/', File.separatorChar)).delete();
    
    
    return new ResponseEntity<String>("deleted", HttpStatus.OK);
  }  
  
  /*
  @ResponseBody
  @RequestMapping(value="/deleteAllFiles", method=RequestMethod.POST)
  public ResponseEntity<String> deleteFile(@RequestParam("files[]") String[] files){
    
    logger.info("delete all files: "+ files);
    
    if(files == null || files.length == 0) {
      return new ResponseEntity<String>("deleted", HttpStatus.OK);
    }
    
    for (String fileName : files) {
      String formatName = fileName.substring(fileName.lastIndexOf(".")+1);
      
      MediaType mType = MediaUtils.getMediaType(formatName);
      
      if(mType != null){      
        
        String front = fileName.substring(0,12);
        String end = fileName.substring(14);
        new File(uploadPath + (front+end).replace('/', File.separatorChar)).delete();
      }
      
      new File(uploadPath + fileName.replace('/', File.separatorChar)).delete();
      
    }
    return new ResponseEntity<String>("deleted", HttpStatus.OK);
  }  */

}
  
  
  
  
//  @ResponseBody
//  @RequestMapping(value = "/uploadAjax", 
//                 method = RequestMethod.POST, 
//                 produces = "text/plain;charset=UTF-8")
//  public ResponseEntity<String> uploadAjax(MultipartFile file) throws Exception {
//
//    logger.info("originalName: " + file.getOriginalFilename());
//    logger.info("size: " + file.getSize());
//    logger.info("contentType: " + file.getContentType());
//
//    return 
//        new ResponseEntity<>(file.getOriginalFilename(), HttpStatus.CREATED);
//  }

// @RequestMapping(value = "/uploadForm", method = RequestMethod.POST)
// public void uploadForm(MultipartFile file, Model model) throws Exception {
//
// logger.info("originalName: " + file.getOriginalFilename());
// logger.info("size: " + file.getSize());
// logger.info("contentType: " + file.getContentType());
//
// String savedName = uploadFile(file.getOriginalFilename(), file.getBytes());
//
// model.addAttribute("savedName", savedName);
//
// }
//
// private String uploadFile(String originalName, byte[] fileData)throws
// Exception{
//
// UUID uid = UUID.randomUUID();
//
// String savedName = uid.toString() + "_"+ originalName;
//
// File target = new File(uploadPath,savedName);
//
// FileCopyUtils.copy(fileData, target);
//
// return savedName;
//
// }