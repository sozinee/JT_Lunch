package egovframework.jtLunch.admin.dashboard.DAO;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import egovframework.jtLunch.main.reservation.DTO.DivisionDTO;

@Repository("DivisionDAO")
public class DivisionDAO {
	
	@Autowired
	private SqlSession sqlSession;
	
	public int InsertDepartment(String department) throws Exception{
		return sqlSession.insert("division.InsertDepartment", department);
	}
	
	public int InsertDepartmentTeam(DivisionDTO dto) throws Exception{
		return sqlSession.insert("division.InsertDepartmentTeam", dto);
	}
	
	public int UpdateDepartment(DivisionDTO dto) throws Exception{
		return sqlSession.update("division.UpdateDepartment", dto);
	}
	
	public int UpdateTeam(DivisionDTO dto) throws Exception{
		return sqlSession.update("division.UpdateTeam", dto);
	}
	
	public int UpdateUserDepartment(DivisionDTO dto) throws Exception{
		return sqlSession.update("division.UpdateUserDepartment", dto);
	}
	
	public int UpdateUserTeam(DivisionDTO dto) throws Exception{
		return sqlSession.update("division.UpdateUserTeam", dto);
	}
}
