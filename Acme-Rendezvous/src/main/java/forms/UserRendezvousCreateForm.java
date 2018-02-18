
package forms;

import java.util.Date;

import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import org.springframework.format.annotation.DateTimeFormat;

import domain.Rendezvous;

public class UserRendezvousCreateForm {

	//Atributos
	private String	name, description, picture;
	private double	latitude, longitude;
	private Date	organisationMoment;
	private boolean	finalMode, adultOnly;
	private int		rendezvousId;


	//Constructor
	public UserRendezvousCreateForm() {
		this.rendezvousId = 0;
	}

	//Getters Setters

	public UserRendezvousCreateForm(final Rendezvous rendezvous) {
		this.name = rendezvous.getName();
		this.description = rendezvous.getDescription();
		this.picture = rendezvous.getPicture();
		this.latitude = rendezvous.getLatitude();
		this.longitude = rendezvous.getLongitude();
		this.organisationMoment = rendezvous.getOrganisationMoment();
		this.finalMode = rendezvous.getFinalMode();
		this.adultOnly = rendezvous.getAdultOnly();
		this.rendezvousId = rendezvous.getId();
	}

	public String getName() {
		return this.name;
	}

	public void setName(final String name) {
		this.name = name;
	}

	public String getDescription() {
		return this.description;
	}

	public void setDescription(final String description) {
		this.description = description;
	}

	public String getPicture() {
		return this.picture;
	}

	public void setPicture(final String picture) {
		this.picture = picture;
	}

	public double getLatitude() {
		return this.latitude;
	}

	public void setLatitude(final double latitude) {
		this.latitude = latitude;
	}

	public double getLongitude() {
		return this.longitude;
	}

	public void setLongitude(final double longitude) {
		this.longitude = longitude;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@DateTimeFormat(pattern = "dd/MM/yyyy HH:mm")
	public Date getOrganisationMoment() {
		return this.organisationMoment;
	}

	public void setOrganisationMoment(final Date organisationMoment) {
		this.organisationMoment = organisationMoment;
	}

	public boolean isFinalMode() {
		return this.finalMode;
	}

	public void setFinalMode(final boolean finalMode) {
		this.finalMode = finalMode;
	}

	public boolean isAdultOnly() {
		return this.adultOnly;
	}

	public void setAdultOnly(final boolean adultOnly) {
		this.adultOnly = adultOnly;
	}

	public int getRendezvousId() {
		return this.rendezvousId;
	}

	public void setRendezvousId(final int rendezvousId) {
		this.rendezvousId = rendezvousId;
	}

}
