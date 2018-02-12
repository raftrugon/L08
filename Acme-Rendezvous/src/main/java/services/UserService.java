
package services;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.Assert;

import repositories.UserRepository;
import security.LoginService;
import security.UserAccount;
import domain.User;

@Service
@Transactional
public class UserService {

	// Managed repository -----------------------------------------------------

	@Autowired
	private UserRepository			userRepository;

	// Supporting services ----------------------------------------------------


	// Simple CRUD methods ----------------------------------------------------

	public User create() {
		User res = new User();

		return res;
	}

	public User findOne(int userId) {
		Assert.isTrue(userId != 0);
		User res = userRepository.findOne(userId);
		Assert.notNull(res);
		return res;
	}

	public User save(User user) {
		return userRepository.save(user);
	}

	public void delete(final User user) {
		userRepository.delete(user);

	}
	
	//Other Business Methods --------------------------------
	
	public User findByUserAccount(UserAccount userAccount) {
		Assert.notNull(userAccount);
		User res;
		res = userRepository.findByUserAccount(userAccount.getId());
		return res;
	}

	public User findByPrincipal() {
		User res;
		UserAccount userAccount;
		userAccount = LoginService.getPrincipal();
		Assert.notNull(userAccount);
		res = findByUserAccount(userAccount);
		return res;
	}
	
}
