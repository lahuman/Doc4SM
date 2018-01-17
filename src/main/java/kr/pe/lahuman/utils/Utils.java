package kr.pe.lahuman.utils;

import javax.servlet.http.HttpServletRequest;

import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;

public class Utils {

	private Utils(){};
	
	public static DataMap<String, Object> makePagingMap(HttpServletRequest request) {
		DataMap<String, Object> paramMap = new DataMap<String, Object>();
		paramMap.put("page", String.valueOf(Integer.parseInt(request.getParameter("page"))));
		paramMap.put("rows", String.valueOf(Integer.parseInt(request.getParameter("rows"))));
		paramMap.put("offset", String.valueOf(((paramMap.getInt("page", 1)==0?1:paramMap.getInt("page", 1))-1)*paramMap.getInt("rows", 10)));
		return paramMap;
	}
	
	public static String getLoginUserName() {
		String username = "";
		if(SecurityContextHolder.getContext().getAuthentication() != null ){
			Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
			if ( principal instanceof UserDetails) {
				username = ((UserDetails)principal).getUsername();
			} 
		}
		return username;
	}
	
	public static String getRequestValue(String value){
		if(value == null){
			return "";
		}
		return value;
	}
}
