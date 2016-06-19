package org.kosta.useDes.test;

import static org.junit.Assert.*;

import java.util.HashMap;
import java.util.Map;

import javax.inject.Inject;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.kosta.usecaseDescription.persistence.UsecaseDescriptionDao;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations={"file:src/main/webapp/WEB-INF/spring/**/*.xml"})
public class useDesDaoTest {

	@Inject
	private UsecaseDescriptionDao dao;
	
	@Test
	public void test() {
		Map<String, String> map = new HashMap<String, String>();
		map.put("id", "84");
		map.put("content", "JUnit Test");
		dao.save(map);
		
	}

}
