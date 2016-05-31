package org.kosta.member.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.kosta.member.domain.Member;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class MemberInterceptor extends HandlerInterceptorAdapter {

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
		//로그인 직전 세션을 체크 후 세션이 존재하면 메인페이지로 이동
		if(request.getSession().getAttribute("member")!=null){
			response.sendRedirect("insertMember2");
			return false;
		}
		return true;
	};
	
	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView mav){
		//로그인 후 세션 저장
		Member member = (Member)mav.getModel().get("member");
		if(member != null){
			request.getSession().setAttribute("member", member);
		}
	}

}
