package model;

public class SparePart {
	private int id;
	private String name;
	private float price;
	private String des;
	private int quantity;
	public SparePart(int id, String name, float price, String des, int quantity) {
		super();
		this.id = id;
		this.name = name;
		this.price = price;
		this.des = des;
		this.quantity = quantity;
	}
	public SparePart() {
		// TODO Auto-generated constructor stub
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public float getPrice() {
		return price;
	}
	public void setPrice(float price) {
		this.price = price;
	}
	public String getDes() {
		return des;
	}
	public void setDes(String des) {
		this.des = des;
	}
	public int getQuantity() {
		return quantity;
	}
	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}
	
}
