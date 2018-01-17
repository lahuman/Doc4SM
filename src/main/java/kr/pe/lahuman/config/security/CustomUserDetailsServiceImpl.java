package kr.pe.lahuman.config.security;

import java.util.ArrayList;
import java.util.Collection;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import kr.pe.lahuman.service.common.LoginDao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

@Service
public class CustomUserDetailsServiceImpl implements UserDetailsService {

	private LoginDao loginDao;

	@Autowired
	public void setSqlSession(SqlSession sqlSession) {
		this.loginDao = sqlSession.getMapper(LoginDao.class);
	}

	@Override
	public UserDetails loadUserByUsername(String username)
			throws UsernameNotFoundException {

		Map<String, Object> userEntity = loginDao.selectLogin(username);

		if (userEntity == null) {
			throw new UsernameNotFoundException("UserName " + username
					+ " not found");
		}

		boolean enabled = (Boolean) userEntity.get("enabled");
		boolean accountNonExpired = true;
		boolean credentialsNonExpired = true;
		boolean accountNonLocked = true;
		Collection<GrantedAuthority> authorities = new ArrayList<GrantedAuthority>();
		//기본값으로 모든 권한을 추가 한다.
		authorities.add(new SimpleGrantedAuthority("ROLE_ANONYMOUS"));
		
		List<String> authorityList = loginDao
				.selectAuthorities((Long) userEntity.get("user_id"));
		Iterator<String> ite = authorityList.iterator();
		while (ite.hasNext()) {
			authorities.add(new SimpleGrantedAuthority(ite.next()));
		}

		User user = new User(username, (String) userEntity.get("password"),
				enabled, accountNonExpired, credentialsNonExpired,
				accountNonLocked, authorities);

		return user;
	}

}
