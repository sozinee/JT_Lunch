package egovframework.jtLunch.admin.cmmn.Service;

import egovframework.jtLunch.admin.dashboard.DTO.DashBoardDTO;
import egovframework.jtLunch.admin.owner.DTO.SearchResultDTO;

public interface AdminCmmnService {
	public int CountAteTerm(DashBoardDTO dashBoardDTO) throws Exception;
	
	public int CountAteTermTable (String ate_date) throws Exception;
	
	public int CountAteTermTable2 (SearchResultDTO searchResultDTO) throws Exception;
}
