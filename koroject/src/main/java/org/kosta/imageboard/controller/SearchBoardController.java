package org.kosta.imageboard.controller;

import java.util.List;

import javax.inject.Inject;

import org.kosta.imageboard.domain.ImageVO;
import org.kosta.imageboard.domain.ImgPageMaker;
import org.kosta.imageboard.domain.ImgSearchCriteria;
import org.kosta.imageboard.service.ImageService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping("/projectBoard/{p_id}/checklist/{check_id}/*")
public class SearchBoardController {

	private static final Logger logger = LoggerFactory.getLogger(SearchBoardController.class);
	
	@Inject
	private ImageService service;
	
	@RequestMapping(value="list", method= RequestMethod.GET)
	public String listPage(@ModelAttribute("cri")ImgSearchCriteria cri, Model model)throws Exception{
		System.out.println(cri.toString());
		
		//model.addAttribute("list", service.listCriteria(cri));
		model.addAttribute("list", service.listSearchCriteria(cri));
		
		ImgPageMaker pageMaker = new ImgPageMaker();
		pageMaker.setCri(cri);
		
		//pageMaker.setTotalCount(service.listCountCriteria(cri));
		pageMaker.setTotalCount(service.listSearchCount(cri));
		
		model.addAttribute("pageMaker", pageMaker);
		
		return "imagelist";
	}
	
	@RequestMapping(value="readPage", method=RequestMethod.GET)
	public String read(@RequestParam("img_bno")int img_bno,@ModelAttribute("cri") ImgSearchCriteria cri, Model model)throws Exception{
		
		model.addAttribute(service.read(img_bno));
		
		return "imageRead";
	}
	
	@RequestMapping(value="removePage", method=RequestMethod.POST)
	public String remove(@RequestParam("img_bno")int img_bno,ImgSearchCriteria cri, RedirectAttributes rttr)throws Exception{
		
		service.remove(img_bno);
		
		rttr.addAttribute("page",cri.getPage());
		rttr.addAttribute("perPageNum", cri.getPerPageNum());
		rttr.addAttribute("searchType", cri.getSearchType());
		rttr.addAttribute("keyword", cri.getKeyword());
		rttr.addFlashAttribute("msg", "SUCCESS");
		
		return "redirect:/imagee/list";
	}
	
	@RequestMapping(value="modifyPage", method=RequestMethod.GET)
	public String modifyGET(@RequestParam("img_bno") int img_bno, @ModelAttribute("cri")ImgSearchCriteria cri ,Model model)throws Exception{
		
		model.addAttribute(service.read(img_bno));
		
		return "imageModify";
	}
	
	@RequestMapping(value="modifyPage", method=RequestMethod.POST)
	public String modifyPOST(ImageVO vo, ImgSearchCriteria cri, RedirectAttributes rttr)throws Exception{
		
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
	
	@RequestMapping(value="register", method= RequestMethod.GET)
	public String registerGET()throws Exception{
		System.out.println("register get...");
		return "imageRegister";
	}
	
	@RequestMapping(value="register", method= RequestMethod.POST)
	public String registerPOST(ImageVO vo, RedirectAttributes rttr, @PathVariable int p_id, @PathVariable int check_id)throws Exception{
		System.out.println("register post...");
		System.out.println(vo.toString());
		
		service.regist(vo);
		
		rttr.addFlashAttribute("msg", "success");
		rttr.addFlashAttribute("p_id", p_id);
		return "redirect:/projectBoard/"+p_id+"/checklist/"+check_id+"/list";
//		return "image";
	}
	@RequestMapping("getAttach/{img_bno}")
	@ResponseBody
	public List<String> getAttach(@PathVariable("img_bno")Integer img_bno)throws Exception{
		return service.getAttach(img_bno);
	}
}
