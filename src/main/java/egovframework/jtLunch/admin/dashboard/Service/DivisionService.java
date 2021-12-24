package egovframework.jtLunch.admin.dashboard.Service;

import egovframework.jtLunch.main.reservation.DTO.DivisionDTO;

public interface DivisionService {
	public int InsertDepartment(String department) throws Exception;
	public int InsertDepartmentTeam(DivisionDTO dto) throws Exception;
	public int UpdateDepartment(DivisionDTO dto) throws Exception;
	public int UpdateTeam(DivisionDTO dto) throws Exception;
	public int UpdateUserDepartment(DivisionDTO dto) throws Exception;
	public int UpdateUserTeam(DivisionDTO dto) throws Exception;
}
