package com.share.crm.web;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.share.crm.domain.Employee;
import com.share.crm.service.IEmployeeService;
import com.share.crm.util.AjaxResult;
import com.share.crm.util.UserContext;

/**登录
 * @author MrZhang 
 * @date 2018年5月25日 上午11:18:13
 * @version V1.0
 */
@Controller
@RequestMapping("/login")
public class LoginController {
	
	@Autowired
	private IEmployeeService employeeService;
	
	@RequestMapping(method=RequestMethod.POST)
	@ResponseBody
	public AjaxResult login(String username,String password,HttpSession httpSession){
		try {
			Employee loginUser = employeeService.login(username, password);
			UserContext.setLoginUser(loginUser, httpSession);
			return new AjaxResult();
		} catch (Exception e) {
			e.printStackTrace();
			return new AjaxResult(e.getMessage());
		}
	}
	@RequestMapping("/loginOut")
	@ResponseBody
	public ModelAndView loginOut(HttpSession session){
		UserContext.loginOut(session);
		return new ModelAndView("/login.jsp");
	}
}
