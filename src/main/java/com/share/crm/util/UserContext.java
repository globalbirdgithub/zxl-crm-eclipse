package com.share.crm.util;

import javax.servlet.http.HttpSession;
import com.share.crm.domain.Employee;

/**用户上下文
 * @author MrZhang 
 * @date 2018年5月26日 上午12:50:48
 * @version V1.0
 */
public class UserContext {
	public static final String LOGIN_USER = "loginUser";
	
	public static void setLoginUser(Employee employee,HttpSession session){
		session.setAttribute(LOGIN_USER, employee);
	}
	public static Employee getLoginUser(HttpSession session){
		return (Employee)session.getAttribute(LOGIN_USER);
	}
	public static void loginOut(HttpSession session){
		session.removeAttribute(LOGIN_USER);
	}
}
