package team02.login;
import java.sql.Timestamp;

public class MemberShipDTO {
   private String id;
   private String pw;
   private String name;
   private String nic;
   private String birth;
   private String gender;
   private String address;
   private String email;
   private String phone;
   private Timestamp reg_date;
   
   public String getId() {
      return id;
   }
   public void setId(String id) {
      this.id = id;
   }
   public String getPw() {
      return pw;
   }
   public void setPw(String pw) {
      this.pw = pw;
   }
   public String getName() {
      return name;
   }
   public void setName(String name) {
      this.name = name;
   }
   public String getNic() {
      return nic;
   }
   public void setNic(String nic) {
      this.nic = nic;
   }
   public String getBirth() {
      return birth;
   }
   public void setBirth(String birth) {
      this.birth = birth;
   }
   public String getGender() {
      return gender;
   }
   public void setGender(String gender) {
      this.gender = gender;
   }
   public String getAddress() {
      return address;
   }
   public void setAddress(String address) {
      this.address = address;
   }
   public String getEmail() {
      return email;
   }
   public void setEmail(String email) {
      this.email = email;
   }
   public String getPhone() {
      return phone;
   }
   public void setPhone(String phone) {
      this.phone = phone;
   }
   public Timestamp getReg_date() {
      return reg_date;
   }
   public void setReg_date(Timestamp reg_date) {
      this.reg_date = reg_date;
   }
}