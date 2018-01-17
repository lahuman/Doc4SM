package kr.pe.lahuman.service.company;

import java.util.List;

import kr.pe.lahuman.utils.DataMap;

import org.apache.ibatis.annotations.Param;

public interface CompanyDao {

	List<DataMap<String, Object>> list(@Param("param") DataMap<String, Object> param);
	
	int listCount(@Param("param") DataMap<String, Object> param);
	
	List<DataMap<String, Object>> companyList(@Param("param") DataMap<String, Object> param);
	
	List<DataMap<String, Object>> contractList(@Param("param") DataMap<String, Object> param);
	
	int marge(@Param("param") DataMap<String, Object> param);
	
	int delete(@Param("param") DataMap<String, Object> param);
	
	int insertContract(@Param("list") List<DataMap<String, Object>> list);
	
	int deleteContract(@Param("param") DataMap<String, Object> param);
}
