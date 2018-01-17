package kr.pe.lahuman.service.company;

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
public class CompanyController {
	@Autowired
	private CompanyServiceImpl companyService;
	
	@RequestMapping(value = "/admin/company.do", method = RequestMethod.GET)
	public String view(){
		return "admin/company/list";
	}

	@RequestMapping(value = "/admin/pop/constract.do", method = RequestMethod.GET)
	public String popup(){
		return "admin/company/pop";
	}
	
	@RequestMapping(value = "/admin/company/list.json", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> getList(HttpServletRequest request){
		DataMap<String, Object> paramMap = Utils.makePagingMap(request);
		return companyService.getList(paramMap);
	}
	
	@RequestMapping(value = "/{type}/company/companyList.json", method = RequestMethod.POST)
	public @ResponseBody List<DataMap<String, Object>> getCompanuList(HttpServletRequest request){
		return companyService.companyList(null);
	}
	
	@RequestMapping(value = "/admin/company/process.do", method = RequestMethod.POST)
	public @ResponseBody DataMap<String, Object> process(HttpServletRequest request){
		Gson gson = new Gson();
		List<DataMap<String, Object>> paramList = gson.fromJson(request.getParameter("param"), new TypeToken<ArrayList<DataMap<String, Object>>>(){}.getType());
		
		String message = companyService.process(paramList);
		
		DataMap<String, Object> responseMessage = new DataMap<String, Object>();
		if(!"".equals(message )){
			responseMessage.put(Constants.STATUS, Constants.ERROR);
			responseMessage.put(Constants.MESSAGE, "["+message+"] 처리에 실패 하였습니다. 데이터를 확인 하여 주세요.");
		}else{
			responseMessage.put(Constants.STATUS, Constants.SUCCESS);
		}
		return responseMessage;
	}
	
	@RequestMapping(value = "/admin/company/contractList.json", method = RequestMethod.POST)
	public @ResponseBody List<DataMap<String, Object>> getContractList(HttpServletRequest request){
		DataMap<String, Object> param = new DataMap<String, Object>();
		param.put("COMPANY_ID", request.getParameter("COMPANY_ID"));
		return companyService.contractList(param);
	}
	
	@RequestMapping(value = "/admin/company/processContract.do", method = RequestMethod.POST)
	public @ResponseBody DataMap<String, Object> processContract(HttpServletRequest request){
		
		Gson gson = new Gson();
		List<DataMap<String, Object>> paramList = gson.fromJson(request.getParameter("param"), new TypeToken<ArrayList<DataMap<String, Object>>>(){}.getType());
		String message = companyService.processContract(paramList);
		
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
