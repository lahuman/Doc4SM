package kr.pe.lahuman.service.common;

import java.security.Principal;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class LoginController {

	@RequestMapping(value = "/login/form.do", method = RequestMethod.GET)
	public String loginForm(){
		return "login/form";
	}
	
	
	@RequestMapping(value = "/login/pop/form.do", method = RequestMethod.GET)
	public String loginPopForm(){
		return "login/popForm";
	}
	
	@RequestMapping(value = "/login/failed.do", method = RequestMethod.GET)
	public String failed(ModelMap model, HttpServletRequest request){
		model.addAttribute("error", "true");
		if(request.getHeader("Referer").indexOf("pop") != -1){
			return "redirect:/login/pop/form.do?errorMsg=LoginError"; 
		}
		return "login/form";
	}
	
	@RequestMapping(value = "/403.do", method = RequestMethod.GET)
	public String accessDeniedPage(ModelMap model){
		return "login/403";
	}
	
	
	@RequestMapping(value="/basics.do", method = RequestMethod.GET)
	public String printWelcome(ModelMap model, Principal principal, HttpServletRequest request ) {
		if(request.getHeader("Referer").indexOf("pop") != -1){
			return "redirect:common.do?close=true"; 
		}
//		
		if (request.isUserInRole("ROLE_ADMIN")) {
    		return "redirect:admin/main.do";
        }else{
        	return "redirect:common.do";
        }
	}
}
