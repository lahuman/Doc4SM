package kr.pe.lahuman.service.report;

import java.io.BufferedOutputStream;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.xml.bind.JAXBException;

import kr.pe.lahuman.excel.ExcelUtil;
import kr.pe.lahuman.service.call.CallServiceImpl;
import kr.pe.lahuman.service.event.EventServiceImpl;
import kr.pe.lahuman.service.infra.InfraServiceImpl;
import kr.pe.lahuman.service.problem.ProblemServiceImpl;
import kr.pe.lahuman.service.svn.VersionManagerController;
import kr.pe.lahuman.utils.Constants;
import kr.pe.lahuman.utils.DataMap;
import kr.pe.lahuman.utils.DateUtil;
import kr.pe.lahuman.utils.Utils;

import org.docx4j.Docx4J;
import org.docx4j.XmlUtils;
import org.docx4j.model.datastorage.migration.VariablePrepare;
import org.docx4j.openpackaging.exceptions.Docx4JException;
import org.docx4j.openpackaging.packages.WordprocessingMLPackage;
import org.docx4j.openpackaging.parts.WordprocessingML.MainDocumentPart;
import org.docx4j.wml.Document;
import org.docx4j.wml.Text;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.spockframework.gentyref.TypeToken;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;

@Controller
public class ReportController {
	private Logger log = LoggerFactory.getLogger(ReportController.class);

	@Autowired
	private ReportServiceImpl reportService;
	@Autowired
	private EventServiceImpl eventService;
	@Autowired
	private CallServiceImpl callService;
	@Autowired
	private InfraServiceImpl infraService;
	@Autowired
	private ProblemServiceImpl problemService;
	
	
	@RequestMapping(value = "/{type}/report/vacation.do", method = RequestMethod.GET)
	public String vacation(@PathVariable("type")String type){
		return type+"/report/vacation";
	}
	
	
	@RequestMapping(value = "/{type}/report/event.do", method = RequestMethod.GET)
	public String event(@PathVariable("type")String type){
		return type+"/report/event";
	}
	
	@RequestMapping(value = "/{type}/report/event.json", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> eventJson(HttpServletRequest request){
		DataMap<String, Object> paramMap = Utils.makePagingMap(request);
		Gson gson = new Gson();
		DataMap<String, Object> keyworkd = gson.fromJson(request.getParameter("param"), new TypeToken<DataMap<String, Object>>(){}.getType());
		if(keyworkd != null)
			paramMap.putAll(keyworkd);
		return eventService.getList(paramMap);
	}
	
	
	@RequestMapping(value = "/{type}/report/call.do", method = RequestMethod.GET)
	public String call(@PathVariable("type")String type){
		return type+"/report/call";
	}


	@RequestMapping(value = "/{type}/report/call.json", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> callJson(HttpServletRequest request){
		DataMap<String, Object> paramMap = Utils.makePagingMap(request);
		Gson gson = new Gson();
		DataMap<String, Object> keyworkd = gson.fromJson(request.getParameter("param"), new TypeToken<DataMap<String, Object>>(){}.getType());
		if(keyworkd != null)
			paramMap.putAll(keyworkd);
		return callService.getList(paramMap);
	}
	
	@RequestMapping(value = "/{type}/report/infra.do", method = RequestMethod.GET)
	public String infra(@PathVariable("type")String type){
		return type+"/report/infra";
	}

	@RequestMapping(value = "/{type}/infra/infra.json", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> infraJson(HttpServletRequest request){
		DataMap<String, Object> paramMap = Utils.makePagingMap(request);
		Gson gson = new Gson();
		DataMap<String, Object> keyworkd = gson.fromJson(request.getParameter("param"), new TypeToken<DataMap<String, Object>>(){}.getType());
		if(keyworkd != null)
			paramMap.putAll(keyworkd);
		return infraService.getList(paramMap);
	}
	
	
	@RequestMapping(value = "/{type}/report/problem.do", method = RequestMethod.GET)
	public String problem(@PathVariable("type")String type){
		return type+"/report/problem";
	}

	@RequestMapping(value = "/{type}/infra/problem.json", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> problemJson(HttpServletRequest request){
		DataMap<String, Object> paramMap = Utils.makePagingMap(request);
		Gson gson = new Gson();
		DataMap<String, Object> keyworkd = gson.fromJson(request.getParameter("param"), new TypeToken<DataMap<String, Object>>(){}.getType());
		if(keyworkd != null)
			paramMap.putAll(keyworkd);
		return problemService.getList(paramMap);
	}
	
	
	@RequestMapping(value = "/{type}/report/daily.do", method = RequestMethod.GET)
	public String getFile(@PathVariable("type")String type) {
	    return type+"/report/daily";
	}
	
	
	@RequestMapping(value = "/{type}/report/meeting.do", method = RequestMethod.GET)
	public String meeting(@PathVariable("type")String type){
		return type+"/report/meeting";
	}
	
	@RequestMapping(value = "/{type}/report/external.do", method = RequestMethod.GET)
	public String external(@PathVariable("type")String type){
		return type+"/report/external";
	}

	
	@RequestMapping(value = "/{type}/report/slm.do", method = RequestMethod.GET)
	public String slm(@PathVariable("type")String type) {
	    return type+"/report/slm";
	}
	
//	private static final int BUFFER_SIZE = 4096;
//    private static org.docx4j.wml.ObjectFactory factory = new org.docx4j.wml.ObjectFactory();
	 /**
     * Method for handling file download request from client
	 * @throws Exception 
     */
    @RequestMapping(value = "/files/{file_name}",method = RequestMethod.GET)
    public void doDownload(@PathVariable("file_name") String fileName,HttpServletRequest request,
            HttpServletResponse response) throws Exception {
    	DataMap<String, Object> data = new DataMap<String, Object>();
    	String reportKind = "";
    	String ouputFileName = "";
    	if("event".equals(fileName)){
    		data.put("REQ_CODE", request.getParameter("REQ_CODE"));
    		data = reportService.event(data);
    		reportKind = Constants.getValue("report."+data.getString("PROC_TYPE"));
    		if("EV00".equals(data.getString("PROC_TYPE"))){
    			if("C".equals(data.getString("REQ_TYPE")))
    				reportKind = "REQ_CHANGE.docx";
    			if("O".equals(data.getString("REQ_TYPE")))
    				reportKind = "REQ_OBSTACLE.docx";
    		}
    		ouputFileName = Constants.getValue("report.beginFileName")+data.getString("REQ_CODE")+"_"+getOutputFileName(data)+"_"+reportKind;
    		
    	}else if("dailyReport".equals(fileName)){
    		data.put("DATE", request.getParameter("DATE"));
    		data.put("lastDt", request.getParameter("lastDt"));
    		data = reportService.daily(data);
    		reportKind = Constants.getValue("report.daily");
    		ouputFileName = request.getParameter("DATE")+"_"+reportKind;
    	}else if("problem".equals(fileName)){
    		data.put("PROBLEM_ID", request.getParameter("PROBLEM_ID"));
    		data = reportService.problem(data);
    		reportKind = Constants.getValue("report.problem."+request.getParameter("STATUS"));
    		ouputFileName = "PMT_"+request.getParameter("PROBLEM_ID")+"_"+getOutputFileName(data)+"_"+reportKind;
    	}else if("infra".equals(fileName)){
    		data.put("ID", request.getParameter("ID"));
    		data.put("YEAR", request.getParameter("YEAR"));
    		data = reportService.infra(data);
    		String type = (data.getString("TYPE").indexOf("H1") != -1)?"HW":"SW";
    		reportKind = Constants.getValue("report.infra."+type);
    		ouputFileName = data.getString("DIVISION")+"_"+data.getString("RESOURCE_NUM")+"_"+data.getString("USE_TITLE")+"_"+reportKind;
    	}else if("infraList".equals(fileName)){
    		Gson gson = new Gson();
    		DataMap<String, Object> keyworkd = gson.fromJson(request.getParameter("param"), new TypeToken<DataMap<String, Object>>(){}.getType());
    		String[] keys = {"DIVISION", "USE_TITLE","OWN_GROUP", "OFFER_USER",  "MARK_NAME", "MODEL_NAME", "SERVICE_STATUS", "EMERGENCY_TYPE",   "REGISTER_DT"};
    		String[] titles = {"구분", "용도", "소유기관", "책임자", "담당자", "모델명", "상태", "중요도", "등록일"};
    		ExcelUtil.makeExcel(response, "infra_list.xls", "시설 관리 대장", titles, keys, reportService.infraList(keyworkd));
    		return;
    	}else if("callReport".equals(fileName)){
    		Gson gson = new Gson();
    		DataMap<String, Object> keyworkd = gson.fromJson(request.getParameter("param"), new TypeToken<DataMap<String, Object>>(){}.getType());
    		String[] keys = {"CATEGORY_NM", "USER", "USER_ID", "CONTENTS", "START_DT", "END_DT"};
    		String[] titles = {"서비스-카테고리", "요청자", "담당자", "내역", "시작일", "종료일"};
    		ExcelUtil.makeExcel(response, "call_report.xls", "CALL 대장", titles, keys, reportService.call(keyworkd));
    		return;
    	}else if("eventListReport".equals(fileName)){
    		Gson gson = new Gson();
    		DataMap<String, Object> keyworkd = gson.fromJson(request.getParameter("param"), new TypeToken<DataMap<String, Object>>(){}.getType());
    		String[] keys = {"REQ_CODE", "CATEGORY", "PROCES_TYPE", "MENU", "REQ_DT", "USER",  "COMPLETE_DT", "PROC_USER","SPEND_TIME",  "DIFF_DAY", "STATUS", "REQ_TITLE", "RESULT"};
    		String[] titles = {"접수번호", "서비스 카달로그", "서비스 구분", "메뉴명",  "요청일", "요청자", "처리일", "처리담당자","소요시간", "요청적기율", "처리상태", "요청내역",  "처리내역"};
    		ExcelUtil.makeExcel(response, "event_report.xls", "EVENT 대장", titles, keys, reportService.eventList(keyworkd));
    		return;
    	}else if("meeting".equals(fileName)){
    		data.put("ID", request.getParameter("ID"));
    		data = reportService.meeting(data);
    		reportKind = Constants.getValue("report.meeting");
    		ouputFileName = data.getString("MEET_DT")+"_"+"_"+data.getString("TITLE")+reportKind;
    	}else if("vacationReport".equals(fileName)){
    		data.put("ID", request.getParameter("ID"));
    		data = reportService.vacation(data);
    		reportKind = Constants.getValue("report.vacation");
    		ouputFileName = data.getString("UNAME")+"_"+data.getString("START_DT")+"_"+reportKind;
    	}else if("vacationList".equals(fileName)){
    		Gson gson = new Gson();
    		DataMap<String, Object> keyworkd = gson.fromJson(request.getParameter("param"), new TypeToken<DataMap<String, Object>>(){}.getType());
    		String[] keys = {"VACATION_USER", "AGENT_USER", "VACATION_KIND", "DETAIL", "START_DT", "END_DT", "VACATION_DT"};
    		String[] titles = {"휴가자", "대행자", "휴가종류", "세부내역", "시작일", "종료일", "휴일수"};
    		ExcelUtil.makeExcel(response, "vacation_list.xls", "휴가 대장", titles, keys, reportService.vacationList(keyworkd));
    		return;
    	}else if("externalWorkReport".equals(fileName)){
    		Gson gson = new Gson();
    		DataMap<String, Object> keyworkd = gson.fromJson(request.getParameter("param"), new TypeToken<DataMap<String, Object>>(){}.getType());
    		String[] keys = {"WORK_TYPE", "WORK_NAME", "COMPANY_NAME", "WORKER", "USER", "MANAGER", "WORK_ST", "WORK_ET", "TARGET"};
    		String[] titles = {"업무 구분", "작업명", "회사명", "작업자",  "기상청담당자", "업무관리자", "시작일시", "종료일시", "대상 시스템"};
    		ExcelUtil.makeExcel(response, "external_report.xls", "외부작업 대장", titles, keys, reportService.external(keyworkd));
    		return;
    	}else if("slm".equals(fileName)){
    		data.put("DATE", request.getParameter("DATE"));
    		data.put("start_time", request.getParameter("DATE")+"010000");
    		data.put("end_time", request.getParameter("DATE")+"320000");
    		data = reportService.slmReport(data);
    		reportKind = Constants.getValue("report.slm");
    		ouputFileName = request.getParameter("DATE")+"_SLM_REPORT_"+reportKind;
    	}else{
    		return;
    	}
	
    	// set Department name
    	data.put("DEPARTMENT_NAME",  Constants.getValue("department.name"));
    	
        // get absolute path of the application
        ServletContext context = request.getServletContext();
        String sourcePath = Constants.getValue("report.sourcePath")+reportKind;      

        
        WordprocessingMLPackage wordMLPackage = WordprocessingMLPackage
				.load(new java.io.File(sourcePath));
		MainDocumentPart documentPart = wordMLPackage.getMainDocumentPart();
//		HashMap<String, Object> mappings = new HashMap<String, Object>();
//		mappings.putAll(data);
//		System.out.println(XmlUtils.marshaltoString(wordMLPackage.getMainDocumentPart().getJaxbElement(), true, true));
		VariablePrepare.prepare(wordMLPackage);
//		System.out.println(XmlUtils.marshaltoString(wordMLPackage.getMainDocumentPart().getJaxbElement(), true, true));
		//20140708 office 2013 에서 줄바꿈이 안되서 아래 방식으로 변경
//		documentPart.variableReplace(mappings);
		
		String resultXml = XmlUtils.marshaltoString(wordMLPackage.getMainDocumentPart().getJaxbElement(), true, true);
		String[] keys = data.getKeys();
		for(String key : keys){
			String mappingString = removeSpacialChar(data, key);
			resultXml = resultXml.replaceAll("\\$\\{"+key+"\\}", mappingString );
		}
		documentPart.setJaxbElement((Document) XmlUtils.unmarshalString(resultXml));
		
        
		//add problem_Relation
		if("problem".equals(fileName)){
			addProblemRelation(request.getParameter("PROBLEM_ID"), documentPart);
		}else if("event".equals(fileName)){
			addEventOtherInfo(data, documentPart);
		}
		
        // get MIME type of the file
        String mimeType = context.getMimeType(sourcePath);
        if (mimeType == null) {
            // set to binary type if MIME mapping not found
            mimeType = "application/octet-stream";
        }
//        System.out.println("MIME type: " + mimeType);
 
        // set content attributes for the response
        response.setContentType(mimeType);
 
        // set headers for the response
        String headerKey = "Content-Disposition";
        String headerValue = String.format("attachment; filename=\"%s\"",
        		URLEncoder.encode(ouputFileName,"UTF-8"));
        response.setHeader(headerKey, headerValue);
 
        BufferedOutputStream out = new BufferedOutputStream(response.getOutputStream());
        Docx4J.save(wordMLPackage, out, 0);
        
    }


private String getOutputFileName(DataMap<String, Object> data) {
	String replaceAllStr = data.getString("REQ_TITLE").replaceAll("\\r\\n", "");
	return replaceAllStr.substring(0, (replaceAllStr.length()>20)?20:replaceAllStr.length());
}

    
    
	private void addEventOtherInfo(DataMap<String, Object> dataMap,
			MainDocumentPart docDest) throws Exception {
		addDailyWorkList(dataMap, docDest);
		addChangeFileList(dataMap, docDest);
	}

	final String enterChar = "\r\n";
	private void addDailyWorkList(DataMap<String, Object> dataMap,
			MainDocumentPart docDest) throws JAXBException, Exception {
		List<DataMap<String, Object>> dailyList = eventService.getCommentList(dataMap);
		if(dailyList == null || dailyList.size() == 0)
			return ;
		WordprocessingMLPackage wordMLPackage = WordprocessingMLPackage
				.load(new java.io.File(Constants.getValue("report.sourcePath")+Constants.getValue("report.dailywork.file.info")));
		MainDocumentPart documentPart = wordMLPackage.getMainDocumentPart();
		DataMap<String, Object> dailyWorks = new DataMap<String, Object>();
		StringBuilder sb = new StringBuilder();
		for(DataMap<String, Object> data : dailyList){
			sb.append("[");
			sb.append(DateUtil.converterFormatDate(data.getString("req_dt"), "-"));
			sb.append(" ");
			sb.append(data.getString("user_name"));
			sb.append("]");
			sb.append(data.getString("comment"));
			sb.append(enterChar);
		}
		dailyWorks.put("DAILY_WORK_LIST", sb.toString());
		replaceData(docDest, dailyWorks, wordMLPackage, documentPart);	
	}


	private void addChangeFileList(DataMap<String, Object> dataMap,
			MainDocumentPart docDest) throws Docx4JException, Exception,
			JAXBException {
		List<DataMap<String, Object>> versionList = reportService.versionInfo(dataMap);
		VersionManagerController vc =  new VersionManagerController();
		for(DataMap<String, Object> data : versionList){
			WordprocessingMLPackage wordMLPackage = WordprocessingMLPackage
					.load(new java.io.File(Constants.getValue("report.sourcePath")+Constants.getValue("report.change.file.info")));
			MainDocumentPart documentPart = wordMLPackage.getMainDocumentPart();
			//SVN 변경 정보를 가져와서 FILE_LIST에 추가 한다.
			data.put("REVISON", data.getString("SVN_VERSION"));
			List<DataMap<String, Object>> svnFileInfo = vc.getSVNFileInfo(data);
			StringBuilder sb = new StringBuilder();
			for(DataMap<String, Object> version : svnFileInfo){
				sb.append(version.getString("TYPE")+"-");
				sb.append(version.getString("PATH"));
				sb.append(enterChar);
			}
			data.put("FILE_LIST", sb.toString());
			
			replaceData(docDest, data, wordMLPackage, documentPart);		
		}
	}


	private String removeSpacialChar(DataMap<String, Object> data, String key) {
		String mappingString = data.getString(key)
				.replaceAll("<", "〈")
				.replaceAll(">", "〉")
				.replaceAll("&", "&amp;")
				.replaceAll("@", "&#64;")
				.replaceAll("\\$", "&#36;")
				.replaceAll("\\?", "&#63;")
				.replaceAll("\\r\\n", "</w:t></w:r><w:r><w:rPr><w:rFonts w:ascii=\"굴림체\" w:hAnsi=\"굴림체\" w:eastAsia=\"굴림체\"/></w:rPr><w:br/></w:r><w:r><w:rPr><w:rFonts w:hint=\"eastAsia\" w:ascii=\"굴림체\" w:hAnsi=\"굴림체\" w:eastAsia=\"굴림체\"/><w:sz w:val=\"18\"/><w:szCs w:val=\"18\"/></w:rPr><w:t>");
		return mappingString;
	}

	public void replaceUSRComments(List<Object> texts, String replaceWith,
			String placeholder) {
		for (Object text : texts) {
			Text textElement = (Text) text;
			if (textElement.getValue().equals(placeholder)) {
				textElement.setValue(replaceWith);
			}
		}
	}
    
	private void addProblemRelation(String problemId,
			MainDocumentPart docDest) throws Exception {
		DataMap<String, Object> dataMap = new DataMap<String, Object>();
		dataMap.put("problem_id", problemId);
			List<DataMap<String, Object>> relationList = reportService.problemRelation(dataMap);
			for(DataMap<String, Object> data : relationList){
				WordprocessingMLPackage wordMLPackage = WordprocessingMLPackage
						.load(new java.io.File(Constants.getValue("report.sourcePath")+Constants.getValue("report.problem.relation")));
				MainDocumentPart documentPart = wordMLPackage.getMainDocumentPart();
				replaceData(docDest, data, wordMLPackage, documentPart);		
			}
	}


	private void replaceData(MainDocumentPart docDest,
			DataMap<String, Object> data,
			WordprocessingMLPackage wordMLPackage, MainDocumentPart documentPart)
			throws Exception, JAXBException {
		VariablePrepare.prepare(wordMLPackage);
//				documentPart.variableReplace(mappings);
		String resultXml = XmlUtils.marshaltoString(wordMLPackage.getMainDocumentPart().getJaxbElement(), true, true);
		String[] keys = data.getKeys();
		for(String key : keys){
			String mappingString = removeSpacialChar(data, key);
			
			resultXml = resultXml.replaceAll("\\$\\{"+key+"\\}", mappingString );
		}
		documentPart.setJaxbElement((Document) XmlUtils.unmarshalString(resultXml));
		
		List<Object> objects = documentPart.getContent();
		for(Object o : objects){
			docDest.getContent().add(o);
		}
	}
	
}