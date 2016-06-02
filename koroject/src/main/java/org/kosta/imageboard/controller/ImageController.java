package org.kosta.imageboard.controller;

import javax.inject.Inject;

import org.kosta.imageboard.domain.imgCriteria;
import org.kosta.imageboard.domain.ImageVO;
import org.kosta.imageboard.domain.ImgPageMaker;
import org.kosta.imageboard.service.ImageService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping("/image/*")
public class ImageController {

	private static final Logger logger = LoggerFactory.getLogger(ImageController.class);
	
	@Inject
	private ImageService service;
	
	@RequestMapping(value="/register", method= RequestMethod.GET)
	public void registerGET(ImageVO vo, Model model)throws Exception{
		System.out.println("register get...");
	}
	
	@RequestMapping(value="/register", method= RequestMethod.POST)
	public String registerPOST(ImageVO vo, RedirectAttributes rttr)throws Exception{
		System.out.println("register post...");
		System.out.println(vo.toString());
		
		service.regist(vo);
		
		rttr.addFlashAttribute("msg", "success");
		
		//return "image/success";
		return "redirect:/image/listPage";
	}
	
	/*@RequestMapping(value="/listAll", method=RequestMethod.GET)
	public void listAll(Model model) throws Exception{
		System.out.println("show all list...!");
		model.addAttribute("list", service.listAll());
	}
	*/
	@RequestMapping(value="/listCri", method=RequestMethod.GET)
	public void listAll(imgCriteria cri, Model model)throws Exception{
		System.out.println("show list Page with Criteria........!!");
		
		model.addAttribute("list", service.listCriteria(cri));
	}
	
	@RequestMapping(value="/listPage", method=RequestMethod.GET)
	public void listPage(imgCriteria cri, Model model)throws Exception{
		System.out.println(cri.toString());
		
		model.addAttribute("list", service.listCriteria(cri));
		ImgPageMaker pageMaker = new ImgPageMaker();
		pageMaker.setCri(cri);
		//pageMaker.setTotalCount(123);
		
		pageMaker.setTotalCount(service.listCountCriteria(cri));
		
		model.addAttribute("pageMaker", pageMaker);
	}
	
	@RequestMapping(value="/readPage", method=RequestMethod.GET)
	public void read(@RequestParam("img_bno")int img_bno,@ModelAttribute("cri") imgCriteria cri, Model model)throws Exception{
		model.addAttribute(service.read(img_bno));
	}
	
	@RequestMapping(value="/removePage", method=RequestMethod.POST)
	public String remove(@RequestParam("img_bno")int img_bno,imgCriteria cri, RedirectAttributes rttr)throws Exception{
		
		service.remove(img_bno);
		
		rttr.addAttribute("page",cri.getPage());
		rttr.addAttribute("perPageNum", cri.getPerPageNum());
		rttr.addFlashAttribute("msg", "SUCCESS");
		
		return "redirect:/image/listPage";
	}
	
	@RequestMapping(value="/modifyPage", method=RequestMethod.GET)
	public void modifyGET(@RequestParam("img_bno") int img_bno, @ModelAttribute("cri")imgCriteria cri ,Model model)throws Exception{
		
		model.addAttribute(service.read(img_bno));
	}
	
	@RequestMapping(value="/modifyPage", method=RequestMethod.POST)
	public String modifyPOST(ImageVO vo, imgCriteria cri, RedirectAttributes rttr)throws Exception{
		
		service.modify(vo);
		
		rttr.addAttribute("page",cri.getPage());
		rttr.addAttribute("perPageNum", cri.getPerPageNum());
		rttr.addFlashAttribute("msg", "SUCCESS");
		
		return "redirect:/image/listPage";
	}
	
	
	
	
}