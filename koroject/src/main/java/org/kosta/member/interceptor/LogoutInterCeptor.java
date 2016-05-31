package org.kosta.member.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class LogoutInterCeptor extends HandlerInterceptorAdapter{

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
		//로그아웃 할때 세션을 체크 후 세션이 존재하면 삭제
		if(request.getSession().getAttribute("member")!=null){
			request.getSession().removeAttribute("member");
			return true;
		}
		response.sendRedirect("index");
		return false;
	};
}
