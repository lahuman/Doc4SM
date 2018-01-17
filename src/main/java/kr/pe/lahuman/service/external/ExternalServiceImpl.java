package kr.pe.lahuman.service.external;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import kr.pe.lahuman.service.common.MysqlFunctionDao;
import kr.pe.lahuman.service.company.CompanyDao;
import kr.pe.lahuman.service.milestone.MilestoneDao;
import kr.pe.lahuman.utils.DataMap;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service(value="ExternalService")
public class ExternalServiceImpl {

	private ExternalDao externalDao;
	private MysqlFunctionDao mysqlFunctionDao;
	private MilestoneDao milestoneDao;
	
	
	@Autowired
	public void setSqlSession(SqlSession sqlSession){
		this.externalDao = sqlSession.getMapper(kr.pe.lahuman.service.external.ExternalDao.class);
		this.milestoneDao = sqlSession.getMapper(kr.pe.lahuman.service.milestone.MilestoneDao.class);
		this.mysqlFunctionDao = sqlSession.getMapper(kr.pe.lahuman.service.common.MysqlFunctionDao.class);
	}
	
	public Map<String, Object> getList(
			DataMap<String, Object> param) {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("rows", externalDao.list(param));
		resultMap.put("total", externalDao.listCount(param));
		return resultMap;
	}
	
	public String process(List<DataMap<String, Object>> paramList) {
		String resultStr = "";
		for(DataMap<String, Object> param : paramList){
			//delete milestone
			deleteMilestone(param.getString("ID"));
			if("D".equals(param.getString("STATUS"))){
				if(1 != externalDao.delete(param)){
					resultStr +=param.getString("id")+",";
				}
			}else{
				int f = externalDao.marge(param);
				//insert milestone
				String id = mysqlFunctionDao.lastInsertId()+"";
				insertMilestone(param.getString("MILESTONE_ID"), ("0".equals(id))?param.getString("ID"):id);
				if(1 > f){
					resultStr +=param.getString("id")+",";
				}	
			}
		}
		return (resultStr.length()!=0)?resultStr.substring(0, resultStr.length()-1):resultStr;
	}
	
	private void insertMilestone(String milestone_id, String id) {
		if(id != null && !"".equals(id) && milestone_id != null && !"".equals(milestone_id)){
			DataMap<String, Object> param = makeMilestoneCallMap();
			param.put("milestone_id", milestone_id);
			param.put("EVENT_CODE", id);
			milestoneDao.margeRelation(param);
		}
	}

	
	private void deleteMilestone(String id){
		if(id != null && !"".equals(id)){
			DataMap<String, Object> param = makeMilestoneCallMap();
			param.put("EVENT_CODE", id);
			milestoneDao.deleteRelation(param);
		}
	}

	private DataMap<String, Object> makeMilestoneCallMap() {
		DataMap<String, Object> param = new DataMap<String, Object>();
		param.put("EVENT_TYPE", "O");
		return param;
	}
}
