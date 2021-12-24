package egovframework.jtLunch.main.reservation.DTO;

public class DivisionDTO {

	private String department;
	private String team;
	private String departmentUpdate;
	private String teamUpdate;
	
	public String getDepartmentUpdate() {
		return departmentUpdate;
	}
	public void setDepartmentUpdate(String departmentUpdate) {
		this.departmentUpdate = departmentUpdate;
	}
	
	public String getTeamUpdate() {
		return teamUpdate;
	}
	public void setTeamUpdate(String teamUpdate) {
		this.teamUpdate = teamUpdate;
	}
	public String getDepartment() {
		return department;
	}
	public void setDepartment(String department) {
		this.department = department;
	}
	public String getTeam() {
		return team;
	}
	public void setTeam(String team) {
		this.team = team;
	}
	@Override
	public String toString() {
		return "DivisionDTO [department=" + department + ", team=" + team + ", departmentUpdate=" + departmentUpdate
				+ ", teamUpdate=" + teamUpdate + "]";
	}
	
}
