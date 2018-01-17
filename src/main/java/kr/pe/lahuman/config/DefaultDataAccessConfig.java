package kr.pe.lahuman.config;

import java.beans.PropertyVetoException;

import javax.sql.DataSource;

import kr.pe.lahuman.utils.Constants;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.mybatis.spring.SqlSessionFactoryBean;
import org.mybatis.spring.SqlSessionTemplate;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.io.support.PathMatchingResourcePatternResolver;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;
import org.springframework.transaction.PlatformTransactionManager;
import org.springframework.transaction.annotation.EnableTransactionManagement;
import org.springframework.transaction.annotation.TransactionManagementConfigurer;

import com.mchange.v2.c3p0.ComboPooledDataSource;

@Configuration
@EnableTransactionManagement
public class DefaultDataAccessConfig implements TransactionManagementConfigurer {


	private Logger log = LoggerFactory.getLogger(DefaultDataAccessConfig.class);
	
	@Override
	public PlatformTransactionManager annotationDrivenTransactionManager() {
		return new DataSourceTransactionManager(dataSource());
	}


	@Bean
	public DataSource dataSource() {
		ComboPooledDataSource  dataSource = new ComboPooledDataSource();
		try {
			dataSource.setDriverClass(Constants.getValue("db.driverClass"));
		} catch (PropertyVetoException e) {
			 throw new RuntimeException(e);
		}
		dataSource.setJdbcUrl(Constants.getValue("db.jdbcUrl"));
		dataSource.setUser(Constants.getValue("db.user"));
		dataSource.setPassword(Constants.getValue("db.password"));
		dataSource.setPreferredTestQuery("select 1");
		dataSource.setMinPoolSize(3);
		dataSource.setMaxPoolSize(20);
		dataSource.setIdleConnectionTestPeriod(300);
		dataSource.setMaxIdleTimeExcessConnections(240);
		dataSource.setAcquireIncrement(1);
		return dataSource;
	}

	@Bean
	public SqlSessionFactory sqlSessionFactory() throws Exception {
		SqlSessionFactoryBean sf = new SqlSessionFactoryBean();
		sf.setMapperLocations(new PathMatchingResourcePatternResolver().getResources("classpath*:sql/mybatis/mapper/**/*.xml") );
        sf.setDataSource(dataSource());    
        try {
            return (SqlSessionFactory) sf.getObject();
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
	}

	@Bean
    public SqlSession sqlSessionTemplate() throws Exception {
        return new SqlSessionTemplate(sqlSessionFactory());
    }    
	
	@Bean
	public SqlSession sqlSession() throws Exception{
		return new SqlSessionTemplate(sqlSessionFactory());
	}
}
