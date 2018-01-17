package kr.pe.lahuman.service.statistics;

import java.util.List;

import kr.pe.lahuman.utils.DataMap;

import org.apache.ibatis.annotations.Param;

public interface StatisticsDao {

	List<DataMap<String, Object>> service(@Param("param")DataMap<String, Object> param);	
	List<DataMap<String, Object>> event(@Param("param")DataMap<String, Object> param);	
	List<DataMap<String, Object>> tagCloudService(@Param("param")DataMap<String, Object> param);	
	List<DataMap<String, Object>> tagCloudCategory(@Param("param")DataMap<String, Object> param);	
	List<DataMap<String, Object>> ganttChart(@Param("param")DataMap<String, Object> param);
	List<DataMap<String, Object>> ganttChart2(@Param("param")DataMap<String, Object> param);
}
