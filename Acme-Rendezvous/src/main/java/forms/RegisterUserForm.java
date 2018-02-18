package forms;

import java.util.Date;

import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import org.springframework.format.annotation.DateTimeFormat;


public class RegisterUserForm {


	//Atributos
	private String username, password, name, surnames, address, phoneNumber, email;
	private Date birthDate;
	private int userId;



	//Constructor
	public RegisterUserForm() {
		this.userId = 0;
	}




	//Getters Setters
	public String getUsername() {
		return this.username;
	}

	public void setUsername(final String username) {
		this.username = username;
	}





	public String getPassword() {
		return this.password;
	}

	public void setPassword(final String password) {
		this.password = password;
	}




	public String getName() {
		return this.name;
	}

	public void setName(final String name) {
		this.name = name;
	}




	public String getSurnames() {
		return this.surnames;
	}

	public void setSurnames(final String surnames) {
		this.surnames = surnames;
	}




	public String getAddress() {
		return this.address;
	}

	public void setAddress(final String address) {
		this.address = address;
	}




	public String getPhoneNumber() {
		return this.phoneNumber;
	}

	public void setPhoneNumber(final String phoneNumber) {
		this.phoneNumber = phoneNumber;
	}




	public String getEmail() {
		return this.email;
	}

	public void setEmail(final String email) {
		this.email = email;
	}



	@Temporal(TemporalType.DATE)
	@DateTimeFormat(pattern = "dd/MM/yyyy") //Acorde al input date de input.tag
	public Date getBirthDate() {
		return this.birthDate;
	}

	public void setBirthDate(final Date birthDate) {
		this.birthDate = birthDate;
	}



	public int getUserId() {
		return this.userId;
	}

	public void setUserId(final int userId) {
		this.userId = userId;
	}



}
