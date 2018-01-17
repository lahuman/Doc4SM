package kr.pe.lahuman.service.svn;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.pe.lahuman.utils.DataMap;

@Service(value="versionService")
public class VersionServiceImpl {
	private VersionDao versionDao;
	
	@Autowired
	public void setSqlSession(SqlSession sqlSession){
		this.versionDao = sqlSession.getMapper(kr.pe.lahuman.service.svn.VersionDao.class);
	}
	
	public Map<String, Object> getList(
			DataMap<String, Object> param) {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("rows", versionDao.list(param));
		resultMap.put("total", versionDao.listCount(param));
		return resultMap;
	}
	
	
	public String process(List<DataMap<String, Object>> paramList) {
		String resultStr = "";
		for(DataMap<String, Object> param : paramList){
			if("D".equals(param.getString("STATUS"))){
				if(1 != versionDao.delete(param)){
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
		return versionDao.marge(param);
	}

	public long getLastSVNVersion(DataMap<String, Object> param){
		return versionDao.getLastSVNVersion(param);
	}
}
