package kr.pe.lahuman.service.infra;

import java.util.List;
import java.util.Map;

import kr.pe.lahuman.utils.DataMap;

import org.apache.ibatis.annotations.Param;

public interface InfraDao {
	List<DataMap<String, Object>> list(@Param("param") DataMap<String, Object> param);
	int listCount(@Param("param") DataMap<String, Object> param);
	DataMap<String, Object> select(@Param("param") DataMap<String, Object> param);
	
	int marge(@Param("param") DataMap<String, Object> param);
	
	int delete(@Param("param") DataMap<String, Object> param);

	List<Map<String, Object>> connectInfraList(@Param("param")DataMap<String, Object> param);
	
	List<Map<String, Object>> comboInfraList(@Param("param")DataMap<String, Object> param);

	void connectInfraDelete(@Param("id")String id);

	void insertConnectInfra(@Param("list")List<DataMap<String, Object>> paramList);

	int updateManager(@Param("param")DataMap<String, Object> paramMap);
}
