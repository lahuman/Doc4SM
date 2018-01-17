package kr.pe.lahuman.service.user;

import java.util.List;

import kr.pe.lahuman.utils.DataMap;

import org.apache.ibatis.annotations.Param;


public interface UserDao {
	List<DataMap<String, Object>> list(@Param("param") DataMap<String, Object> param);
	int listCount(@Param("param") DataMap<String, Object> param);
	List<DataMap<String, Object>> userList(@Param("param") DataMap<String, Object> param);
	
	List<DataMap<String, Object>> roleList(@Param("param") DataMap<String, Object> param);
	
	int marge(@Param("param") DataMap<String, Object> param);
	
	int delete(@Param("param") DataMap<String, Object> param);
	
	int insertRole(@Param("list") List<DataMap<String, Object>> list);
	
	int deleteRole(@Param("param") DataMap<String, Object> param);
	
	DataMap<String, Object> getName(@Param("param") String loginId);
}
