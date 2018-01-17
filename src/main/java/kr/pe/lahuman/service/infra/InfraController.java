package kr.pe.lahuman.service.infra;

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
public class InfraController {

	@Autowired
	private InfraServiceImpl infraService;
	
	@RequestMapping(value = "/admin/infra/pop/addInfra.do", method = RequestMethod.GET)
	public String addEvent(){
		return "admin/infra/form";
	}
	@RequestMapping(value = "/admin/infra/pop/H001Form.do", method = RequestMethod.POST)
	public String callForm(){
		return "admin/infra/H001Form";
	}
	@RequestMapping(value = "/admin/infra/pop/H002Form.do", method = RequestMethod.POST)
	public String eventForm(){
		return "admin/infra/H002Form";
	}

	@RequestMapping(value = "/admin/infra.do", method = RequestMethod.GET)
	public String view(){
		return "admin/infra/list";
	}

	@RequestMapping(value = "/{type}/infra/list.json", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> getList(HttpServletRequest request){
		DataMap<String, Object> paramMap = Utils.makePagingMap(request);
		Gson gson = new Gson();
		DataMap<String, Object> keyworkd = gson.fromJson(request.getParameter("param"), new TypeToken<DataMap<String, Object>>(){}.getType());
		if(keyworkd != null)
			paramMap.putAll(keyworkd);
		
		paramMap.put("sort", request.getParameter("sort"));
		paramMap.put("order", request.getParameter("order"));
		
		return infraService.getList(paramMap);
	}
	

	@RequestMapping(value = "/admin/infra/read.json", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> getRead(HttpServletRequest request){
		Gson gson = new Gson();
		DataMap<String, Object> paramMap = gson.fromJson(request.getParameter("param"), new TypeToken<DataMap<String, Object>>(){}.getType());
		return infraService.getRead(paramMap);
	}
	
	@RequestMapping(value = "/admin/infra/addInfra.do", method = RequestMethod.POST)
	public @ResponseBody DataMap<String, Object> process(HttpServletRequest request){
		Gson gson = new Gson();
		DataMap<String, Object> paramMap = gson.fromJson(request.getParameter("param"), new TypeToken<DataMap<String, Object>>(){}.getType());
		
		
		String message = "";
		int resultCnt = 0;
		resultCnt = infraService.marge(paramMap);
		
		if(resultCnt < 1){
			message = paramMap.getString("USE_TITLE");
		}
		
		DataMap<String, Object> responseMessage = new DataMap<String, Object>();
		if(!"".equals(message )){
			responseMessage.put(Constants.STATUS, Constants.ERROR);
			responseMessage.put(Constants.MESSAGE, "["+message+"] 처리에 실패 하였습니다. 데이터를 확인 하여 주세요.");
		}else{
			responseMessage.put(Constants.STATUS, Constants.SUCCESS);
		}
		return responseMessage;
	}
	
	@RequestMapping(value = "/admin/infra/updateManager.do", method = RequestMethod.POST)
	public @ResponseBody DataMap<String, Object> updateManager(HttpServletRequest request){
		Gson gson = new Gson();
		List<DataMap<String, Object>> paramList = gson.fromJson(request.getParameter("param"), new TypeToken<ArrayList<DataMap<String, Object>>>(){}.getType());
		
		
		String message = infraService.updateManager(paramList);
		
		DataMap<String, Object> responseMessage = new DataMap<String, Object>();
		if(!"".equals(message )){
			responseMessage.put(Constants.STATUS, Constants.ERROR);
			responseMessage.put(Constants.MESSAGE, "["+message+"] 처리에 실패 하였습니다. 데이터를 확인 하여 주세요.");
		}else{
			responseMessage.put(Constants.STATUS, Constants.SUCCESS);
		}
		return responseMessage;
	}
	
	
	@RequestMapping(value = "/admin/infra/pop/connectInfra.do", method = RequestMethod.GET)
	public String connectInfra(){
		return "admin/infra/connectInfra";
	}

	@RequestMapping(value = "/admin/infra/connectInfraList.json", method = RequestMethod.POST)
	public @ResponseBody List<Map<String, Object>> getConnectInfraList(HttpServletRequest request){
		DataMap<String, Object> paramMap = new DataMap<String, Object>();
		paramMap.put("ID", request.getParameter("ID"));
		return infraService.getConnectInfraList(paramMap);
	}
	
	@RequestMapping(value = "/{type}/infra/comboInfraList.json", method = RequestMethod.POST)
	public @ResponseBody List<Map<String, Object>> comboInfraList(HttpServletRequest request){
		return infraService.comboInfraList(null);
	}
	
	
	@RequestMapping(value = "/admin/infra/connectInfraProcess.do", method = RequestMethod.POST)
	public @ResponseBody DataMap<String, Object> connectInfraProcess(HttpServletRequest request){
		Gson gson = new Gson();
		List<DataMap<String, Object>> allData = gson.fromJson(request.getParameter("param"), new TypeToken<ArrayList<DataMap<String, Object>>>(){}.getType());
		
		String id = request.getParameter("ID");
		
		List<DataMap<String, Object>> paramList = new ArrayList<DataMap<String, Object>>();
		
		for(DataMap<String, Object> data : allData){
			if("1".equals(data.getString("JOIN_ID"))){
				DataMap<String, Object> param = new DataMap<String, Object>();
				param.put("JOIN_ID", data.getString("ID"));
				param.put("INFRA_ID", id);
				paramList.add(param);
			}
		}
		
		String message = infraService.connectInfraUpdate(id, paramList);
		
		
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
