package kr.pe.lahuman.service.meeting;

import java.util.List;

import kr.pe.lahuman.utils.DataMap;

import org.apache.ibatis.annotations.Param;

public interface MeetingDao {

	List<DataMap<String, Object>> list(
			@Param("param") DataMap<String, Object> param);
	int listCount(@Param("param") DataMap<String, Object> param);
	
	DataMap<String, Object> select(@Param("param") DataMap<String, Object> param);

	int marge(@Param("param") DataMap<String, Object> param);

	int delete(@Param("param") DataMap<String, Object> param);

}
