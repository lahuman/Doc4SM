package kr.pe.lahuman.service.common;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

public interface LoginDao {

	Map<String, Object> selectLogin(@Param("username") String username);
	
	List<String> selectAuthorities(@Param("user_id") Long loginId);
}
