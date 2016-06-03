package org.kosta.note.domain;

import org.springframework.web.util.UriComponents;
import org.springframework.web.util.UriComponentsBuilder;

public class NotePageMaker {

  private int totalCount;
  private int startPage;
  private int endPage;
  private boolean prev;
  private boolean next;

  private int displayPageNum = 5;

  private NoteSearchCriteria cri;

  public void setCri(NoteSearchCriteria cri) {
    this.cri = cri;
  }

  public void setTotalCount(int totalCount) {
    this.totalCount = totalCount;
  }

  public int getTotalCount() {
    return totalCount;
  }

  public int getStartPage() {
    return startPage;
  }

  public int getEndPage() {
    return endPage;
  }

  public boolean isPrev() {
    return prev;
  }

  public boolean isNext() {
    return next;
  }

  public int getDisplayPageNum() {
    return displayPageNum;
  }


  public String makeQuery(int page) {

    UriComponents uriComponents = UriComponentsBuilder.newInstance()
    		.queryParam("page", page)
    		.build();

    return uriComponents.toUriString();
  }
  
  
 public String makeSearch(int page){
    
    UriComponents uriComponents =
              UriComponentsBuilder.newInstance()
              .queryParam("page", page)
              .queryParam("searchType", ((NoteSearchCriteria)cri).getSearchType())
              .queryParam("keyword", ((NoteSearchCriteria)cri).getKeyword())
              .build();  
    
    return uriComponents.toUriString();
  } 
}








