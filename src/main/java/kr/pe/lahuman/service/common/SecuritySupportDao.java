package kr.pe.lahuman.service.common;

import java.util.List;
import java.util.Map;

public interface SecuritySupportDao {

	List<Map<String, Object>> getUrlNRole() throws Exception;
}
