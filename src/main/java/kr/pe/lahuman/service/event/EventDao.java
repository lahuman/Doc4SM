package kr.pe.lahuman.service.event;

import java.util.List;
import java.util.Map;

import kr.pe.lahuman.utils.DataMap;

import org.apache.ibatis.annotations.Param;

public interface EventDao {

	List<DataMap<String, Object>> list(@Param("param") DataMap<String, Object> param);
	int listCount(@Param("param") DataMap<String, Object> param);
	
	int marge(@Param("param") DataMap<String, Object> param);
	int delete(@Param("param") DataMap<String, Object> param);
	
	int margeProcess(@Param("param") DataMap<String, Object> param);
	int margeChange(@Param("param") DataMap<String, Object> param);
	int margeObstacle(@Param("param") DataMap<String, Object> param);

	Map<String, Object> select(@Param("param")DataMap<String, Object> param);
	int changeStatus(@Param("param") DataMap<String, Object> param);
	int changeAttachFile(@Param("param") DataMap<String, Object> param);
	
	List<DataMap<String, Object>> commentList(@Param("param") DataMap<String, Object> param);
	int commentMarge(@Param("param") DataMap<String, Object> param);
	int commentDelete(@Param("param") DataMap<String, Object> param);
}
