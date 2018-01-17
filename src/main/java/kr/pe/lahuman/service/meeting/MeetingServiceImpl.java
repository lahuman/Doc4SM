package kr.pe.lahuman.service.meeting;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import kr.pe.lahuman.service.common.MysqlFunctionDao;
import kr.pe.lahuman.utils.DataMap;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service(value="meetingService")
public class MeetingServiceImpl {

	private MeetingDao meetingDao;

	
	@Autowired
	public void setSqlSession(SqlSession sqlSession){
		this.meetingDao = sqlSession.getMapper(kr.pe.lahuman.service.meeting.MeetingDao.class);
	}
	
	
	public String process(List<DataMap<String, Object>> paramList) {
		String resultStr = "";
		for(DataMap<String, Object> param : paramList){
			if("D".equals(param.getString("STATUS"))){
				if(1 != meetingDao.delete(param)){
					resultStr +=param.getString("ID")+",";
				}
			}else{
				if(1 > meetingDao.marge(param)){
					resultStr +=param.getString("ID")+",";
				}	
			}
		}
		return (resultStr.length()!=0)?resultStr.substring(0, resultStr.length()-1):resultStr;
	}
	public Map<String, Object> getList(
			DataMap<String, Object> param) {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("rows", meetingDao.list(param));
		resultMap.put("total", meetingDao.listCount(param));
		return resultMap;
	}
	
	public Map<String, Object> getRead(DataMap<String, Object> param){
		return meetingDao.select(param);
	}
	

}
