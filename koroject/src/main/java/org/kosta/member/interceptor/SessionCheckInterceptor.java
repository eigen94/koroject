package org.kosta.member.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class SessionCheckInterceptor extends HandlerInterceptorAdapter {

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
		//로그인 직전 세션을 체크 후 세션이 존재하면 메인페이지로 이동
		if(request.getSession().getAttribute("member")==null){
			response.sendRedirect("index");
			return false;
		}
		return true;
	};	
	
}
