package org.kosta.mongoDao;

import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.MongoTemplate;
 
public class MongoDao {
    
    private MongoTemplate mongoTemplate;
 
    public void setMongoTemplate(MongoTemplate mongoTemplate) {
        this.mongoTemplate = mongoTemplate;
    }
    
    public void insertTestVO(){
        TestVO testVO = new TestVO();
        testVO.setName("전성규");
        testVO.setJob("회사원");
        
        // person : collection 명
        mongoTemplate.insert(testVO, "person");
    }
    
    public class TestVO{
 
        @Id
        private String id;
        private String job;
        private String name;
        
        public String getJob() {
            return job;
        }
        public void setJob(String job) {
            this.job = job;
        }
        public String getName() {
            return name;
        }
        public void setName(String name) {
            this.name = name;
        }
    }
 
}
