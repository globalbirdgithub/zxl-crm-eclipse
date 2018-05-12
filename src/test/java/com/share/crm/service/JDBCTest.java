package com.share.crm.service;

import javax.sql.DataSource;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

/**连接数据库测试
 * @author MrZhang 
 * @date 2018年5月10日 下午1:08:32
 * @version V1.0
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("classpath:applicationContext.xml")
public class JDBCTest {
	@Autowired
	DataSource dataSource;
	
	@Test
	public void JDBC() throws Exception {
		System.out.println(dataSource.getConnection());
	}
}
