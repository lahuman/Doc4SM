package kr.pe.lahuman.service.statistics;

import java.util.List;

import kr.pe.lahuman.utils.DataMap;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service("statisticsService")
public class StatisticsServiceImpl {

	private StatisticsDao statisticsDao;
	
	@Autowired
	public void setSqlSession(SqlSession sqlSession){
		this.statisticsDao = sqlSession.getMapper(kr.pe.lahuman.service.statistics.StatisticsDao.class);
	}
	
	public List<DataMap<String, Object>> service(DataMap<String, Object> param){
		return statisticsDao.service(param);
	}
	public List<DataMap<String, Object>> tagCloudService(DataMap<String, Object> param){
		return statisticsDao.tagCloudService(param);
	}
	public List<DataMap<String, Object>> tagCloudCategory(DataMap<String, Object> param){
		return statisticsDao.tagCloudCategory(param);
	}
	public List<DataMap<String, Object>> event(DataMap<String, Object> param){
		return statisticsDao.event(param);
	}
	public List<DataMap<String, Object>> ganttChart(DataMap<String, Object> param){
		return statisticsDao.ganttChart(param);
	}
	public List<DataMap<String, Object>> ganttChart2(DataMap<String, Object> param){
		return statisticsDao.ganttChart2(param);
	}
}
