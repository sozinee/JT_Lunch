package egovframework.jtLunch.admin.dashboard.DTO;

public class ateUserDTO {
	private String id;
	private String name;
	private String ate_date;
	private String department;
	private String team;
	private String tel;
	private String restaurant_id;
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getAte_date() {
		return ate_date;
	}
	public void setAte_date(String ate_date) {
		this.ate_date = ate_date;
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
	public String getTel() {
		return tel;
	}
	public void setTel(String tel) {
		this.tel = tel;
	}
	public String getRestaurant_id() {
		return restaurant_id;
	}
	public void setRestaurant_id(String restaurant_id) {
		this.restaurant_id = restaurant_id;
	}
	@Override
	public String toString() {
		return "ateUserDTO [id=" + id + ", name=" + name + ", ate_date=" + ate_date + ", department=" + department
				+ ", team=" + team + ", tel=" + tel + ", restaurant_id=" + restaurant_id + "]";
	}
	
	
}
