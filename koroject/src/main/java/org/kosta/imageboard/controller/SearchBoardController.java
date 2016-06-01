package org.kosta.imageboard.controller;

import javax.inject.Inject;

import org.kosta.imageboard.domain.Criteria;
import org.kosta.imageboard.domain.ImageVO;
import org.kosta.imageboard.domain.PageMaker;
import org.kosta.imageboard.domain.SearchCriteria;
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
@RequestMapping("/imagee/*")
public class SearchBoardController {

	private static final Logger logger = LoggerFactory.getLogger(SearchBoardController.class);
	
	@Inject
	private ImageService service;
	
	@RequestMapping(value="/list", method= RequestMethod.GET)
	public void listPage(@ModelAttribute("cri")SearchCriteria cri, Model model)throws Exception{
		System.out.println(cri.toString());
		
		//model.addAttribute("list", service.listCriteria(cri));
		model.addAttribute("list", service.listSearchCriteria(cri));
		
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		
		//pageMaker.setTotalCount(service.listCountCriteria(cri));
		pageMaker.setTotalCount(service.listSearchCount(cri));
		
		model.addAttribute("pageMaker", pageMaker);
	}
	
	@RequestMapping(value="/readPage", method=RequestMethod.GET)
	public void read(@RequestParam("img_bno")int img_bno,@ModelAttribute("cri") SearchCriteria cri, Model model)throws Exception{
		
		model.addAttribute(service.read(img_bno));
		
	}
	
	@RequestMapping(value="/removePage", method=RequestMethod.POST)
	public String remove(@RequestParam("img_bno")int img_bno,SearchCriteria cri, RedirectAttributes rttr)throws Exception{
		
		service.remove(img_bno);
		
		rttr.addAttribute("page",cri.getPage());
		rttr.addAttribute("perPageNum", cri.getPerPageNum());
		rttr.addAttribute("searchType", cri.getSearchType());
		rttr.addAttribute("keyword", cri.getKeyword());
		rttr.addFlashAttribute("msg", "SUCCESS");
		
		return "redirect:/imagee/list";
	}
	
	@RequestMapping(value="/modifyPage", method=RequestMethod.GET)
	public void modifyGET(@RequestParam("img_bno") int img_bno, @ModelAttribute("cri")SearchCriteria cri ,Model model)throws Exception{
		
		model.addAttribute(service.read(img_bno));
	}
	
	@RequestMapping(value="/modifyPage", method=RequestMethod.POST)
	public String modifyPOST(ImageVO vo, SearchCriteria cri, RedirectAttributes rttr)throws Exception{
		
		System.out.println(cri.toString());
		service.modify(vo);
		
		rttr.addAttribute("page",cri.getPage());
		rttr.addAttribute("perPageNum", cri.getPerPageNum());
		rttr.addAttribute("searchType", cri.getSearchType());
		rttr.addAttribute("keyword", cri.getKeyword());
		rttr.addFlashAttribute("msg", "SUCCESS");
		
		System.out.println(rttr.toString());
		
		return "redirect:/imagee/list";
	}
	
	@RequestMapping(value="/register", method= RequestMethod.GET)
	public void registerGET()throws Exception{
		System.out.println("register get...");
	}
	
	@RequestMapping(value="/register", method= RequestMethod.POST)
	public String registerPOST(ImageVO vo, RedirectAttributes rttr)throws Exception{
		System.out.println("register post...");
		System.out.println(vo.toString());
		
		service.regist(vo);
		
		rttr.addFlashAttribute("msg", "success");
		
		//return "image/success";
		return "redirect:/imagee/list";
	}
}
