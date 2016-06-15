package org.kosta.usecase.controller;

import java.util.HashMap;
import java.util.Map;

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
	@Inject	private UsecaseService service;

	@RequestMapping(value="save", method=RequestMethod.POST)
	public void save(int id, @RequestParam("jsonData") String jsonData) throws Exception
	{
		Map<String, String> map = new HashMap<String, String>();
		map.put("check_id", Integer.toString(id));
		map.put("usecase_content", jsonData);
		service.save(map);		
	}
	
	@ResponseBody
	@RequestMapping("load")
	public JsonUsecase load(int id)
	{
		JsonUsecase json = new JsonUsecase();
		json.setJsonData(service.load(id));		
		
		return json;		
	}
}
