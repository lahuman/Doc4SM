package kr.pe.lahuman.service.problem;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import kr.pe.lahuman.service.common.MysqlFunctionDao;
import kr.pe.lahuman.service.company.CompanyDao;
import kr.pe.lahuman.utils.DataMap;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service(value="problemService")
public class ProblemServiceImpl {

	private ProblemDao problemDao;
	
	
	@Autowired
	public void setSqlSession(SqlSession sqlSession){
		this.problemDao = sqlSession.getMapper(kr.pe.lahuman.service.problem.ProblemDao.class);
	}
	public Map<String, Object> getList(
			DataMap<String, Object> param) {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("rows", problemDao.list(param));
		resultMap.put("total", problemDao.listCount(param));
		return resultMap;
	}
	public List<DataMap<String, Object>> eventList(
			 DataMap<String, Object> param){
		return problemDao.eventList(param);
	}

	public List<DataMap<String, Object>> problemRelationList(
			 DataMap<String, Object> param){
		return problemDao.problemRelationList(param);
	}

	public String process(List<DataMap<String, Object>> paramList) {
		String resultStr = "";
		for(DataMap<String, Object> param : paramList){
			if("D".equals(param.getString("DEL_YN"))){
				if(1 != problemDao.delete(param)){
					resultStr +=param.getString("id")+",";
				}
			}else{
				if(1 > problemDao.marge(param)){
					resultStr +=param.getString("id")+",";
				}	
			}
		}
		return (resultStr.length()!=0)?resultStr.substring(0, resultStr.length()-1):resultStr;
	}


	public String mergeRelation( List<DataMap<String, Object>> list){
		String resultStr = "";
		for(DataMap<String, Object> param : list){
			if("D".equals(param.getString("DEL_YN"))){
				if(1 != problemDao.deleteRelation(param)){
					resultStr +=param.getString("id")+",";
				}
			}else{
				if(1 > problemDao.margeRelation(param)){
					resultStr +=param.getString("id")+",";
				}	
			}
		}
		return (resultStr.length()!=0)?resultStr.substring(0, resultStr.length()-1):resultStr;
	}
}
