package kr.pe.lahuman.service.call;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import kr.pe.lahuman.service.common.MysqlFunctionDao;
import kr.pe.lahuman.service.milestone.MilestoneDao;
import kr.pe.lahuman.utils.DataMap;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service(value="callService")
public class CallServiceImpl {

	private CallDao callDao;
	private MilestoneDao milestoneDao;
	private MysqlFunctionDao mysqlFunctionDao;
	
	@Autowired
	public void setSqlSession(SqlSession sqlSession){
		this.callDao = sqlSession.getMapper(kr.pe.lahuman.service.call.CallDao.class);
		this.milestoneDao = sqlSession.getMapper(kr.pe.lahuman.service.milestone.MilestoneDao.class);
		this.mysqlFunctionDao = sqlSession.getMapper(kr.pe.lahuman.service.common.MysqlFunctionDao.class);
	}
	
	public Map<String, Object> getList(
			DataMap<String, Object> param) {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("rows", callDao.list(param));
		resultMap.put("total", callDao.listCount(param));
		return resultMap;
	}
	
	
	@Transactional(rollbackFor={Exception.class})
	public String process(List<DataMap<String, Object>> paramList) {
		String resultStr = "";
		for(DataMap<String, Object> param : paramList){
			//delete milestone
			deleteMilestone(param.getString("ID"));
			if("D".equals(param.getString("STATUS"))){
				if(1 != callDao.delete(param)){
					resultStr +=param.getString("ID")+",";
				}
			}else{
				if(1 > marge(param)){
					resultStr +=param.getString("ID")+",";
				}	
			}
		}
		return (resultStr.length()!=0)?resultStr.substring(0, resultStr.length()-1):resultStr;
	}
	
	
	public int marge(DataMap<String, Object> param){
		int f = callDao.marge(param);
		//insert milestone
		String id = mysqlFunctionDao.lastInsertId()+"";
		insertMilestone(param.getString("MILESTONE_ID"), ("0".equals(id))?param.getString("ID"):id);
		return f;
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
		param.put("EVENT_TYPE", "S");
		return param;
	}
	
}
