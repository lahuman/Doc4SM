package kr.pe.lahuman.config.security;

import java.util.ArrayList;
import java.util.Collection;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.PostConstruct;

import kr.pe.lahuman.service.common.SecuritySupportDao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.ConfigAttribute;
import org.springframework.security.access.SecurityConfig;
import org.springframework.security.web.util.matcher.AntPathRequestMatcher;
import org.springframework.security.web.util.matcher.RegexRequestMatcher;
import org.springframework.security.web.util.matcher.RequestMatcher;
import org.springframework.stereotype.Component;
@Component
public class UrlResourceManager {

	
	@PostConstruct
	public void reloadData(){
		authDataSetting();
	}
	
	private SecuritySupportDao securitySupportDao;

	
	@Autowired
	public void setSqlSession(SqlSession sqlSession){
		// 이부분에서 이렇게 사용 하였으나, 다른 방법도 있음
		this.securitySupportDao = sqlSession.getMapper(kr.pe.lahuman.service.common.SecuritySupportDao.class);
	}
	
	private static Map<RequestMatcher, Collection<ConfigAttribute>> requestMap = null;
	private static Map<String, RequestMatcher> urlMap = null;
	private static List<Map<String, String>> menuMap = null;

	public static List<Map<String, String>> getMenuMap() {
		return menuMap;
	}
	
	public void authDataSetting() {
		
		requestMap = new LinkedHashMap<RequestMatcher, Collection<ConfigAttribute>>();
		urlMap = new LinkedHashMap<String, RequestMatcher>();
		try {
			List<Map<String, Object>> urlNRole = securitySupportDao
					.getUrlNRole();
			for (Map<String, Object> data : urlNRole) {

				SecurityConfig sc = new SecurityConfig(String.valueOf(data.get("name")));

				
				if (urlMap.containsKey(data.get("url_path"))) {
					
						
					requestMap.get(urlMap.get(data.get("url_path"))).add(
							sc);
				} else {
					List<ConfigAttribute> attributes = new ArrayList<ConfigAttribute>();
					attributes.add(sc);
					AntPathRequestMatcher r = new AntPathRequestMatcher(
							String.valueOf(data.get("url_path")));
					urlMap.put(String.valueOf(data.get("url_path")), r);
					requestMap.put(r, attributes);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

	}
	
	public Map<RequestMatcher, Collection<ConfigAttribute>> getRequestMap() {
		return requestMap;
	}

}
