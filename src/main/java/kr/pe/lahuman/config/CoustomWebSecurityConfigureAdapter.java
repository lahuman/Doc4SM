package kr.pe.lahuman.config;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.access.AccessDecisionManager;
import org.springframework.security.access.AccessDecisionVoter;
import org.springframework.security.access.vote.AffirmativeBased;
import org.springframework.security.access.vote.AuthenticatedVoter;
import org.springframework.security.access.vote.RoleVoter;
import org.springframework.security.access.vote.UnanimousBased;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.authentication.ProviderManager;
import org.springframework.security.authentication.dao.DaoAuthenticationProvider;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.builders.WebSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.web.access.expression.WebExpressionVoter;
import org.springframework.security.web.access.intercept.FilterInvocationSecurityMetadataSource;
import org.springframework.security.web.access.intercept.FilterSecurityInterceptor;

import kr.pe.lahuman.config.security.CustomUserDetailsServiceImpl;
import kr.pe.lahuman.config.security.PasswordGenerator;
import kr.pe.lahuman.config.security.ReloadableDefaultFilterInvocationSecurityMetadataSource;
import kr.pe.lahuman.config.security.UrlResourceManager;
import kr.pe.lahuman.utils.Constants;

@Configuration
@EnableWebSecurity
public class CoustomWebSecurityConfigureAdapter extends
		WebSecurityConfigurerAdapter {

	private Logger log = LoggerFactory.getLogger(CoustomWebSecurityConfigureAdapter.class);
	@Autowired
	private CustomUserDetailsServiceImpl customUserDetailsService;


	@Override
	public void configure(WebSecurity web) throws Exception {
		String[] vals = Constants.getValue("resource.path").split(",");
		web.ignoring().antMatchers(vals);
	}


	@Override
	protected void configure(AuthenticationManagerBuilder registry)
			throws Exception {
		registry.userDetailsService(customUserDetailsService).passwordEncoder(new PasswordGenerator());
	}
	
	@Override
	protected void configure(HttpSecurity http) throws Exception {
		
		http.csrf()
				.disable()
				.authorizeRequests()
				.antMatchers("/login", "/login/form**", "/login/pop/form**", "/register", "/logout", "/403.do")
				.permitAll()
				// .antMatchers("/admin","/admin/**").hasRole("ADMIN")
				// .antMatchers("/**").hasRole("USER")
				.anyRequest()
				.authenticated()
				.and()
				.formLogin()
				.loginPage(Constants.getValue("login.page"))
				.loginProcessingUrl(Constants.getValue("login.process"))
				.defaultSuccessUrl(Constants.getValue("login.success"))
				.failureUrl(Constants.getValue("login.fail"))
				.permitAll()
				.and()
				.exceptionHandling().accessDeniedPage("/403.do")
				.and()
				.logout()
				.deleteCookies("JSESSIONID")
				.logoutUrl(Constants.getValue("logout.page"))
				.logoutSuccessUrl(Constants.getValue("logout.success"))
				.permitAll()
				.and()
				.rememberMe().key("uniqueAndSecret")
				.and()
				.addFilterAfter(filterSecurityInterceptor(),
						FilterSecurityInterceptor.class);
	}

	
	@Bean
	public AuthenticationManager authMgr() {
		List<AuthenticationProvider> providers = new ArrayList<AuthenticationProvider>();
		DaoAuthenticationProvider daoAP = new DaoAuthenticationProvider();
		daoAP.setUserDetailsService(customUserDetailsService);
		providers.add(daoAP);
		return new ProviderManager(providers);
	}

	@Bean
	public RoleVoter roleVoter() {
		RoleVoter roleVoter = new RoleVoter();
		// roleVoter.setRolePrefix("");
		return roleVoter;
	}

	@Bean
	public AccessDecisionManager accessDecisionManager() {
		List<AccessDecisionVoter> voters = Arrays.<AccessDecisionVoter> asList(
				roleVoter(), new WebExpressionVoter());
		return new AffirmativeBased(voters);
		
//	   List<AccessDecisionVoter<? extends Object>> decisionVoters 
//	      = Arrays.asList(
//	        new WebExpressionVoter(),
//	        new RoleVoter());
//	    return new UnanimousBased(decisionVoters);
	}

	@Bean
	public FilterInvocationSecurityMetadataSource getReloadableDefaultFilterInvocationSecurityMetadataSource() {
		return new ReloadableDefaultFilterInvocationSecurityMetadataSource();
	}

	@Autowired
	private UrlResourceManager urlResourceManager;

	@Bean
	public FilterSecurityInterceptor filterSecurityInterceptor() {
		// FilterSecurityInterceptor
		FilterSecurityInterceptor filterSecurityInterceptor = new FilterSecurityInterceptor();
		filterSecurityInterceptor.setObserveOncePerRequest(false);
		filterSecurityInterceptor.setAuthenticationManager(authMgr());
		filterSecurityInterceptor
				.setAccessDecisionManager(accessDecisionManager());

		filterSecurityInterceptor
				.setSecurityMetadataSource(getReloadableDefaultFilterInvocationSecurityMetadataSource());
		try {
			filterSecurityInterceptor.afterPropertiesSet();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return filterSecurityInterceptor;
	}

}
