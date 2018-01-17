package kr.pe.lahuman.service.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import kr.pe.lahuman.utils.Constants;
import kr.pe.lahuman.utils.DataMap;
import kr.pe.lahuman.utils.Utils;

import org.spockframework.gentyref.TypeToken;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;

@Controller
public class ServiceController {
	@Autowired
	private ServiceImpl service;
	
	@RequestMapping(value = "/admin/service.do", method = RequestMethod.GET)
	public String view(){
		return "admin/service/list";
	}

	@RequestMapping(value = "/admin/pop/category.do", method = RequestMethod.GET)
	public String popup(){
		return "admin/service/pop";
	}
	
	@RequestMapping(value = "/admin/service/list.json", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> getList(HttpServletRequest request){
		DataMap<String, Object> paramMap = Utils.makePagingMap(request);
		return service.getList(paramMap);
	}
	
	@RequestMapping(value = "/admin/service/process.do", method = RequestMethod.POST)
	public @ResponseBody DataMap<String, Object> process(HttpServletRequest request){
		Gson gson = new Gson();
		List<DataMap<String, Object>> paramList = gson.fromJson(request.getParameter("param"), new TypeToken<ArrayList<DataMap<String, Object>>>(){}.getType());
		
		String message = service.process(paramList);
		
		DataMap<String, Object> responseMessage = new DataMap<String, Object>();
		if(!"".equals(message )){
			responseMessage.put(Constants.STATUS, Constants.ERROR);
			responseMessage.put(Constants.MESSAGE, "["+message+"] 처리에 실패 하였습니다. 데이터를 확인 하여 주세요.");
		}else{
			responseMessage.put(Constants.STATUS, Constants.SUCCESS);
		}
		return responseMessage;
	}
	
	@RequestMapping(value = "/{type}/service/serviceList.json", method = RequestMethod.POST)
	public @ResponseBody List<DataMap<String, Object>> getServiceList(HttpServletRequest request){
		DataMap<String, Object> param = new DataMap<String, Object>();
		param.put("USE_YN", request.getParameter("USE_YN"));
		return service.serviceList(param);
	}
	
	@RequestMapping(value = "/{type}/service/categoryList.json", method = RequestMethod.POST)
	public @ResponseBody List<DataMap<String, Object>> getCategoryList(HttpServletRequest request){
		DataMap<String, Object> param = new DataMap<String, Object>();
		param.put("SERVICE_ID", request.getParameter("SERVICE_ID"));
		return service.categoryList(param);
	}
	
	
	@RequestMapping(value = "/{type}/service/serviceCategoryList.json", method = RequestMethod.POST)
	public @ResponseBody List<DataMap<String, Object>> getServiceCategoryList(HttpServletRequest request){
		return service.serviceCategoryList(null);
	}
	
	
	
	@RequestMapping(value = "/{type}/service/processCategory.do", method = RequestMethod.POST)
	public @ResponseBody DataMap<String, Object> processContract(HttpServletRequest request){
		
		Gson gson = new Gson();
		List<DataMap<String, Object>> paramList = gson.fromJson(request.getParameter("param"), new TypeToken<ArrayList<DataMap<String, Object>>>(){}.getType());
		String message = service.processCategory(paramList);
		
		DataMap<String, Object> responseMessage = new DataMap<String, Object>();
		if(!"".equals(message )){
			responseMessage.put(Constants.STATUS, Constants.ERROR);
			responseMessage.put(Constants.MESSAGE, "["+message+"] 처리에 실패 하였습니다. 데이터를 확인 하여 주세요.");
		}else{
			responseMessage.put(Constants.STATUS, Constants.SUCCESS);
		}
		return responseMessage;
	} 
}
