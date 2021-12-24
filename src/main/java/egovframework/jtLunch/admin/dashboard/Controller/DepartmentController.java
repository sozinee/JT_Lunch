package egovframework.jtLunch.admin.dashboard.Controller;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import egovframework.jtLunch.admin.dashboard.Service.DivisionService;
import egovframework.jtLunch.main.reservation.DTO.DivisionDTO;
import egovframework.jtLunch.main.reservation.Service.ReservationService;
import net.sf.json.JSONArray;

@Controller
public class DepartmentController {
	@Inject
	ReservationService reservationService;
	@Inject
	DivisionService divisionService;
	
	//관리자 _ 부서 및 팀 관리 메인 페이지 이동
	@RequestMapping(value = "/admin/departmentMain", method = RequestMethod.GET)
	public String departmentMain(Model model) throws Exception {
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
		
		model.addAttribute("Department", JSONArray.fromObject(department));
		model.addAttribute("department", department);
		model.addAttribute("Team", JSONArray.fromObject(team));
		model.addAttribute("valueArr",JSONArray.fromObject(valueArr));
		
		return "/admin/departmentTeam/departmentMain";
	}
	
	//관리자 _ 부서명 저장
	@RequestMapping(value = "/admin/departmentInsert", method = RequestMethod.POST, produces = "application/text; charset=utf8")
	@ResponseBody
	public String departmentInsert(@RequestParam("departmentName") String department, Model model) throws Exception {
		String resultMsg = "";
		
		try {
			divisionService.InsertDepartment(department);
			resultMsg="등록완료";
		} catch(Exception e) {
			resultMsg="등록실패";
		}

		return resultMsg;
	}
	
	//관리자 _ 팀명 저장
	@RequestMapping(value = "/admin/teamInsert", method = RequestMethod.POST, produces = "application/text; charset=utf8")
	@ResponseBody
	public String teamInsert(DivisionDTO dto, Model model) throws Exception {
		String resultMsg = "";
		
		try {
			divisionService.InsertDepartmentTeam(dto);
			resultMsg="등록완료";
		} catch(Exception e) {
			resultMsg="등록실패";
		}

		return resultMsg;
	}
	
	//관리자 _ 부서명 저장
	@RequestMapping(value = "/admin/departmentUpdate", method = RequestMethod.POST, produces = "application/text; charset=utf8")
	@ResponseBody
	public String departmentUpdate(DivisionDTO dto,  Model model) throws Exception {
		String resultMsg = "";
		
		try {
			divisionService.UpdateDepartment(dto);
			divisionService.UpdateUserDepartment(dto);
			resultMsg="수정완료";
		} catch(Exception e) {
			resultMsg="수정실패";
		}

		return resultMsg;
	}
	
	//관리자 _ 부서명 저장
	@RequestMapping(value = "/admin/teamUpdate", method = RequestMethod.POST, produces = "application/text; charset=utf8")
	@ResponseBody
	public String teamUpdate(DivisionDTO dto,  Model model) throws Exception {
		String resultMsg = "";
		
		try {
			divisionService.UpdateTeam(dto);
			divisionService.UpdateUserTeam(dto);
			resultMsg="수정완료";
		} catch(Exception e) {
			resultMsg="수정실패";
		}

		return resultMsg;
	}
}
