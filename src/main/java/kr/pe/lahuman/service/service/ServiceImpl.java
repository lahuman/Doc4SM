package kr.pe.lahuman.service.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.pe.lahuman.utils.DataMap;

@Service(value="service")
public class ServiceImpl {

	private ServiceDao serviceDao;
	
	
	@Autowired
	public void setSqlSession(SqlSession sqlSession){
		this.serviceDao = sqlSession.getMapper(kr.pe.lahuman.service.service.ServiceDao.class);
	}
	
	
	public Map<String, Object> getList(
			DataMap<String, Object> param) {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("rows", serviceDao.list(param));
		resultMap.put("total", serviceDao.listCount(param));
		return resultMap;
	}
	
	
	public String process(List<DataMap<String, Object>> paramList) {
		String resultStr = "";
		for(DataMap<String, Object> param : paramList){
			if("D".equals(param.getString("STATUS"))){
				if(1 != serviceDao.delete(param)){
					resultStr +=param.getString("ID")+",";
				}
			}else{
				if(1 > serviceDao.marge(param)){
					resultStr +=param.getString("ID")+",";
				}	
			}
		}
		return (resultStr.length()!=0)?resultStr.substring(0, resultStr.length()-1):resultStr;
	}
	
	public List<DataMap<String, Object>> serviceList(DataMap<String, Object> param){
		return serviceDao.serviceList(param);
	}
	
	public List<DataMap<String, Object>> categoryList(DataMap<String, Object> param){
		return serviceDao.categoryList(param);
	}

	public List<DataMap<String, Object>> serviceCategoryList(DataMap<String, Object> param){
		return serviceDao.serviceCategoryList(param);
	}

	
	@Transactional(rollbackFor=Exception.class)
	public String processCategory(List<DataMap<String, Object>> paramList){
		String resultStr = "";
		for(DataMap<String, Object> param : paramList){
			if("D".equals(param.getString("STATUS"))){
				if(1 != serviceDao.categoryDelete(param)){
					resultStr +=param.getString("ID")+",";
				}
			}else{
				if(1 > serviceDao.categoryMarge(param)){
					resultStr +=param.getString("ID")+",";
				}	
			}
		}
		return (resultStr.length()!=0)?resultStr.substring(0, resultStr.length()-1):resultStr;
	}
}
