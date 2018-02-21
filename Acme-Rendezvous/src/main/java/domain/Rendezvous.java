
package domain;

import java.util.Collection;
import java.util.Date;

import javax.persistence.Access;
import javax.persistence.AccessType;
import javax.persistence.CascadeType;
import javax.persistence.ElementCollection;
import javax.persistence.Entity;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.validation.Valid;
import javax.validation.constraints.Future;
import javax.validation.constraints.NotNull;

import org.hibernate.validator.constraints.NotBlank;
import org.hibernate.validator.constraints.URL;
import org.springframework.format.annotation.DateTimeFormat;

@Entity
@Access(AccessType.PROPERTY)
public class Rendezvous extends DomainEntity {

	// Attributes -------------------------------------------------------------
	private String				name;
	private String				description;
	private Date				organisationMoment;
	private String				picture;
	private Double				latitude;
	private Double				longitude;
	private Boolean				finalMode;
	private Boolean				deleted;
	private Boolean				adultOnly;
	private Collection<String>	questions;
	private Boolean				inappropriate;


	@NotBlank
	public String getName() {
		return this.name;
	}

	public void setName(final String name) {
		this.name = name;
	}

	@NotBlank
	public String getDescription() {
		return this.description;
	}

	public void setDescription(final String description) {
		this.description = description;
	}

	@Future
	@NotNull
	@Temporal(TemporalType.TIMESTAMP)
	@DateTimeFormat(pattern = "dd/MM/yyyy HH:mm")
	public Date getOrganisationMoment() {
		return this.organisationMoment;
	}

	public void setOrganisationMoment(final Date organisationMoment) {
		this.organisationMoment = organisationMoment;
	}

	@URL
	public String getPicture() {
		return this.picture;
	}

	public void setPicture(final String picture) {
		this.picture = picture;
	}

	public Double getLatitude() {
		return this.latitude;
	}

	public void setLatitude(final Double latitude) {
		this.latitude = latitude;
	}

	public Double getLongitude() {
		return this.longitude;
	}

	public void setLongitude(final Double longitude) {
		this.longitude = longitude;
	}

	@NotNull
	public Boolean getFinalMode() {
		return this.finalMode;
	}

	public void setFinalMode(final Boolean finalMode) {
		this.finalMode = finalMode;
	}

	@NotNull
	public Boolean getDeleted() {
		return this.deleted;
	}

	public void setDeleted(final Boolean deleted) {
		this.deleted = deleted;
	}

	@NotNull
	public Boolean getAdultOnly() {
		return this.adultOnly;
	}

	public void setAdultOnly(final Boolean adultOnly) {
		this.adultOnly = adultOnly;
	}

	@NotNull
	@ElementCollection
	public Collection<String> getQuestions() {
		return this.questions;
	}

	public void setQuestions(final Collection<String> questions) {
		this.questions = questions;
	}

	@NotNull
	public Boolean getinappropriate() {
		return inappropriate;
	}

	public void setinappropriate(Boolean inappropriate) {
		this.inappropriate = inappropriate;
	}


	// Relationships ----------------------------------------------------------
	private User						user;
	private Collection<Comment>			comments;
	private Collection<Rsvp>			rsvps;
	private Collection<Announcement>	announcements;
	private Collection<Rendezvous>		rendezvouses;


	@Valid
	@NotNull
	@ManyToOne(optional = false)
	public User getUser() {
		return this.user;
	}

	public void setUser(final User user) {
		this.user = user;
	}

	@NotNull
	@OneToMany(mappedBy = "rendezvous")
	public Collection<Comment> getComments() {
		return this.comments;
	}

	public void setComments(final Collection<Comment> comments) {
		this.comments = comments;
	}

	@NotNull
	@OneToMany(mappedBy = "rendezvous")
	public Collection<Rsvp> getRsvps() {
		return this.rsvps;
	}

	public void setRsvps(final Collection<Rsvp> rsvps) {
		this.rsvps = rsvps;
	}

	@NotNull
	@OneToMany(cascade = CascadeType.ALL)
	public Collection<Announcement> getAnnouncements() {
		return this.announcements;
	}

	public void setAnnouncements(final Collection<Announcement> announcements) {
		this.announcements = announcements;
	}

	@NotNull
	@OneToMany
	public Collection<Rendezvous> getRendezvouses() {
		return this.rendezvouses;
	}

	public void setRendezvouses(final Collection<Rendezvous> rendezvouses) {
		this.rendezvouses = rendezvouses;
	}
}
