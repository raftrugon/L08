
package domain;

import java.util.Collection;
import java.util.Date;

import javax.persistence.Access;
import javax.persistence.AccessType;
import javax.persistence.Entity;
import javax.persistence.OneToMany;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Past;

@Entity
@Access(AccessType.PROPERTY)
public class User extends Actor {

	public User() {
		super();
	}


	private Date	birthDate;


	@NotNull
	@Past
	public Date getBirthDate() {
		return birthDate;
	}

	public void setBirthDate(Date birthDate) {
		this.birthDate = birthDate;
	}


	//Relationships -----------------------

	private Collection<Comment>		comments;
	private Collection<Rsvp>		rsvps;
	private Collection<Rendezvous>	rendezvouses;


	@NotNull
	@OneToMany(mappedBy = "user")
	public Collection<Comment> getComments() {
		return comments;
	}

	public void setComments(Collection<Comment> comments) {
		this.comments = comments;
	}

	@NotNull
	@OneToMany(mappedBy = "user")
	public Collection<Rsvp> getRsvps() {
		return rsvps;
	}

	public void setRsvps(Collection<Rsvp> rsvps) {
		this.rsvps = rsvps;
	}

	@NotNull
	@OneToMany(mappedBy = "user")
	public Collection<Rendezvous> getRendezvouses() {
		return rendezvouses;
	}

	public void setRendezvouses(Collection<Rendezvous> rendezvouses) {
		this.rendezvouses = rendezvouses;
	}

}
