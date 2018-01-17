package kr.pe.lahuman.service.monitoring;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import kr.pe.lahuman.utils.DataMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class MonitoringController {
	
	@Autowired
	private MonitoringServiceImpl monitoringService;
	
	@RequestMapping(value = "/{type}/exclue/monitoring/dashboard.do", method = RequestMethod.GET)
	public String list(@PathVariable("type")String type){
		return type+"/monitoring/dashboard";
	}

	@RequestMapping(value = "/{type}/monitoring/dashaboard.json", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> getStatus(HttpServletRequest request){
		DataMap<String, Object> paramMap = new DataMap<String, Object>();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
	    Calendar cal = Calendar.getInstance();
	    paramMap.put("today", sdf.format(cal.getTime())+"0000");
	    cal.add(Calendar.DAY_OF_MONTH, 1);
	    paramMap.put("tomorrow", sdf.format(cal.getTime())+"0000");
		return monitoringService.getStatus(paramMap);
	}
}
