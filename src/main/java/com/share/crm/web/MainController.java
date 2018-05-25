package com.share.crm.web;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

/**跳转主页
 * @author MrZhang 
 * @date 2018年5月17日 下午5:50:10
 * @version V1.0
 */
@Controller
@RequestMapping("/main")
public class MainController {
	
	Logger logger = LoggerFactory.getLogger(getClass());
	
	@RequestMapping("/index")
	public String main(){
		return "main";
	}
}
