package org.kosta.usecase.controller;

import javax.inject.Inject;

import org.kosta.usecase.domain.JsonUsecase;
import org.kosta.usecase.service.UsecaseService;
import org.kosta.usecaseDescription.domain.JsonUsecaseDescription;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/usecase/*")
public class UsecaseRestController {
	@Inject
	private UsecaseService service;

	@RequestMapping(value="save", method=RequestMethod.POST)
	public void save(@RequestParam("jsonData") String jsonData) throws Exception
	{
		service.save(jsonData);		
	}
	
	@ResponseBody
	@RequestMapping("load")
	public JsonUsecase load()
	{
		JsonUsecase json = new JsonUsecase();
		json.setJsonData(service.load(1));		
		
		return json;		
	}
}
