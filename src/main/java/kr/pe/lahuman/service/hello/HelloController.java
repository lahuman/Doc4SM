package kr.pe.lahuman.service.hello;

import java.security.Principal;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class HelloController {

	
	@Autowired
	private HelloService helloService;
	

    @RequestMapping(value = "/", method = RequestMethod.GET)
    @ResponseBody
    public String showIndex() throws Exception {
    	
        return "Hello world"+helloService.getList().size();
    }
    
    
    @RequestMapping(value = "/common.do", method = RequestMethod.GET)
    public String common(ModelMap model, Principal principal, HttpServletRequest request, HttpServletResponse response) throws Exception {
//    	Collection<SimpleGrantedAuthority> authorities = (Collection<SimpleGrantedAuthority>)    SecurityContextHolder.getContext().getAuthentication().getAuthorities();
    	
    	String name = principal.getName();
    	model.addAttribute("username", name);
    	model.addAttribute("message", "Spring Security Custom Form example");
    	return "commonPage";
    }
    
    @RequestMapping(value = "/admin/main.do", method = RequestMethod.GET)
    public String admin() throws Exception {
    	return "adminPage";
    }
    
    @RequestMapping(value = "/error/denied.do", method = RequestMethod.GET)
    public String denied() throws Exception {
    	return "error/denied";
    }
    
}
