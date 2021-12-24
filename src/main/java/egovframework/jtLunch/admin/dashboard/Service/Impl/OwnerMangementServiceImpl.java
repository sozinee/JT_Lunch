package egovframework.jtLunch.admin.dashboard.Service.Impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.jtLunch.admin.dashboard.DAO.OwnerManagementDAO;
import egovframework.jtLunch.admin.dashboard.DTO.OwnerManagementDTO;
import egovframework.jtLunch.admin.dashboard.DTO.RestaurantDTO;
import egovframework.jtLunch.admin.dashboard.Service.OwnerManagementService;

@Service("ownerManagementService")
public class OwnerMangementServiceImpl implements OwnerManagementService{
	
	@Resource(name="ownerManagementDAO")
	private OwnerManagementDAO ownerManagementDAO;
	
	@Override
	public List<OwnerManagementDTO> selectOwner() throws Exception {
		return ownerManagementDAO.selectOwner();
	}

	@Override
	public OwnerManagementDTO checkID(String id) throws Exception {
		return ownerManagementDAO.checkID(id);
	}

	@Override
	public void ownerJoin(OwnerManagementDTO ownerManagementDTO) throws Exception {
		ownerManagementDAO.ownerJoin(ownerManagementDTO);
	}

	@Override
	public List<RestaurantDTO> selectRestaurant() throws Exception {
		return ownerManagementDAO.selectRestaurant();
	}

}
