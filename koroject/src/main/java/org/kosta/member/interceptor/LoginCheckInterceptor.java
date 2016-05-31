package org.kosta.member.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class LoginCheckInterceptor extends HandlerInterceptorAdapter{

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
		//로그인 페이지 접속시 세션을 체크하고 세션이 존재하면 로그인된 페이지로 이동
		if(request.getSession().getAttribute("member")!=null){
			response.sendRedirect("loginMember");
			return false;
		}
		return true;
	};
}
