package org.kosta.essence.controller;

import javax.inject.Inject;

import org.kosta.essence.service.EssenceService;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/projectBoard/{p_id}/essence/*")
public class EssenceRestController {

	@Inject
	private EssenceService service;
	
	@RequestMapping("insert")
	public String insert(@PathVariable("p_id") int p_id, String milestone){
		return service.insert(p_id, milestone);
	}
	
	@RequestMapping("load")
	public String load(@PathVariable("p_id") int p_id){
		String returnJson = service.load(p_id);
		if(returnJson==null){
			returnJson = "{}";
		}
		return returnJson;
	}
}
