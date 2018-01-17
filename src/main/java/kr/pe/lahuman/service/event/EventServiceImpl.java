package kr.pe.lahuman.service.event;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.pe.lahuman.service.milestone.MilestoneDao;
import kr.pe.lahuman.utils.DataMap;


@Service(value="eventService")
public class EventServiceImpl {

	private EventDao eventDao;
	private MilestoneDao milestoneDao;
	
	@Autowired
	public void setSqlSession(SqlSession sqlSession){
		this.eventDao = sqlSession.getMapper(kr.pe.lahuman.service.event.EventDao.class);
		this.milestoneDao = sqlSession.getMapper(kr.pe.lahuman.service.milestone.MilestoneDao.class);
	}
	
	
	public int marge(DataMap<String, Object> param){
		return eventDao.marge(param);
	}
	
	public Map<String, Object> getList(
			DataMap<String, Object> param) {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("rows", eventDao.list(param));
		resultMap.put("total", eventDao.listCount(param));
		return resultMap;
	}


	public Map<String, Object> getRead(DataMap<String, Object> param) {
		return eventDao.select(param);
	}
	
	@Transactional(rollbackFor=Exception.class)
	public int processEvent(DataMap<String, Object> param) throws Exception{
		//milestone
		deleteMilestone(param.getString("REQ_CODE"));
		insertMilestone(param.getString("MILESTONE_ID"), param.getString("REQ_CODE"));
		
		
		eventDao.marge(param);
		eventDao.margeProcess(param);
		
		if("EV02".equals(param.getString("PROC_TYPE")) || "C".equals(param.getString("REQ_TYPE"))){
			eventDao.margeChange(param);
		}else if("EV03".equals(param.getString("PROC_TYPE"))|| "O".equals(param.getString("REQ_TYPE"))){
			eventDao.margeObstacle(param);
		}
		
//		throw new Exception("transaction TESt");
		return 1;
	}

	@Transactional(rollbackFor=Exception.class)
	public String changeStatus(List<DataMap<String, Object>> paramList){
		String resultStr = "";
		for(DataMap<String, Object> param : paramList){
			
			if("D".equals(param.getString("STATUS"))){
				//삭제시 마일스톤 제거
				deleteMilestone(param.getString("REQ_CODE"));
				if(1 != eventDao.delete(param)){
					resultStr +=param.getString("REQ_CODE")+",";
				}
			}else{
				if(1 != eventDao.changeStatus(param)){
					resultStr +=param.getString("REQ_CODE")+",";
				}
			}
		}
		return (resultStr.length()!=0)?resultStr.substring(0, resultStr.length()-1):resultStr;
	}
	
	public int changeAttachFile(DataMap<String, Object> param){
		return eventDao.changeAttachFile(param);
	}
	
	
	public List<DataMap<String, Object>> getCommentList(
			DataMap<String, Object> param) {
		return eventDao.commentList(param);
	}
	
	@Transactional(rollbackFor=Exception.class)
	public String commentChange(List<DataMap<String, Object>> paramList){
		String resultStr = "";
		for(DataMap<String, Object> param : paramList){
			if("D".equals(param.getString("STATUS"))){
				if(1 != eventDao.commentDelete(param)){
					resultStr +=param.getString("COMMENT_ID")+",";
				}
			}else{
				if(1 != eventDao.commentMarge(param)){
					resultStr +=param.getString("COMMENT_ID")+",";
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
		param.put("EVENT_TYPE", "E");
		return param;
	}
}
