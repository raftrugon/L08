package forms;

import java.util.Collection;

import domain.Rendezvous;

public class UserQuestionsRendezvousCreateForm {

	//Atributos
	private Collection<String>	questions;

	//Constructor
	public UserQuestionsRendezvousCreateForm() {
	}

	//Getters Setters

	public UserQuestionsRendezvousCreateForm(final Rendezvous rendezvous) {
		this.questions = rendezvous.getQuestions();
	}

	public Collection<String> getQuestions() {
		return this.questions;
	}

	public void setQuestions(final Collection<String> questions) {
		this.questions = questions;
	}

}
