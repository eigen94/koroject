package org.kosta.uml.test;

import static org.junit.Assert.fail;

import javax.inject.Inject;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.kosta.uml.persistence.UmlDao;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations={"file:src/main/webapp/WEB-INF/spring/**/*.xml"})
public class umlTest {

	@Inject
	private UmlDao dao;
	
	@Test
	/*public void testSave()throws Exception {
		dao.save("abcabc");
	}*/
	public void testLoad()throws Exception
	{
		System.out.println(dao.load(1));
	}

}
