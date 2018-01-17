package kr.pe.lahuman.service.code;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.pe.lahuman.utils.DataMap;

@Service
public class CodeServiceImpl implements CodeService {

	private Logger log = LoggerFactory.getLogger(CodeServiceImpl.class);
	private CodeDao codeDao;
	private CodeMasterDao codeMasterDao;
	
	@Autowired
	public void setSqlSession(SqlSession sqlSession){
		this.codeDao = sqlSession.getMapper(kr.pe.lahuman.service.code.CodeDao.class);
		this.codeMasterDao = sqlSession.getMapper(kr.pe.lahuman.service.code.CodeMasterDao.class);
	}
	
	@Override
	public Map<String, Object> getCodeList(
			DataMap<String, Object> param) {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("rows", codeDao.list(param));
		resultMap.put("total", codeDao.listCount(param));
		return resultMap;
	}

	@Override
	public Map<String, Object>  getCodeMasterList(
			DataMap<String, Object> param) {
		List<DataMap<String, Object>> dataList = codeMasterDao.list(param);
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("rows", dataList);
		resultMap.put("total", codeMasterDao.listCount(param));
		return resultMap;
	}

	@Override
	public String processCodeMaster(List<DataMap<String, Object>> paramList) {
		String resultStr = "";
		for(DataMap<String, Object> param : paramList){
			try{
				
				if("D".equals(param.getString("STATUS"))){
					if(1 != codeMasterDao.delete(param)){
						resultStr +=param.getString("code_master")+",";
					}
					
				}else{
					if(1 > codeMasterDao.marge(param)){
						resultStr +=param.getString("code_master")+",";
					}	
				}
			}catch(Exception e){
				resultStr +=param.getString("code_master")+",";
				log.info(e.getMessage());
			}
		}
		return (resultStr.length()!=0)?resultStr.substring(0, resultStr.length()-1):resultStr;
	}

	@Override
	public String processCode(List<DataMap<String, Object>> paramList) {
		String resultStr = "";
		for(DataMap<String, Object> param : paramList){
			if("D".equals(param.getString("STATUS"))){
				if(1 != codeDao.delete(param)){
					resultStr +=param.getString("code")+",";
				}
			}else{
				if(1 > codeDao.marge(param)){
					resultStr +=param.getString("code")+",";
				}	
			}
		}
		return (resultStr.length()!=0)?resultStr.substring(0, resultStr.length()-1):resultStr;
	}
	
	@Override
	public List<DataMap<String, Object>> getComboCodeMaster(
			DataMap<String, Object> param) {
		return codeMasterDao.comboList(param);
	}


	public List<DataMap<String, Object>> getComboCodeList(
			DataMap<String, Object> param) {
		return codeDao.codeList(param);
	}
}
