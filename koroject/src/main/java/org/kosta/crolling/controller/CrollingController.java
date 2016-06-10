package org.kosta.crolling.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.Future;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import org.kosta.crolling.domain.Task;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class CrollingController {
	
	@RequestMapping(value="croll")
	public List<String> aa() throws Exception{
		
		 ExecutorService es = Executors.newCachedThreadPool();
	        List<String> htmls = new ArrayList<>();
	        List<String> list = new ArrayList<String>();
	        List<Task> tasks = new ArrayList<>();
	        //주소 받아오는곳
	        tasks.add(new Task("http://www.itnews.or.kr/?cat=1162"));
	       /* for (int i = 1; i <= 9; i++) {
	            tasks.add(new Task("http://www.billboard.com/charts/hot-100?page=" + i));
	        }*/
	        
	        //받아온 주소의 html을 가저오는곳
	        List<Future<String>> futures = es.invokeAll(tasks);
	        for (Future<String> future : futures) {
	            htmls.add(future.get());
	        }
	       
	      
	       
	        Elements elements = new Elements();
	        String s="";
	        for (String html : htmls) {
	             
	            /**
	             * jsoup 으로 문서를 파싱 하여 Document 를 생성
	             */
	            Document doc = Jsoup.parse(html);
	             
	            /**
	             * DOM traversal, CSS selectors 방식으로 엘레멘트를 찾을 수 있다.
	             * id 가 content 인 div 내의 article 엘레멘트의 header 들을 가져오도록 한다.
	             */
	            //제목 가져오는 소스
	           // elements = doc.select("div.td-module-thumb");
	            /*for(int i=0;i<elements.size();i++){
	            	System.out.println("---------------------"+i+"----------------------");
	            	System.out.println(elements.get(i).html());
	            }*/
	            
	            //제목 가져오기 소스
	            elements = doc.select("div.item-details");
	           
	            for(int i=0;i<elements.size();i++){
	            	System.out.println("---------------------"+i+"----------------------");
	            	System.out.println(elements.get(i).child(0).html());
	            	list.add(elements.get(i).child(0).html());
	            }
	            
	        } 
	        es.shutdown();
	    	
	        return list;
	    }
	@RequestMapping(value="news")
	public List<String> news(@RequestParam("href") String href )throws Exception{
		
		ExecutorService es = Executors.newCachedThreadPool();
	    List<String> htmls = new ArrayList<>();
	    List<String> list = new ArrayList<String>();
		List<Task> tasks = new ArrayList<>();
		String[] array;
	    //주소 받아오는곳
		tasks.add(new Task(href));
		
		//뉴스 아이디 갖고오기
		String[] hrefId = href.split("p=");
		System.out.println(hrefId[1]);
		
		
	    List<Future<String>> futures = es.invokeAll(tasks);
        for (Future<String> future : futures) {
            htmls.add(future.get());
        }
        
        Elements elements = new Elements();
        String s="";
        for (String html : htmls) {
          
            Document doc = Jsoup.parse(html);
  
            
            //제목 가져오기 소스
            elements = doc.select("#post-"+hrefId[1]);
            Element e = elements.get(0);
            /*System.out.println(e.child(2));*/
           array = e.child(2).html().split("</p>");
           for(int i = 0; i<array.length; i++){
        	  
        	   list.add(array[i]+"</p>");
           }
            
         /*   for(int i=0;i<elements.size();i++){
            	System.out.println("---------------------"+i+"----------------------");
            	System.out.println(elements.get(i).child(0).html());
            	list.add(elements.get(i).child(0).html());
            }*/
            
        }
        es.shutdown();
		return list;
	}
}