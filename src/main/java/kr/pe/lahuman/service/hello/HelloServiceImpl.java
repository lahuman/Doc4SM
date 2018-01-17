package kr.pe.lahuman.service.hello;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class HelloServiceImpl implements HelloService{

	private HelloDao helloDao;
	
	@Autowired
	public void setSqlSession(SqlSession sqlSession){
		// 이부분에서 이렇게 사용 하였으나, 다른 방법도 있음
		this.helloDao = sqlSession.getMapper(kr.pe.lahuman.service.hello.HelloDao.class);
	}
	@Override
	public String getData(AuthorsVO vo) throws Exception{
		return vo.toString();
	}


	@Override
	@Transactional(rollbackFor=Exception.class) //anotation을 사용할 경우
	public String insert2Error(AuthorsVO vo) throws Exception {
		helloDao.insert(vo);
		helloDao.insert(vo);
		helloDao.insert(vo);
		helloDao.insert(vo);
		helloDao.insert(vo);
		helloDao.insert(vo);
		
		throw new Exception("Insert Error");
		
	}


	@Override
	public String insert(AuthorsVO vo) throws Exception {
		return helloDao.insert(vo)+"";
	}


	@Override
	public List<AuthorsVO> getList() throws Exception {
		return helloDao.getList();
	}


	@Override
	public void deleteAllData() throws Exception {
		helloDao.deleteAllData();
	}
	
}
