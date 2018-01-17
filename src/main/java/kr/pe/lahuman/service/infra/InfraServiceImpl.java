package kr.pe.lahuman.service.infra;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.pe.lahuman.utils.DataMap;

@Service(value="infraService")
public class InfraServiceImpl {


	private InfraDao infraDao;

	
	@Autowired
	public void setSqlSession(SqlSession sqlSession){
		this.infraDao = sqlSession.getMapper(kr.pe.lahuman.service.infra.InfraDao.class);
	}
	

	public int marge(DataMap<String, Object> param){
		return infraDao.marge(param);
	}
	
	public Map<String, Object> getList(
			DataMap<String, Object> param) {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("rows", infraDao.list(param));
		resultMap.put("total", infraDao.listCount(param));
		return resultMap;
	}
	
	public Map<String, Object> getRead(DataMap<String, Object> param){
		return infraDao.select(param);
	}
	
	
	public List<Map<String, Object>> getConnectInfraList(DataMap<String, Object> param){
		return infraDao.connectInfraList(param);
	}
	
	public List<Map<String, Object>> comboInfraList(DataMap<String, Object> param){
		return infraDao.comboInfraList(param);
	}
	

	@Transactional(rollbackFor=Exception.class)
	public String connectInfraUpdate(String id, List<DataMap<String, Object>> paramList){
		infraDao.connectInfraDelete(id);
		if(paramList.size() > 0)
			infraDao.insertConnectInfra(paramList);
		return "";
	}


	public String updateManager(List<DataMap<String, Object>> paramList) {
		String resultStr = "";
		for(DataMap<String, Object> param : paramList){
			if(1 > infraDao.updateManager(param)){
				resultStr +=param.getString("ID")+",";
			}	
		}
		return (resultStr.length()!=0)?resultStr.substring(0, resultStr.length()-1):resultStr;
	}
	
}
