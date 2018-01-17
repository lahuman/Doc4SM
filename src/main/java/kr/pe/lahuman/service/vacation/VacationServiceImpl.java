package kr.pe.lahuman.service.vacation;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import kr.pe.lahuman.service.common.MysqlFunctionDao;
import kr.pe.lahuman.utils.DataMap;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service(value="vacationService")
public class VacationServiceImpl {

	private VacationDao vacationDao;
	
	@Autowired
	public void setSqlSession(SqlSession sqlSession){
		this.vacationDao = sqlSession.getMapper(kr.pe.lahuman.service.vacation.VacationDao.class);
	}
	
	public Map<String, Object> getList(
			DataMap<String, Object> param) {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("rows", vacationDao.list(param));
		resultMap.put("total", vacationDao.listCount(param));
		return resultMap;
	}
	
	
	public String process(List<DataMap<String, Object>> paramList) {
		String resultStr = "";
		for(DataMap<String, Object> param : paramList){
			if("D".equals(param.getString("STATUS"))){
				if(1 != vacationDao.delete(param)){
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
		return vacationDao.marge(param);
	}
	
	public Map<String, Object> getHolidayList(
			DataMap<String, Object> param) {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("rows", vacationDao.holidayList(param));
		resultMap.put("total", vacationDao.holidayListCount(param));
		return resultMap;
	}
	
	
	public String holidayProcess(List<DataMap<String, Object>> paramList) {
		String resultStr = "";
		for(DataMap<String, Object> param : paramList){
			if("D".equals(param.getString("STATUS"))){
				if(1 != vacationDao.holidayDelete(param)){
					resultStr +=param.getString("ID")+",";
				}
			}else{
				if(1 > holidayMarge(param)){
					resultStr +=param.getString("ID")+",";
				}	
			}
		}
		return (resultStr.length()!=0)?resultStr.substring(0, resultStr.length()-1):resultStr;
	}
	
	public int holidayMarge(DataMap<String, Object> param){
		return vacationDao.holidayMarge(param);
	}
	
}
