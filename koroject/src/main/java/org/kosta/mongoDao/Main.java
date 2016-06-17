package org.kosta.mongoDao;

import org.springframework.context.support.GenericXmlApplicationContext;
 
public class Main {
    public static void main(String[] args){
        
        String url = "mongoContext.xml";
        
        GenericXmlApplicationContext ctx = new GenericXmlApplicationContext(url);
        
        MongoDao dao = ctx.getBean("mongoDao", MongoDao.class);
        if(dao == null){
            System.out.println("NULL!!");
        }
        else{
            System.out.println("Not NULL!!");
            
            dao.insertTestVO();
        }    
    }
}