package egovframework.jtLunch.admin.dashboard.Controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import egovframework.jtLunch.admin.dashboard.DTO.OwnerManagementDTO;
import egovframework.jtLunch.admin.dashboard.DTO.RestaurantDTO;
import egovframework.jtLunch.admin.dashboard.Service.OwnerManagementService;
import net.sf.json.JSONArray;

@Controller
public class OwnerManagementController {
	
	@Autowired
	private OwnerManagementService ownerManagementService;
	
	@Autowired
	private BCryptPasswordEncoder pwdEncoder;
	
	@RequestMapping(value="/admin/ownerManagement", method=RequestMethod.GET)
	public String ownerManagement(Model model) throws Exception{
		
		List<OwnerManagementDTO> selectOwner = ownerManagementService.selectOwner();
		List<RestaurantDTO> selectRestaurant = ownerManagementService.selectRestaurant();
		
		model.addAttribute("selectOwner", selectOwner);
		model.addAttribute("selectRestaurant", JSONArray.fromObject(selectRestaurant));
		
		System.out.println("asdasdasd"+ selectOwner);
		return "admin/ownerManagement/ownerManagement";
	}
	
	@RequestMapping(value="/admin/checkID", method=RequestMethod.POST)
	@ResponseBody
	public ModelAndView ownerCheckID(HttpServletRequest request) throws Exception{
		
		ModelAndView mv = new ModelAndView("jsonView");
		String id = request.getParameter("ownerID");
		
		System.out.println(id + " asdasdasdasdsadsa");
		
		mv.addObject("checkID", ownerManagementService.checkID(id));
		
		return mv;
	}
	
	@RequestMapping(value="/admin/ownerJoin", method=RequestMethod.POST)
	public String ownerRegister(HttpServletRequest request) throws Exception{
		
		String id = request.getParameter("ownerID");
		String pw = request.getParameter("ownerPW");
		String name = request.getParameter("ownerNAME");
		String tel = request.getParameter("ownerTEL");
		String restaurant_id = request.getParameter("selectBox");
		
		OwnerManagementDTO dto = new OwnerManagementDTO();
		dto.setOwner_id(id);
		dto.setOwner_pw(pw);
		dto.setOwner_name(name);
		dto.setOwner_tel(tel);
		dto.setRestaurant_id(restaurant_id);
		try {
		ownerManagementService.ownerJoin(dto);
		}catch(Exception e){
			e.printStackTrace();
		}
		return "redirect:/admin/ownerManagement";
	}
}
