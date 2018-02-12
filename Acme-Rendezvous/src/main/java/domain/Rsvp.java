
package domain;

import java.util.Collection;

import javax.persistence.Access;
import javax.persistence.AccessType;
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
	private Collection<String>	questions;
	private Collection<String>	answers;


	@NotNull
	public Collection<String> getComments() {
		return comments;
	}

	public void setComments(Collection<String> comments) {
		this.comments = comments;
	}

	@NotNull
	public Collection<String> getQuestions() {
		return questions;
	}

	public void setQuestions(Collection<String> questions) {
		this.questions = questions;
	}

	@NotNull
	public Collection<String> getAnswers() {
		return answers;
	}

	public void setAnswers(Collection<String> answers) {
		this.answers = answers;
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
