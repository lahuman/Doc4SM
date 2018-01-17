package kr.pe.lahuman.config.security;

import java.util.Collection;
import java.util.HashSet;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.ConfigAttribute;
import org.springframework.security.web.FilterInvocation;
import org.springframework.security.web.access.intercept.FilterInvocationSecurityMetadataSource;
import org.springframework.security.web.util.matcher.RequestMatcher;
import org.springframework.stereotype.Service;

public class ReloadableDefaultFilterInvocationSecurityMetadataSource implements
		FilterInvocationSecurityMetadataSource {

	
	@Autowired
	private UrlResourceManager urlResourceManager;
	
	  public Collection<ConfigAttribute> getAttributes(Object object) throws IllegalArgumentException {
	        FilterInvocation fi = (FilterInvocation) object;

	        String url = fi.getRequestUrl();
	        HttpServletRequest request = fi.getHttpRequest();

	        for (Map.Entry<RequestMatcher, Collection<ConfigAttribute>> entry : urlResourceManager.getRequestMap()
					.entrySet()) {
				if (entry.getKey().matches(request)) {
					return entry.getValue();
				}
			}
			return null;
	    }

	    public Collection<ConfigAttribute> getAllConfigAttributes() {
	    	if(urlResourceManager.getRequestMap() == null){
				return null;
			}else{
				
				Set<ConfigAttribute> allAttributes = new HashSet<ConfigAttribute>();
				
				for (Map.Entry<RequestMatcher, Collection<ConfigAttribute>> entry : urlResourceManager.getRequestMap()
						.entrySet()) {
					allAttributes.addAll(entry.getValue());
				}
				
				return allAttributes;
			}
	    }

	    public boolean supports(Class<?> clazz) {
	        return FilterInvocation.class.isAssignableFrom(clazz);
	    }

}
