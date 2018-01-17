package kr.pe.lahuman.service.service;

import java.util.List;

import kr.pe.lahuman.utils.DataMap;

import org.apache.ibatis.annotations.Param;

public interface ServiceDao {

	List<DataMap<String, Object>> list(@Param("param") DataMap<String, Object> param);
	int listCount(@Param("param") DataMap<String, Object> param);
	int marge(@Param("param") DataMap<String, Object> param);
	
	int delete(@Param("param") DataMap<String, Object> param);

	List<DataMap<String, Object>> categoryList(@Param("param") DataMap<String, Object> param);
	
	List<DataMap<String, Object>> serviceCategoryList(@Param("param") DataMap<String, Object> param);
	
	int categoryMarge(@Param("param") DataMap<String, Object> param);
	
	int categoryDelete(@Param("param") DataMap<String, Object> param);
	
	List<DataMap<String, Object>> serviceList(@Param("param") DataMap<String, Object> param);
}
