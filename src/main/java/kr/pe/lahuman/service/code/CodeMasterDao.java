package kr.pe.lahuman.service.code;

import java.util.List;

import kr.pe.lahuman.utils.DataMap;

import org.apache.ibatis.annotations.Param;


public interface CodeMasterDao {
	List<DataMap<String, Object>> comboList(@Param("param") DataMap<String, Object> param);
	List<DataMap<String, Object>> list(@Param("param") DataMap<String, Object> param);
	int listCount(@Param("param") DataMap<String, Object> param);
	
	int marge(@Param("param") DataMap<String, Object> param);
	
	int delete(@Param("param") DataMap<String, Object> param);
}
