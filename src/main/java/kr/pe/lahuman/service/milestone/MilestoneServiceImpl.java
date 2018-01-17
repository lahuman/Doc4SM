package kr.pe.lahuman.service.milestone;

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

@Service(value="milestoneService")
public class MilestoneServiceImpl {

	private MilestoneDao milestoneDao;
	
	
	@Autowired
	public void setSqlSession(SqlSession sqlSession){
		this.milestoneDao = sqlSession.getMapper(kr.pe.lahuman.service.milestone.MilestoneDao.class);
	}
	
	public List<DataMap<String, Object>> getComboList(
			DataMap<String, Object> param) {
		return milestoneDao.comboList(param);
	}
	
	public Map<String, Object> getList(
			DataMap<String, Object> param) {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("rows", milestoneDao.list(param));
		resultMap.put("total", milestoneDao.listCount(param));
		return resultMap;
	}


	public List<DataMap<String, Object>> milestoneRelationList(
			 DataMap<String, Object> param){
		return milestoneDao.milestoneRelationList(param);
	}

	public String process(List<DataMap<String, Object>> paramList) {
		String resultStr = "";
		for(DataMap<String, Object> param : paramList){
			if("D".equals(param.getString("DEL_YN"))){
				if(1 != milestoneDao.delete(param)){
					resultStr +=param.getString("id")+",";
				}
			}else{
				if(1 > milestoneDao.marge(param)){
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
				if(1 != milestoneDao.deleteRelation(param)){
					resultStr +=param.getString("id")+",";
				}
			}else{
				if(1 > milestoneDao.margeRelation(param)){
					resultStr +=param.getString("id")+",";
				}	
			}
		}
		return (resultStr.length()!=0)?resultStr.substring(0, resultStr.length()-1):resultStr;
	}
}
