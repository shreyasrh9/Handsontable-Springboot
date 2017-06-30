package com.shreyas.controller;

import java.io.File;
import java.lang.reflect.Field;
import java.lang.reflect.Method;
import java.lang.reflect.Type;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import javax.script.ScriptEngine;
import javax.script.ScriptEngineManager;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.reflect.TypeToken;
import com.shreyas.model.HandsOnTable;

@Controller
public class WelcomeController {

	// inject via application.properties
	@Value("${welcome.message:test}")
	private String message = "Hello World";

	@RequestMapping("/")
	public String welcome(Model model, HttpSession session) {
		List<HandsOnTable> handsOnTables = new ArrayList<HandsOnTable>();
		HandsOnTable handsOnTable = new HandsOnTable();
		handsOnTable.setMessage("Message");

		Calendar cal = Calendar.getInstance();
		Date today = cal.getTime();
		cal.add(Calendar.YEAR, 1); // to get previous year add -1
		Date nextYear = cal.getTime();

		List<String> dates = new ArrayList<String>(365);
		dates.add(today.getMonth() + 1 + "/" + today.getDate() + "/" + (today.getYear() + 1900));

		cal.setTime(today);
		while (cal.getTime().before(nextYear)) {
			cal.add(Calendar.DATE, 1);

			dates.add(cal.getTime().getMonth() + 1 + "/" + cal.getTime().getDate() + "/"
					+ (cal.getTime().getYear() + 1900));
		}

		dates.remove(dates.size() - 1);

		try {
			Class<?> c = handsOnTable.getClass();
			for (int i = 1; i <= dates.size(); i++) {

				Field chap = c.getDeclaredField("column" + i);
				chap.set(handsOnTable, dates.get(i - 1));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		handsOnTables.add(handsOnTable);
		String json = new Gson().toJson(handsOnTables);
		model.addAttribute("handsOnJson", json);
		return "handson";
	}

	@RequestMapping(value = "/uploadBulkData", method = RequestMethod.POST)
	public String bulkUpload(Model model, HttpSession session, @RequestParam("bulkData") String bulkData)
			throws Exception {

		String JSPath = "/Users/shreyasrh/Downloads/Handsontable-Springboot/src/main/webapp/js/lz-string.js";
		Type listType = null;
		File fileJS = null;
		ScriptEngineManager mgr = null;
		ScriptEngine engine = null;
		String contentJS = null;
		boolean isvalid = true;
		fileJS = new File(JSPath);
		mgr = new ScriptEngineManager();
		engine = mgr.getEngineByName("JavaScript");
		contentJS = FileUtils.readFileToString(fileJS, "UTF-8");
		engine.eval(contentJS);
		engine.eval("var decompressedJSON = LZString.decompressFromEncodedURIComponent('" + bulkData + "')");
		System.out.println((String) engine.get("decompressedJSON"));
		List<HandsOnTable> bdpmbList = null;
		Method valueString = null;
		bulkData = (String) engine.get("decompressedJSON");

		listType = new TypeToken<List<HandsOnTable>>() {
		}.getType();
		bdpmbList = new GsonBuilder().create().fromJson(bulkData, listType);
		for (int i = 0; i < bdpmbList.size(); i++) {

			if (bdpmbList.get(i).isEmptyBulkData()) {
				bdpmbList.remove(i);
				i--;
			}

		}

		for (int i = 1; i < bdpmbList.size(); i++) {
			try {
				HandsOnTable specific = bdpmbList.get(i);
				Class<? extends HandsOnTable> specificClass = specific.getClass();

				for (int j = 1; j <= 365; j++) {
					valueString = specificClass.getMethod("getColumn" + j, null);
					if (valueString != null) {
						if (valueString.invoke(specific, null) == null)
							continue;

						String valueTemp = valueString.invoke(specific, null).toString();
						int check = 0;
						if (valueTemp != null && valueTemp != "" && !valueTemp.isEmpty()) {
							check = Integer.parseInt(valueTemp);

						}
					}
				}
			} catch (NumberFormatException e) {
				bdpmbList.get(i).setMessage("Only Numbers Allowed!!!");

				isvalid = false;

			}

		}
		if (!isvalid) {
			model.addAttribute("handsOnJson", new Gson().toJson(bdpmbList));
			return "handson";
		}

		return "redirect:/";
	}

}