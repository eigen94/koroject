package org.kosta.uml.controller;

import javax.inject.Inject;

import org.kosta.uml.domain.JsonUml;
import org.kosta.uml.service.UmlService;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/uml/*")
public class UmlRestController {
	
	@Inject
	private UmlService service;

	@RequestMapping(value="save", method=RequestMethod.POST)
	public void save(@RequestParam("jsonData") String jsonData) throws Exception
	{
		service.save(jsonData);		
	}
	
	@ResponseBody
	@RequestMapping("load")
	public JsonUml load()
	{
		JsonUml json = new JsonUml();
		json.setJsonData(service.load(1));		
		
		return json;		
	}
}
