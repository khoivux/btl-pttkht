package model;

public class OrderedSparePart {
	private int id;
	private float unitPrice;
	private SparePart sparePart;
	private int quantity;
	private float totalPrice;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public float getUnitPrice() {
		return unitPrice;
	}
	public void setUnitPrice(float unitPrice) {
		this.unitPrice = unitPrice;
	}
	public SparePart getSparePart() {
		return sparePart;
	}
	public void setSparePart(SparePart sparePart) {
		this.sparePart = sparePart;
	}
	public int getQuantity() {
		return quantity;
	}
	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}
	public float getTotalPrice() {
		return totalPrice;
	}
	public void setTotalPrice(float totalPrice) {
		this.totalPrice = totalPrice;
	}
	
}
