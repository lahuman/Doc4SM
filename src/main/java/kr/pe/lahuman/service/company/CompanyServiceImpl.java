package kr.pe.lahuman.service.company;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import kr.pe.lahuman.service.common.MysqlFunctionDao;
import kr.pe.lahuman.utils.DataMap;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service(value="companyService") 
public class CompanyServiceImpl {

	private CompanyDao companyDao;
	
	
	@Autowired
	public void setSqlSession(SqlSession sqlSession){
		this.companyDao = sqlSession.getMapper(kr.pe.lahuman.service.company.CompanyDao.class);
	}
	
	
	public Map<String, Object> getList(
			DataMap<String, Object> param) {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("rows", companyDao.list(param));
		resultMap.put("total", companyDao.listCount(param));
		return resultMap;
	}
	
	public List<DataMap<String, Object>> companyList(DataMap<String, Object> param){
		return companyDao.companyList(param);
	}
	
	public String process(List<DataMap<String, Object>> paramList) {
		String resultStr = "";
		for(DataMap<String, Object> param : paramList){
			if("D".equals(param.getString("STATUS"))){
				if(1 != companyDao.delete(param)){
					resultStr +=param.getString("id")+",";
				}
			}else{
				if(1 > companyDao.marge(param)){
					resultStr +=param.getString("id")+",";
				}	
			}
		}
		return (resultStr.length()!=0)?resultStr.substring(0, resultStr.length()-1):resultStr;
	}
	
	public List<DataMap<String, Object>> contractList(DataMap<String, Object> param){
		return companyDao.contractList(param);
	}

	@Transactional(rollbackFor=Exception.class)
	public String processContract(List<DataMap<String, Object>> paramList){
		companyDao.deleteContract(paramList.get(0));
		if(!"".equals(paramList.get(0).getString("COMPANY_ID")))
			companyDao.insertContract(paramList);
		return "";
	}
}
