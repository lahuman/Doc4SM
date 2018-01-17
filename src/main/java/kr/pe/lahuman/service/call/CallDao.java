package kr.pe.lahuman.service.call;

import java.util.List;

import kr.pe.lahuman.utils.DataMap;

import org.apache.ibatis.annotations.Param;

public interface CallDao {

	List<DataMap<String, Object>> list(@Param("param") DataMap<String, Object> param);
	
	int listCount(@Param("param") DataMap<String, Object> param);
	
	int marge(@Param("param") DataMap<String, Object> param);
	
	int delete(@Param("param") DataMap<String, Object> param);
}
