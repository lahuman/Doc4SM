package kr.pe.lahuman.service.code;

import java.util.List;
import java.util.Map;

import kr.pe.lahuman.utils.DataMap;

public interface CodeService {

	Map<String, Object> getCodeList(DataMap<String, Object> param);
	Map<String, Object> getCodeMasterList(DataMap<String, Object> param);
	
	List<DataMap<String, Object>> getComboCodeMaster(DataMap<String, Object> param);
	List<DataMap<String, Object>> getComboCodeList(DataMap<String, Object> param);
	String processCodeMaster(List<DataMap<String, Object>> paramList);
	String processCode(List<DataMap<String, Object>> paramList);
}
