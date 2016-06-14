package org.kosta.usecaseDescription.controller;

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
	@Inject	private UsecaseDescriptionService service;

	@RequestMapping(value="save", method=RequestMethod.POST)
	public void save(@RequestParam("jsonData") String jsonData) throws Exception
	{
		service.save(jsonData);		
	}
	
	@ResponseBody
	@RequestMapping("load")
	public JsonUsecaseDescription load()
	{
		JsonUsecaseDescription json = new JsonUsecaseDescription();
		json.setJsonData(service.load(1));		
		
		return json;		
	}
}
