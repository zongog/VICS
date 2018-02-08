package store.logic;

import java.io.IOException;
import java.io.Reader;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

public class Gtu_session_factory {
	private static Gtu_session_factory instance;
	private static SqlSessionFactory sqlSessionFactory;
	private static final String resource = "config.xml";

	private Gtu_session_factory() {
	}

	public static Gtu_session_factory getinstance() {
		if (instance == null) {
			instance = new Gtu_session_factory();
		}
		return instance;
	}

	public SqlSession getSession() {
		if (sqlSessionFactory == null) {
			Reader reader = null;
			try {
				reader = Resources.getResourceAsReader(resource);
			} catch (IOException e) {
				e.printStackTrace();
			}

			sqlSessionFactory = new SqlSessionFactoryBuilder().build(reader);
		}
		return sqlSessionFactory.openSession();
	}

}
