package kr.pe.lahuman.service.problem;

import java.util.List;

import kr.pe.lahuman.utils.DataMap;

import org.apache.ibatis.annotations.Param;

public interface ProblemDao {

	List<DataMap<String, Object>> list(
			@Param("param") DataMap<String, Object> param);
	int listCount(@Param("param") DataMap<String, Object> param);
	List<DataMap<String, Object>> eventList(
			@Param("param") DataMap<String, Object> param);

	List<DataMap<String, Object>> problemRelationList(
			@Param("param") DataMap<String, Object> param);

	int marge(@Param("param") DataMap<String, Object> param);

	int delete(@Param("param") DataMap<String, Object> param);

	int margeRelation(@Param("param") DataMap<String, Object> param);
	int deleteRelation(@Param("param") DataMap<String, Object> param);
}
