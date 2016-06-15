package org.kosta.usecaseDescription.controller;

import java.util.HashMap;
import java.util.Map;

import javax.inject.Inject;

import org.kosta.usecaseDescription.domain.JsonUsecaseDescription;
import org.kosta.usecaseDescription.service.UsecaseDescriptionService;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/usecaseDescription/*")
public class UsecaseDescriptionRestController {
	@Inject
	private UsecaseDescriptionService service;

	@RequestMapping(value="save", method=RequestMethod.POST)
	public void save(int id, @RequestParam("jsonData") String jsonData) throws Exception
	{
		Map<String, String> map = new HashMap<String, String>();
		map.put("check_id", Integer.toString(id));
		map.put("usecaseDescription_content", jsonData);
		service.save(map);			
	}
	
	@ResponseBody
	@RequestMapping("load")
	public JsonUsecaseDescription load(int id)
	{
		JsonUsecaseDescription json = new JsonUsecaseDescription();
		json.setJsonData(service.load(id));		
		
		return json;		
	}
}
