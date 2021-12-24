package egovframework.jtLunch.admin.cmmn.Service.Impl;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import egovframework.jtLunch.admin.cmmn.DAO.AdminCmmnDAO;
import egovframework.jtLunch.admin.cmmn.Service.AdminCmmnService;
import egovframework.jtLunch.admin.dashboard.DTO.DashBoardDTO;
import egovframework.jtLunch.admin.owner.DTO.SearchResultDTO;

@Service("AdminCmmnService")
public class AdminCmmnServiceImpl implements AdminCmmnService{
	@Inject
	private AdminCmmnDAO dao;
	
	@Override
	public int CountAteTerm(DashBoardDTO dashBoardDTO) throws Exception{
		return dao.CountAteTerm(dashBoardDTO);
	}
	@Override
	public int CountAteTermTable(String ate_date) throws Exception{
		return dao.CountAteTermTable(ate_date);
	}
	
	@Override
	public int CountAteTermTable2(SearchResultDTO searchResultDTO) throws Exception{
		return dao.CountAteTermTable2(searchResultDTO);
	}
}
