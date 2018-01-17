package kr.pe.lahuman.service.monitoring;

import java.util.Map;

import kr.pe.lahuman.service.common.MysqlFunctionDao;
import kr.pe.lahuman.utils.DataMap;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service(value="monitoringService")
public class MonitoringServiceImpl {

	
	private MysqlFunctionDao mysqlFunctionDao;
	private MonitoringDao monitoringDao;

	
	@Autowired
	public void setSqlSession(SqlSession sqlSession){
		this.monitoringDao = sqlSession.getMapper(kr.pe.lahuman.service.monitoring.MonitoringDao.class);
		this.mysqlFunctionDao = sqlSession.getMapper(kr.pe.lahuman.service.common.MysqlFunctionDao.class);
	}
	
	public Map<String, Object> getStatus(DataMap<String, Object> param){
		return monitoringDao.select(param);
	}
}
