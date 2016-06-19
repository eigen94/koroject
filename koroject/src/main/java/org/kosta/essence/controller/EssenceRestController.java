package org.kosta.essence.controller;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.Map;

import javax.inject.Inject;

import org.kosta.essence.service.EssenceService;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/projectBoard/{p_id}/essence/*")
public class EssenceRestController {

	@Inject
	private EssenceService service;
	
	@RequestMapping("insert")
	public void insert(@PathVariable("p_id") int p_id, String milestone){
		Map<String, String> map = new HashMap<String, String>();
		map.put("id", Integer.toString(p_id));
		map.put("content", milestone);
		service.update(map);	
	}
	
	@RequestMapping(value="load", method=RequestMethod.POST)
	public String load(@PathVariable("p_id") int p_id){
		String returnJson = service.load(p_id);
		System.out.println(" load : "+returnJson);
		try {
			returnJson = URLEncoder.encode(returnJson, "UTF-8");
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		if(returnJson==null){
			returnJson = "{}";
		}
		return returnJson;
	}
}
