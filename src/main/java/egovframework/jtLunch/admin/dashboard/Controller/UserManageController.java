package egovframework.jtLunch.admin.dashboard.Controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import egovframework.jtLunch.admin.dashboard.DTO.DashBoardDTO;
import egovframework.jtLunch.admin.dashboard.Service.DashBoardService;
import egovframework.jtLunch.main.reservation.DTO.DivisionDTO;
import egovframework.jtLunch.main.reservation.Service.ReservationService;
import net.sf.json.JSONArray;

@Controller
public class UserManageController {
	
	@Autowired
	private DashBoardService dashBoardService;
	@Inject
	ReservationService reservationService;
	
	@RequestMapping(value="/admin/usermanagement", method=RequestMethod.GET)
	public String usermanagement(Model model) throws Exception {
		
		Map<String, Object> searchList = new HashMap<String, Object>();
		List<DivisionDTO> department = reservationService.selectDepartment();
		List<DivisionDTO> team = reservationService.selectTeam();
		String[][] valueArr = new String[50][100];
	
		for(int j = 0; j < department.size(); j++) {
			for(int i = 0; i < team.size(); i++) {
				if(department.get(j).getDepartment().equals(team.get(i).getDepartment())) {
					valueArr[j][0] = department.get(j).getDepartment();
					valueArr[j][i + 1] = team.get(i).getTeam();
				}
			}	
		}
		
		model.addAttribute("usermanage", dashBoardService.usermanage(searchList));
		model.addAttribute("Department", JSONArray.fromObject(department));
		model.addAttribute("Team", JSONArray.fromObject(team));
		model.addAttribute("valueArr",JSONArray.fromObject(valueArr));
		
		return "admin/usermanagement/usermanage";
	}
	
	@RequestMapping(value="/admin/getDepartment", method=RequestMethod.POST)
	public ModelAndView getDepartment() throws Exception {
		
		ModelAndView mv = new ModelAndView("jsonView");
		
		mv.addObject("resultList", dashBoardService.getDepartment());
		
		return mv;
	}
	
	@RequestMapping(value="/admin/getTeam", method=RequestMethod.POST)
	public ModelAndView getTeam(HttpServletRequest req) throws Exception {
		
		
		ModelAndView mv = new ModelAndView("jsonView");
		
		String parameter = req.getParameter("department");
		
		mv.addObject("resultList", dashBoardService.getTeam(parameter));
		
		return mv;
	}
	
	@RequestMapping(value="/admin/searchList", method=RequestMethod.POST)
	public ModelAndView searchList(HttpServletRequest req) throws Exception {
		
		Map<String, Object> searchList = new HashMap<String, Object>();
		
		ModelAndView mv = new ModelAndView("jsonView");
		
		String department = req.getParameter("department");
		String team = req.getParameter("team");
		String enabled = req.getParameter("enabled");
		
		searchList.put("department", department);
		searchList.put("team", team);
		searchList.put("enabled", enabled);
			
		List<DashBoardDTO> test = dashBoardService.usermanage(searchList);
		System.out.println("!!!!!!!!!!!!!!!!!!"+test);
		mv.addObject("resultList", dashBoardService.usermanage(searchList));
		return mv;
	}
}
