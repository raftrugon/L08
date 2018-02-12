
package domain;

import java.util.Collection;
import java.util.Date;

import javax.persistence.Access;
import javax.persistence.AccessType;
import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.validation.Valid;
import javax.validation.constraints.NotNull;

import org.hibernate.validator.constraints.NotBlank;
import org.hibernate.validator.constraints.URL;

@Entity
@Access(AccessType.PROPERTY)
public class Rendezvous extends DomainEntity {

	public Rendezvous() {
		super();
	}


	private String				name;
	private String				description;
	private Date				organisationMoment;
	private String				picture;
	private Double				latitude;
	private Double				longitude;
	private Boolean				finalMode;
	private Boolean				deleted;
	private Boolean				adulOnly;
	private Collection<String>	questions;


	@NotBlank
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	@NotBlank
	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public Date getOrganisationMoment() {
		return organisationMoment;
	}

	public void setOrganisationMoment(Date organisationMoment) {
		this.organisationMoment = organisationMoment;
	}

	@URL
	public String getPicture() {
		return picture;
	}

	public void setPicture(String picture) {
		this.picture = picture;
	}

	public Double getLatitude() {
		return latitude;
	}

	public void setLatitude(Double latitude) {
		this.latitude = latitude;
	}

	public Double getLongitude() {
		return longitude;
	}

	public void setLongitude(Double longitude) {
		this.longitude = longitude;
	}

	@NotNull
	public Boolean getFinalMode() {
		return finalMode;
	}

	public void setFinalMode(Boolean finalMode) {
		this.finalMode = finalMode;
	}

	@NotNull
	public Boolean getDeleted() {
		return deleted;
	}

	public void setDeleted(Boolean deleted) {
		this.deleted = deleted;
	}

	@NotNull
	public Boolean getAdulOnly() {
		return adulOnly;
	}

	public void setAdulOnly(Boolean adulOnly) {
		this.adulOnly = adulOnly;
	}

	@NotNull
	public Collection<String> getQuestions() {
		return questions;
	}

	public void setQuestions(Collection<String> questions) {
		this.questions = questions;
	}


	private User						user;
	private Collection<Comment>			comments;
	private Collection<Rsvp>			rsvps;
	private Collection<Announcement>	announcements;


	@Valid
	@NotNull
	@ManyToOne(optional = false)
	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	@NotNull
	@OneToMany(mappedBy = "rendezvous")
	public Collection<Comment> getComments() {
		return comments;
	}

	public void setComments(Collection<Comment> comments) {
		this.comments = comments;
	}

	@NotNull
	@OneToMany(mappedBy = "rendezvous")
	public Collection<Rsvp> getRsvps() {
		return rsvps;
	}

	public void setRsvps(Collection<Rsvp> rsvps) {
		this.rsvps = rsvps;
	}

	@NotNull
	@OneToMany(cascade = CascadeType.ALL, mappedBy = "rendezvous")
	public Collection<Announcement> getAnnouncements() {
		return announcements;
	}

	public void setAnnouncements(Collection<Announcement> announcements) {
		this.announcements = announcements;
	}
}
