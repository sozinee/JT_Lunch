package egovframework.jtLunch.admin.dashboard.DTO;

public class RestaurantDTO {

	private String name;
	private String tel;
	private String account;
	private String bank;
	private String owner_name;
	private String qrcode;
	private String price;
	private String restaurant_id;
	private String delete_at;
	
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getTel() {
		return tel;
	}
	public void setTel(String tel) {
		this.tel = tel;
	}
	public String getAccount() {
		return account;
	}
	public void setAccount(String account) {
		this.account = account;
	}
	public String getBank() {
		return bank;
	}
	public void setBank(String bank) {
		this.bank = bank;
	}
	public String getOwner_name() {
		return owner_name;
	}
	public void setOwner_name(String owner_name) {
		this.owner_name = owner_name;
	}
	public String getQrcode() {
		return qrcode;
	}
	public void setQrcode(String qrcode) {
		this.qrcode = qrcode;
	}
	public String getPrice() {
		return price;
	}
	public void setPrice(String price) {
		this.price = price;
	}
	public String getRestaurant_id() {
		return restaurant_id;
	}
	public void setRestaurant_id(String restaurant_id) {
		this.restaurant_id = restaurant_id;
	}
	
	public String getDelete_at() {
		return delete_at;
	}
	public void setDelete_at(String delete_at) {
		this.delete_at = delete_at;
	}
	@Override
	public String toString() {
		return "RestaurantDTO [name=" + name + ", tel=" + tel + ", account=" + account + ", bank=" + bank
				+ ", owner_name=" + owner_name + ", qrcode=" + qrcode + ", price=" + price + ", restaurant_id="
				+ restaurant_id + ", delete_at=" + delete_at + "]";
	}
}
