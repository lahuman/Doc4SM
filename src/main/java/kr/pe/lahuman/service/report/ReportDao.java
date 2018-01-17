package kr.pe.lahuman.service.report;

import java.util.List;

import kr.pe.lahuman.utils.DataMap;

import org.apache.ibatis.annotations.Param;

public interface ReportDao {

	DataMap<String, Object> event(@Param("param")DataMap<String, Object> param);
	List<DataMap<String, Object>> eventList(@Param("param")DataMap<String, Object> param);
	List<DataMap<String, Object>> call(@Param("param")DataMap<String, Object> param);
	List<DataMap<String, Object>> infraList(@Param("param")DataMap<String, Object> param);
	DataMap<String, Object> infra(@Param("param")DataMap<String, Object> param);
	DataMap<String, Object> daily(@Param("param")DataMap<String, Object> param);
	DataMap<String, Object> problem(@Param("param")DataMap<String, Object> param);
	DataMap<String, Object> meeting(@Param("param")DataMap<String, Object> param);
	List<DataMap<String, Object>> vacationList(@Param("param")DataMap<String, Object> param);
	DataMap<String, Object> vacation(@Param("param")DataMap<String, Object> param);
	List<DataMap<String, Object>> problemRelation(@Param("param")DataMap<String, Object> param);
	List<DataMap<String, Object>> versionInfo(@Param("param")DataMap<String, Object> param);
	String getInfraIds4Process(@Param("param")DataMap<String, Object> param);
	List<DataMap<String, Object>> external(@Param("param")DataMap<String, Object> param);
	
	DataMap<String, Object> infrastructureInfo(@Param("param")DataMap<String, Object> param);
	DataMap<String, Object> obstacle4CountNTime(@Param("param")DataMap<String, Object> param);
	DataMap<String, Object> obstacle4LevelCountNTime(@Param("param")DataMap<String, Object> param);
	DataMap<String, Object> obstacle4Kind(@Param("param")DataMap<String, Object> param);
	DataMap<String, Object> obstacle4Time(@Param("param")DataMap<String, Object> param);
	DataMap<String, Object> change4CountTime(@Param("param")DataMap<String, Object> param);
	DataMap<String, Object> change4KindOfUser(@Param("param")DataMap<String, Object> param);
	DataMap<String, Object> change4KindOfOutside(@Param("param")DataMap<String, Object> param);
	DataMap<String, Object> serviceAvailability(@Param("param")DataMap<String, Object> param);
	DataMap<String, Object> systemNnetworkAvailability(@Param("param")DataMap<String, Object> param);
	DataMap<String, Object> obstacleAverageTime(@Param("param")DataMap<String, Object> param);
	DataMap<String, Object> obstacleAverageCount(@Param("param")DataMap<String, Object> param);
	
	DataMap<String, Object> service4Day(@Param("param")DataMap<String, Object> param);
}
