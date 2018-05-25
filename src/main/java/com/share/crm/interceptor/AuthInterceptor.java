package com.share.crm.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import com.share.crm.domain.Employee;
import com.share.crm.util.UserContext;

/**登录拦截器
 * @author MrZhang 
 * @date 2018年5月26日 上午12:16:20
 * @version V1.0
 */
public class AuthInterceptor implements HandlerInterceptor{

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		//排除拦截
		String requestURI = request.getRequestURI();
		if(requestURI.endsWith("/login") || requestURI.endsWith("/loginOut")){
			return true;
		}
		//登录拦截
		Employee loginUser = UserContext.getLoginUser(request.getSession());
		if(loginUser==null){
			response.sendRedirect("/login.jsp");
		}
		//权限拦截
		return true;
	}

	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
	}

	@Override
	public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex)
			throws Exception {
		
	}

	
}
