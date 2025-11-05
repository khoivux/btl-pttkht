package model;

import java.sql.Timestamp;
import java.time.LocalDate;
import java.util.Date;
import java.util.List;

public class Invoice {
	private int id;
	private Timestamp  createdTime;
	private String status;
	private String licensePlate;
	private float servicePrice;
	private float sparePartPrice;
	private float totalPrice;
	private Customer customer;
	private SaleStaff saleStaff;
	private List<OrderedService> serviceList;
	private List<OrderedSparePart> sparePartList;
	
	public Invoice() {
		
	}
	
	public Invoice(int id, Timestamp createdTime, String status, String licensePlate, float totalPrice,
			Customer customer, SaleStaff saleStaff, List<OrderedService> serviceList,
			List<OrderedSparePart> sparePartList) {
		super();
		this.id = id;
		this.createdTime = createdTime;
		this.status = status;
		this.licensePlate = licensePlate;
		this.totalPrice = totalPrice;
		this.customer = customer;
		this.saleStaff = saleStaff;
		this.serviceList = serviceList;
		this.sparePartList = sparePartList;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public Timestamp getCreatedTime() {
		return createdTime;
	}
	public void setCreatedTime(Timestamp createdTime) {
		this.createdTime = createdTime;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getLicensePlate() {
		return licensePlate;
	}
	public void setLicensePlate(String licensePlate) {
		this.licensePlate = licensePlate;
	}
	public float getTotalPrice() {
		return totalPrice;
	}
	public void setTotalPrice(float totalPrice) {
		this.totalPrice = totalPrice;
	}
	public Customer getCustomer() {
		return customer;
	}
	public void setCustomer(Customer customer) {
		this.customer = customer;
	}
	public SaleStaff getSaleStaff() {
		return saleStaff;
	}
	public void setSaleStaff(SaleStaff saleStaff) {
		this.saleStaff = saleStaff;
	}
	public List<OrderedService> getServiceList() {
		return serviceList;
	}
	public void setServiceList(List<OrderedService> serviceList) {
		this.serviceList = serviceList;
	}
	public List<OrderedSparePart> getSparePartList() {
		return sparePartList;
	}
	public void setSparePartList(List<OrderedSparePart> sparePartList) {
		this.sparePartList = sparePartList;
	}
	public float getServicePrice() {
		return servicePrice;
	}
	public void setServicePrice(float servicePrice) {
		this.servicePrice = servicePrice;
	}
	public float getSparePartPrice() {
		return sparePartPrice;
	}
	public void setSparePartPrice(float sparePartPrice) {
		this.sparePartPrice = sparePartPrice;
	}
	
	
} 
