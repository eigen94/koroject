package org.kosta.erd.controller;

import javax.inject.Inject;

import org.kosta.erd.domain.JsonErd;
import org.kosta.erd.service.ErdService;
import org.kosta.uml.domain.JsonUml;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/erd/*")
public class ErdRestController {

	@Inject
	private ErdService service;

	@RequestMapping(value="save", method=RequestMethod.POST)
	public void save(@RequestParam("jsonData") String jsonData) throws Exception
	{
		service.save(jsonData);		
	}
	
	@ResponseBody
	@RequestMapping("load")
	public JsonErd load()
	{
		JsonErd json = new JsonErd();
		json.setJsonData(service.load(1));		
		
		return json;		
	}
}
