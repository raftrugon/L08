/*
 * AdministratorController.java
 * 
 * Copyright (C) 2017 Universidad de Sevilla
 * 
 * The use of this project is hereby constrained to the conditions of the
 * TDG Licence, a copy of which you may download from
 * http://www.tdg-seville.info/License.html
 */

package controllers.Admin;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import security.UserAccount;
import services.AdminService;
import services.CommentService;
import services.RendezvousService;
import controllers.AbstractController;
import domain.Actor;

@Controller
@RequestMapping("/admin")
public class AdminController extends AbstractController {


	@Autowired
	private RendezvousService rendezvousService;
	@Autowired
	private CommentService commentService;
	
	// Constructors -----------------------------------------------------------

	public AdminController() {
		super();
	}

	// Dashboard ---------------------------------------------------------------		

	@RequestMapping("/panel")
	public ModelAndView panel(@RequestParam(defaultValue = "dashboard") String type) {
		ModelAndView result = new ModelAndView("admin/panel");
		result.addObject("type", type);
		return result;
	}

	@RequestMapping("/dashboard")
	public ModelAndView dashboard() {
		ModelAndView result;
		result = new ModelAndView("admin/dashboard");

		//All avg,min,max,std in the same list for one table. Each list inside the list is one row.(14.6.a->14.6.d, 35.4.a->35.4.b)
		List<List<Double>> list = new ArrayList<List<Double>>();
		list.add(Arrays.asList(tripService.getTripApplicationStats()));
		list.add(Arrays.asList(managerService.getTripsPerManager()));
		list.add(Arrays.asList(tripService.getTripPriceStats()));
		list.add(Arrays.asList(rangerService.getTripsPerRanger()));
		list.add(Arrays.asList(tripService.getTripNotesStats()));
		list.add(Arrays.asList(commentService.getCommentRepliesStats()));
		result.addObject("list", list);

		//Another table to show the trips that are over the avg in nº of applications (14.6.j)
		List<Trip> tripsOverAvg = new ArrayList<Trip>();
		tripsOverAvg.addAll(tripService.getTripsWithApplicationNumberOverAvg());
		result.addObject("tripsOverAvg", tripsOverAvg);

		//All ratios on one table(Same row for all)(14.6.i, 35.4.c->35.4.g)
		Map<String, Double> ratiosMap = new HashMap<String, Double>();
		ratiosMap.put("admin.ratioCancelledTrips", tripService.getCancelledRatio());
		ratiosMap.put("admin.ratioAuditRecord", tripService.getAuditRecordRatio());
		ratiosMap.put("admin.ratioRangersCurricula", rangerService.ratioOfCurriculaRangers());
		ratiosMap.put("admin.ratioRangersEndorsed", rangerService.ratioOfEndorsedRangers());
		ratiosMap.put("admin.ratioSuspiciousManagers", managerService.ratioOfSuspiciousManager());
		ratiosMap.put("admin.ratioSuspiciousRangers", rangerService.ratioOfSuspiciousRanger());
		result.addObject("ratiosMap", ratiosMap.entrySet());

		//Ratios of each status of application(14.6.e->14.6.h)
		List<List<Double>> appratios = new ArrayList<List<Double>>();
		appratios.add(applicationService.getApplicationStatusRatios());
		result.addObject("appratios", appratios);

		//Table for all legal Texts and nº of references to them (14.6.k)
		result.addObject("legalTexts", legalTextService.findAll());
		result.addObject("legalTextsUses", legalTextService.getTableReferencedLegalTexts());
		return result;
	}


}
