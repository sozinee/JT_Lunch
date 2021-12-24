package egovframework.jtLunch.admin.owner.DTO;

public class SearchResultDTO {
	private String restaurant_id;
	private String eatDate; //밥 먹은 날짜
	private int ateUserCount; //밥 먹은 사람 수
	private String totalMoney; //총 금액
	
	public String getEatDate() {
		return eatDate;
	}
	public void setEatDate(String eatDate) {
		this.eatDate = eatDate;
	}
	public int getAteUserCount() {
		return ateUserCount;
	}
	public void setAteUserCount(int ateUserCount) {
		this.ateUserCount = ateUserCount;
	}
	public String getTotalMoney() {
		return totalMoney;
	}
	public String getRestaurant_id() {
		return restaurant_id;
	}
	public void setRestaurant_id(String restaurant_id) {
		this.restaurant_id = restaurant_id;
	}
	public void setTotalMoney(String totalMoney) {
		this.totalMoney = totalMoney;
	}
	@Override
	public String toString() {
		return "SearchResultDTO [eatDate=" + eatDate + ", ateUserCount=" + ateUserCount + ", totalMoney=" + totalMoney
				+ ", restaurant_id=" + restaurant_id + "]";
	}
	
}
