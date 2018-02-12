
package domain;

import java.util.Collection;
import java.util.HashMap;
import java.util.Map;

import javax.persistence.Access;
import javax.persistence.AccessType;
import javax.persistence.ElementCollection;
import javax.persistence.Entity;
import javax.persistence.ManyToOne;
import javax.validation.Valid;
import javax.validation.constraints.NotNull;

@Entity
@Access(AccessType.PROPERTY)
public class Rsvp extends DomainEntity {

	public Rsvp() {
		super();
	}


	private Collection<String>	comments;
	private HashMap<String,String>	questionsAndAnswers;


	@NotNull
	@ElementCollection
	public Collection<String> getComments() {
		return comments;
	}

	public void setComments(Collection<String> comments) {
		this.comments = comments;
	}

	@NotNull
	@ElementCollection
	public Map<String,String> getQuestionsAndAnswers() {
		return questionsAndAnswers;
	}

	public void setQuestionsAndAnswers(HashMap<String,String> questionsAndAnswers) {
		this.questionsAndAnswers = questionsAndAnswers;
	}
	


	//Relationships -------------------

	private User		user;
	private Rendezvous	rendezvous;


	@NotNull
	@Valid
	@ManyToOne(optional = false)
	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	@NotNull
	@Valid
	@ManyToOne(optional = false)
	public Rendezvous getRendezvous() {
		return rendezvous;
	}

	public void setRendezvous(Rendezvous rendezvous) {
		this.rendezvous = rendezvous;
	}



}
