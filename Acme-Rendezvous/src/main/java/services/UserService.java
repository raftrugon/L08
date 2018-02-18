
package services;

import java.util.ArrayList;
import java.util.Collection;
import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.Assert;
import org.springframework.validation.BindingResult;
import org.springframework.validation.Validator;

import repositories.UserRepository;
import security.Authority;
import security.LoginService;
import security.UserAccount;
import domain.Rendezvous;
import domain.Rsvp;
import domain.User;
import forms.RegisterUserForm;

@Service
@Transactional
public class UserService {

	// Managed repository -----------------------------------------------------

	@Autowired
	private UserRepository	userRepository;


	// Supporting services ----------------------------------------------------

	@Autowired
	private Validator validator;

	// Simple CRUD methods ----------------------------------------------------

	public User create() {
		User res = new User();

		//Collections
		res.setRsvps(new ArrayList<Rsvp>());
		res.setRendezvouses(new ArrayList<Rendezvous>());

		//UserAccount
		UserAccount userAccount = new UserAccount();
		Collection<Authority> authorities = userAccount.getAuthorities();
		Authority authority = new Authority();

		authority.setAuthority(Authority.USER);
		authorities.add(authority);
		userAccount.setAuthorities(authorities);

		res.setUserAccount(userAccount);

		return res;
	}

	public User findOne(final int userId) {
		Assert.isTrue(userId != 0);
		User res = this.userRepository.findOne(userId);
		Assert.notNull(res);
		return res;
	}

	public Collection<User> findAll() {
		Collection<User> res = this.userRepository.findAll();
		Assert.notNull(res);
		return res;
	}

	public User save(final User user) {
		Assert.notNull(user);
		//Assert.isNull(LoginService.getPrincipal().getAuthorities());
		Assert.isTrue(user.getBirthDate().before(new Date()));

		return this.userRepository.save(user);
	}

	public void delete(final User user) {
		this.userRepository.delete(user);

	}

	//Other Business Methods --------------------------------

	public User findByUserAccount(final UserAccount userAccount) {
		Assert.notNull(userAccount);
		User res;
		res = this.userRepository.findByUserAccount(userAccount.getId());
		return res;
	}

	public User findByPrincipal() {
		User res;
		UserAccount userAccount;
		userAccount = LoginService.getPrincipal();
		Assert.notNull(userAccount);
		res = this.findByUserAccount(userAccount);
		return res;
	}

	//RegisterUserForm ----> User

	public User reconstruct(final RegisterUserForm userForm, final BindingResult binding) {
		Assert.isTrue(userForm.getUserId() == 0);

		User res = this.create();


		res.setName(userForm.getName());
		res.setSurnames(userForm.getSurnames());
		res.setAddress(userForm.getAddress());
		res.setPhoneNumber(userForm.getPhoneNumber());
		res.setBirthDate(userForm.getBirthDate());
		res.setEmail(userForm.getEmail());

		this.validator.validate(res, binding);

		res.getUserAccount().setUsername(userForm.getUsername());//No validator for user account
		res.getUserAccount().setPassword(userForm.getPassword());

		return res;
	}

}
