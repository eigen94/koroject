package org.kosta.erd.controller;

import java.util.HashMap;
import java.util.Map;

import javax.inject.Inject;

import org.kosta.erd.domain.JsonErd;
import org.kosta.erd.service.ErdService;
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
	public void save(int id, @RequestParam("jsonData") String jsonData) throws Exception
	{
		Map<String, String> map = new HashMap<String, String>();
		map.put("check_id", Integer.toString(id));
		map.put("erd_content", jsonData);
		service.save(map);	
	}
	
	@ResponseBody
	@RequestMapping("load")
	public JsonErd load(int id)
	{
		JsonErd json = new JsonErd();
		json.setJsonData(service.load(id));		
		
		return json;		
	}
}
