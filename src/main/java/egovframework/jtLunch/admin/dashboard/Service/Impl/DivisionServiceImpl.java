package egovframework.jtLunch.admin.dashboard.Service.Impl;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import egovframework.jtLunch.admin.dashboard.DAO.DivisionDAO;
import egovframework.jtLunch.admin.dashboard.Service.DivisionService;
import egovframework.jtLunch.main.reservation.DTO.DivisionDTO;

@Service("DivisionService")
public class DivisionServiceImpl implements DivisionService{

	@Inject
	private DivisionDAO dao;
	
	@Override
	public int InsertDepartment(String department) throws Exception{
		return dao.InsertDepartment(department);
	}
	@Override
	public int InsertDepartmentTeam(DivisionDTO dto) throws Exception{
		return dao.InsertDepartmentTeam(dto);
	}
	@Override
	public int UpdateDepartment(DivisionDTO dto) throws Exception{
		return dao.UpdateDepartment(dto);
	}
	@Override
	public int UpdateTeam(DivisionDTO dto) throws Exception{
		return dao.UpdateTeam(dto);
	}
	@Override
	public int UpdateUserDepartment(DivisionDTO dto) throws Exception{
		return dao.UpdateUserDepartment(dto);
	}
	@Override
	public int UpdateUserTeam(DivisionDTO dto) throws Exception{
		return dao.UpdateUserTeam(dto);
	}
}
