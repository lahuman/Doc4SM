package kr.pe.lahuman.service.monitoring;

import kr.pe.lahuman.utils.DataMap;

import org.apache.ibatis.annotations.Param;

public interface MonitoringDao {

	DataMap<String, Object> select(@Param("param") DataMap<String, Object> param);
}
