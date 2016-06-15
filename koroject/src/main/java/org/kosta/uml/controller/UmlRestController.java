package org.kosta.uml.controller;

import java.util.HashMap;
import java.util.Map;

import javax.inject.Inject;

import org.kosta.uml.domain.JsonUml;
import org.kosta.uml.service.UmlService;

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
	public void save(int id, @RequestParam("jsonData") String jsonData) throws Exception
	{		
		Map<String, String> map = new HashMap<String, String>();
		map.put("check_id", Integer.toString(id));
		map.put("uml_content", jsonData);
		service.save(map);		
	}
	
	@ResponseBody
	@RequestMapping("load")
	public JsonUml load(int id)
	{
		JsonUml json = new JsonUml();
		json.setJsonData(service.load(id));		
		
		return json;		
	}
	
	
}
