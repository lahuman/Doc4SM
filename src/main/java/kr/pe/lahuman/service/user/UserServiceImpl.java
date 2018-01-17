package kr.pe.lahuman.service.user;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.pe.lahuman.config.security.PasswordGenerator;
import kr.pe.lahuman.utils.DataMap;

@Service(value="UserService")
public class UserServiceImpl {

	private UserDao userDao;

	
	private PasswordGenerator encoder = new PasswordGenerator();
	
	@Autowired
	public void setSqlSession(SqlSession sqlSession){
		this.userDao = sqlSession.getMapper(kr.pe.lahuman.service.user.UserDao.class);
	}
	
	
	public DataMap<String, Object> getName(String loginId){
		return userDao.getName(loginId);
	}
	
	
	public List<DataMap<String, Object>> getUserList(
			DataMap<String, Object> param) {
		return userDao.userList(param);
	}
	
	
	public Map<String, Object> getList(
			DataMap<String, Object> param) {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("rows", userDao.list(param));
		resultMap.put("total", userDao.listCount(param));
		return resultMap;
	}
	
	
	public String process(List<DataMap<String, Object>> paramList) {
		String resultStr = "";
		for(DataMap<String, Object> param : paramList){
			param.put("password", encoder.encode(param.getString("password")));
			if("D".equals(param.getString("STATUS"))){
				if(1 != userDao.delete(param)){
					resultStr +=param.getString("user_id")+",";
				}
			}else{
				if(1 > userDao.marge(param)){
					resultStr +=param.getString("user_id")+",";
				}	
			}
		}
		return (resultStr.length()!=0)?resultStr.substring(0, resultStr.length()-1):resultStr;
	}
	
	public List<DataMap<String, Object>> roleList(DataMap<String, Object> param){
		return userDao.roleList(param);
	}

	@Transactional(rollbackFor=Exception.class)
	public String processRole(List<DataMap<String, Object>> paramList){
		userDao.deleteRole(paramList.get(0));
		if(!"".equals(paramList.get(0).getString("ROLE_ID")))
			userDao.insertRole(paramList);
		return "";
	}
}
