package kr.pe.lahuman;

import javax.servlet.FilterRegistration;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.ServletRegistration;

import org.sitemesh.config.ConfigurableSiteMeshFilter;
import org.springframework.web.WebApplicationInitializer;
import org.springframework.web.context.ContextLoaderListener;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.support.AnnotationConfigWebApplicationContext;
import org.springframework.web.filter.CharacterEncodingFilter;
import org.springframework.web.filter.DelegatingFilterProxy;
import org.springframework.web.servlet.DispatcherServlet;

import kr.pe.lahuman.config.MultipartExceptionHandler;

public class WebInitializer implements WebApplicationInitializer {

	@Override
    public void onStartup(ServletContext servletContext) throws ServletException {
		
//		
        WebApplicationContext context = getContext();
        servletContext.addListener(new ContextLoaderListener(context));
        /*
        servletContext.setInitParameter( "log4jConfigLocation" , "/WEB-INF/log4j.xml" );
		servletContext.setInitParameter( "log4jRefreshInterval" , "10000" );
		servletContext.setInitParameter( "log4jExposeWebAppRoot", "false" );
		Log4jConfigListener log4jListener = new Log4jConfigListener();
		servletContext.addListener( log4jListener );
        */
		//servlet 
        ServletRegistration.Dynamic dispatcher = servletContext.addServlet("DispatcherServlet", new DispatcherServlet(context));
        dispatcher.setLoadOnStartup(1);
        dispatcher.addMapping("*.do");
        dispatcher.addMapping("*.json");
        
        //character set
        FilterRegistration charEncodingfilterReg = servletContext.addFilter("CharacterEncodingFilter", CharacterEncodingFilter.class);
        charEncodingfilterReg.setInitParameter("encoding", "UTF-8");
        charEncodingfilterReg.setInitParameter("forceEncoding", "true");
        charEncodingfilterReg.addMappingForUrlPatterns(null, false, "/*");
        
        //multipart filter
        FilterRegistration.Dynamic multipartFilter = servletContext.addFilter("springMultipartFilter", new MultipartExceptionHandler());
        multipartFilter.addMappingForUrlPatterns(null, true, "/*");
        
        //spring security
        FilterRegistration.Dynamic springFilter = servletContext.addFilter("springSecurityFilterChain", DelegatingFilterProxy.class);
        springFilter.addMappingForUrlPatterns(null, true, "/*");

        //sitemesh
        FilterRegistration.Dynamic sitemeshFilter =servletContext.addFilter("sitemesh", new ConfigurableSiteMeshFilter());
        sitemeshFilter.addMappingForUrlPatterns(null, true, "/*");

    }
 
    private AnnotationConfigWebApplicationContext getContext() {
        AnnotationConfigWebApplicationContext context = new AnnotationConfigWebApplicationContext();
        context.setConfigLocation("kr.pe.lahuman.config");
        return context;
    }
    
}
