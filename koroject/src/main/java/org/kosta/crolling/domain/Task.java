package org.kosta.crolling.domain;

import java.util.concurrent.Callable;

public class Task implements Callable<String> {
    
    private String uri;
    public Task(String uri) {
        this.uri = uri;
    }
 
    @Override
    public String call() throws Exception {
        return HttpUtils.toHtmlStr(uri);
    }
 
}