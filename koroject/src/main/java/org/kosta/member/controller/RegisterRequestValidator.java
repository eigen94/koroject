package org.kosta.member.controller;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.kosta.member.domain.RegisterCommand;
import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;
import org.springframework.validation.Validator;





public class RegisterRequestValidator implements Validator {
	private static final String emailRegExp =
			"^[_A-Za-z0-9-\\+]+(\\.[_A-Za-z0-9-]+)*@" +
			"[A-Za-z0-9-]+(\\.[A-Za-z0-9]+)*(\\.[A-Za-z]{2,})$";
	private Pattern pattern;

	public RegisterRequestValidator() {
		pattern = Pattern.compile(emailRegExp);
	}

	@Override
	public boolean supports(Class<?> clazz) {
		return RegisterCommand.class.isAssignableFrom(clazz);
	}

	@Override
	public void validate(Object target, Errors errors) {
		RegisterCommand regReq = (RegisterCommand) target;
		if (regReq.getM_email() == null || regReq.getM_email().trim().isEmpty()) {
			errors.rejectValue("m_email", "required");
		} else {
			Matcher matcher = pattern.matcher(regReq.getM_email());
			if (!matcher.matches()) {
				errors.rejectValue("m_email", "bad");
			}
		}
	/*	ValidationUtils.rejectIfEmptyOrWhitespace(errors, "name", "required");
		ValidationUtils.rejectIfEmpty(errors, "password", "required");
		ValidationUtils.rejectIfEmpty(errors, "confirmPassword", "required");*/
	}

}
