# Deployment Diagram - Garaman Project

## PlantUML Code

```plantuml
@startuml
title Deployment Diagram - GaraMan Website (JSP + Servlet + MySQL)

node "Client Machine" as client {
  note top : Required:\n- Web Browser\n(Chrome, Firefox, Edge, Safari)
  artifact "Web Browser" as browser
}

node "Web Server Machine\n(Apache Tomcat)" as webserver {
  note top : Required:\n- Java JDK 8+\n- Apache Tomcat 9.x\n- MySQL JDBC Driver\n- JSTL Libraries
  artifact "garaman project" as project {
    component "Servlets" as servlets
    component "JSP Pages" as jsp
    component "DAO Classes" as dao
    component "Model Classes" as model
  }
}

node "Database Server Machine\n(MySQL)" as dbserver {
  note top : Required:\n- MySQL Server 8.0+\n- MySQL Workbench (optional)
  database "garaman_db" as db
}

' Connections
browser --> webserver : HTTP/HTTPS\n(Port 8080)
webserver --> dbserver : JDBC\n(Port 3306)

' Internal connections
servlets --> dao : uses
jsp --> servlets : calls
dao --> model : uses

@enduml
```

## Mô tả các thành phần

### 1. Client Machine
- Trình duyệt web của người dùng

### 2. Web Server (Apache Tomcat)
- **garaman project**: Source code và compiled classes
  - **Servlets**: SearchServiceServlet, SearchSparePartServlet, ServiceDetailServlet
  - **JSP Pages**: customerMainView.jsp, searchService.jsp, searchSparePart.jsp
  - **DAO Classes**: ServiceDAO, SparePartDAO
  - **Model Classes**: Customer, Member, Service, SparePart, Staff

### 3. Database Server (MySQL)
- Lưu trữ dữ liệu của ứng dụng garaman_db

## Luồng hoạt động

1. **Client → Web Server**: Gửi HTTP request (port 8080)
2. **Web Server → Database**: Truy vấn dữ liệu qua JDBC (port 3306)
3. **Database → Web Server**: Trả về kết quả
4. **Web Server → Client**: Trả về response

## Cài đặt trên máy mới

### Client Machine (Máy khách hàng)
**Yêu cầu:**
- Hệ điều hành: Windows 10+, macOS 10.15+, hoặc Linux
- Web Browser: Chrome 90+, Firefox 88+, Edge 90+, hoặc Safari 14+
- Kết nối Internet

### Web Server Machine (Máy chủ web)
**Phần mềm cần cài đặt:**
1. **Java JDK 8 hoặc cao hơn**
   - Download từ Oracle hoặc OpenJDK
   - Thiết lập biến môi trường JAVA_HOME
2. **Apache Tomcat 9.x**
   - Download từ tomcat.apache.org
   - Thiết lập biến môi trường CATALINA_HOME
   - **Đã bao gồm**: Servlet API, JSP Engine
3. **MySQL JDBC Driver**
   - Download mysql-connector-java-8.0.30.jar
   - Copy vào thư mục `lib` của Tomcat hoặc `WEB-INF/lib` của project
4. **JSTL Libraries**
   - javax.servlet.jsp.jstl-1.2.1.jar
   - javax.servlet.jsp.jstl-api-1.2.1.jar
   - Copy vào thư mục `WEB-INF/lib` của project

**Cần cài thêm (vì không có WAR file):**
- ✅ MySQL JDBC Driver
- ✅ JSTL libraries  
- ✅ Compile Java source thành .class files

**Cấu hình:**
- Port 8080 (HTTP) và 8443 (HTTPS) phải mở
- RAM tối thiểu: 512MB, khuyến nghị: 1GB+
- Disk space: 2GB trở lên

### Database Server Machine (Máy chủ cơ sở dữ liệu)
**Phần mềm cần cài đặt:**
1. **MySQL Server 8.0+**
   - Download từ mysql.com
   - Thiết lập root password
2. **MySQL Workbench** (tùy chọn)
   - Để quản lý database dễ dàng

**Cấu hình:**
- Port 3306 phải mở cho Web Server
- Tạo database "garaman_db"
- Tạo user và cấp quyền truy cập
- RAM tối thiểu: 1GB, khuyến nghị: 2GB+
- Disk space: 10GB+ tùy theo dữ liệu

## Các bước triển khai

### 1. Cài đặt Database Server
```sql
CREATE DATABASE garaman_db;
CREATE USER 'garaman_user'@'%' IDENTIFIED BY 'password';
GRANT ALL PRIVILEGES ON garaman_db.* TO 'garaman_user'@'%';
FLUSH PRIVILEGES;
```

### 2. Cài đặt Web Server
1. **Compile Java source code:**
   ```bash
   javac -cp "path/to/tomcat/lib/*" src/**/*.java -d build/classes/
   ```
2. **Setup project structure:**
   - Copy JSP files từ `WebContent/` vào thư mục webapp của Tomcat
   - Copy compiled .class files vào `WEB-INF/classes/`
   - Copy JAR libraries vào `WEB-INF/lib/`
3. **Khởi động Tomcat service**
4. **Kiểm tra ứng dụng tại:** http://localhost:8080/garaman

### 3. Kiểm tra kết nối
- Client truy cập: http://[web-server-ip]:8080/garaman
- Kiểm tra kết nối database từ ứng dụng