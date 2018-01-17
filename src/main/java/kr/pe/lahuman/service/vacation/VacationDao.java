package kr.pe.lahuman.service.vacation;

import java.util.List;

import kr.pe.lahuman.utils.DataMap;

import org.apache.ibatis.annotations.Param;

public interface VacationDao {

	List<DataMap<String, Object>> list(
			@Param("param") DataMap<String, Object> param);
	int listCount(@Param("param") DataMap<String, Object> param);
	
	int marge(@Param("param") DataMap<String, Object> param);

	int delete(@Param("param") DataMap<String, Object> param);
	
	List<DataMap<String, Object>> holidayList(
			@Param("param") DataMap<String, Object> param);

	int holidayListCount(@Param("param") DataMap<String, Object> param);
	
	int holidayMarge(@Param("param") DataMap<String, Object> param);

	int holidayDelete(@Param("param") DataMap<String, Object> param);
}
