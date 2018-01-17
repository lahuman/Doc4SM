package kr.pe.lahuman.service.report;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import kr.pe.lahuman.utils.DataMap;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service(value="reportService")
public class ReportServiceImpl {

	private ReportDao reportDao;

	
	@Autowired
	public void setSqlSession(SqlSession sqlSession){
		this.reportDao = sqlSession.getMapper(kr.pe.lahuman.service.report.ReportDao.class);
	}
	
	public DataMap<String, Object> event(DataMap<String, Object> param){
		param.put("INFRA_IDS", reportDao.getInfraIds4Process(param));
		return reportDao.event(param);
	}
	public List<DataMap<String, Object>> call(DataMap<String, Object> param){
		return reportDao.call(param);
	}
	
	public List<DataMap<String, Object>> infraList(DataMap<String, Object> param){
		return reportDao.infraList(param);
	}
	public DataMap<String, Object> infra(DataMap<String, Object> param){
		return reportDao.infra(param);
	}
	
	public DataMap<String, Object> daily(DataMap<String, Object> param){
		return reportDao.daily(param);
	}
	public DataMap<String, Object> problem(DataMap<String, Object> param){
		return reportDao.problem(param);
	}
	public DataMap<String, Object> meeting(DataMap<String, Object> param){
		return reportDao.meeting(param);
	}
	public List<DataMap<String, Object>> problemRelation(DataMap<String, Object> param){
		return reportDao.problemRelation(param);
	}
	
	public List<DataMap<String, Object>> eventList(DataMap<String, Object> param){
		return reportDao.eventList(param);
	}
	public List<DataMap<String, Object>> versionInfo(DataMap<String, Object> param){
		return reportDao.versionInfo(param);
	}
	public List<DataMap<String, Object>> vacationList(DataMap<String, Object> param){
		return reportDao.vacationList(param);
	}
	public DataMap<String, Object> vacation(DataMap<String, Object> param){
		return reportDao.vacation(param);
	}
	public List<DataMap<String, Object>> external(DataMap<String, Object> param){
		return reportDao.external(param);
	}
	
	public DataMap<String, Object> slmReport(DataMap<String, Object> param){
		DataMap<String, Object> slmReportMap = new DataMap<String, Object>();
		slmReportMap.put("date", param.getString("DATE"));
		
		//1. 구성관리 현황
		slmReportMap.putAll(reportDao.infrastructureInfo(null));
		
		//2. 등급별 장애 현황
		param.put("type", "HW");
		slmReportMap.putAll(reportDao.obstacle4CountNTime(param));
		slmReportMap.putAll(reportDao.obstacle4LevelCountNTime(param));
		
		param.put("type", "SW");
		slmReportMap.putAll(reportDao.obstacle4CountNTime(param));
		slmReportMap.putAll(reportDao.obstacle4LevelCountNTime(param));
		
		//합계 처리
		slmReportMap.put("HS_CNT", (slmReportMap.getInt("H_CNT")+slmReportMap.getInt("S_CNT"))+"");
		slmReportMap.put("HS_E001", (slmReportMap.getInt("H_E001")+slmReportMap.getInt("S_E001"))+"");
		slmReportMap.put("HS_E002", (slmReportMap.getInt("H_E002")+slmReportMap.getInt("S_E002"))+"");
		slmReportMap.put("HS_E003", (slmReportMap.getInt("H_E003")+slmReportMap.getInt("S_E003"))+"");
		slmReportMap.put("HS_E004", (slmReportMap.getInt("H_E004")+slmReportMap.getInt("S_E004"))+"");
		
		
		//3. 시설별 장애 현황
		param.put("isProblem", "N");
		slmReportMap.putAll(reportDao.obstacle4Kind(param));
		param.put("isProblem", "Y");
		slmReportMap.putAll(reportDao.obstacle4Kind(param));
		
		//4. 조치 시간별 장애 현황
		slmReportMap.putAll(reportDao.obstacle4Time(param));
		
		//5. 등급별 변경 현황
		slmReportMap.putAll(reportDao.change4CountTime(param));
		param.put("type", "HW");
		slmReportMap.putAll(reportDao.change4CountTime(param));
		
		//합계 처리
		slmReportMap.put("CHS_S", (slmReportMap.getInt("CH_S")+slmReportMap.getInt("CS_S"))+"");
		slmReportMap.put("CHS_F", (slmReportMap.getInt("CH_F")+slmReportMap.getInt("CS_F"))+"");
		slmReportMap.put("CHS_C", (slmReportMap.getInt("CH_C")+slmReportMap.getInt("CS_C"))+"");
		slmReportMap.put("CHS_E001", (slmReportMap.getInt("CH_E001")+slmReportMap.getInt("CS_E001"))+"");
		slmReportMap.put("CHS_E002", (slmReportMap.getInt("CH_E002")+slmReportMap.getInt("CS_E002"))+"");
		slmReportMap.put("CHS_E003", (slmReportMap.getInt("CH_E003")+slmReportMap.getInt("CS_E003"))+"");
		slmReportMap.put("CHS_E004", (slmReportMap.getInt("CH_E004")+slmReportMap.getInt("CS_E004"))+"");
		slmReportMap.put("CHS_E005", (slmReportMap.getInt("CH_E005")+slmReportMap.getInt("CS_E005"))+"");
		
		//6.변경 대상별 비율
		slmReportMap.putAll(reportDao.change4KindOfUser(param));
		slmReportMap.putAll(reportDao.change4KindOfOutside(param));
		//합계 처리
		slmReportMap.put("UO_H101", (slmReportMap.getInt("U_H101")+slmReportMap.getInt("O_H101"))+"");
		slmReportMap.put("UO_H102", (slmReportMap.getInt("U_H102")+slmReportMap.getInt("O_H102"))+"");
		slmReportMap.put("UO_H103", (slmReportMap.getInt("U_H103")+slmReportMap.getInt("O_H103"))+"");
		slmReportMap.put("UO_H104", (slmReportMap.getInt("U_H104")+slmReportMap.getInt("O_H104"))+"");

		slmReportMap.put("UO_H201", (slmReportMap.getInt("U_H201")+slmReportMap.getInt("O_H201"))+"");
		slmReportMap.put("UO_H202", (slmReportMap.getInt("U_H202")+slmReportMap.getInt("O_H202"))+"");
		slmReportMap.put("UO_H203", (slmReportMap.getInt("U_H203")+slmReportMap.getInt("O_H203"))+"");
		
		
		//7.측정 결과
		slmReportMap.putAll(reportDao.serviceAvailability(param));
		slmReportMap.putAll(reportDao.systemNnetworkAvailability(param));
		slmReportMap.putAll(reportDao.obstacleAverageTime(param));
		slmReportMap.putAll(reportDao.obstacleAverageCount(param));
		
		
		//전월 데이터 처리
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMM");
	    Calendar cal = Calendar.getInstance();
	    try {
			cal.setTime(sdf.parse(param.getString("date")));
		} catch (ParseException e) {
			e.printStackTrace();
		}
	    cal.add(Calendar.MONTH, -1);
	    String beforeDate=sdf.format(cal.getTime());
		param.put("start_time", beforeDate+"010000");
		param.put("end_time", beforeDate+"320000");
		slmReportMap.put("B_SA_VAL", reportDao.serviceAvailability(param).getString("SA_VAL"));
		DataMap<String, Object> tmpDataMap = reportDao.systemNnetworkAvailability(param);
		
		slmReportMap.put("B_SY_VAL", tmpDataMap.getString("SY_VAL"));
		slmReportMap.put("B_NE_VAL", tmpDataMap.getString("NE_VAL"));;
		slmReportMap.put("B_OR_TIME", reportDao.obstacleAverageTime(param).getString("OR_TIME"));
		slmReportMap.put("B_OS_CNT", reportDao.obstacleAverageCount(param).getString("OS_CNT"));
		
		
		
		//환산점수 계 처리
		double totalResult = slmReportMap.getDouble("SA_RESULT") +slmReportMap.getDouble("OS_RESULT") + slmReportMap.getDouble("OR_RESULT")+slmReportMap.getDouble("SY_RESULT")+slmReportMap.getDouble("NE_RESULT");
		
		if(totalResult == 100 ){
			slmReportMap.put("TOT_CLASS", "S");
		}else if(totalResult > 90 ){
			slmReportMap.put("TOT_CLASS", "A");
		}else if(totalResult > 80 ){
			slmReportMap.put("TOT_CLASS", "B");
		}else if(totalResult > 70 ){
			slmReportMap.put("TOT_CLASS", "C");
		}else {
			slmReportMap.put("TOT_CLASS", "D");
		}
		
		slmReportMap.put("TOT_RESULT", totalResult+"");
		
		//서비스 적기율 추가
		slmReportMap.putAll(reportDao.service4Day(param));
		
		return slmReportMap;
	}
}
