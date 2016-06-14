package org.kosta.member.controller;

import java.io.File;
import java.io.IOException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.Random;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.kosta.member.domain.DeleteMember;
import org.kosta.member.domain.ImageUtill;
import org.kosta.member.domain.LoginCommand;
import org.kosta.member.domain.Member;
import org.kosta.member.domain.PassSerchCommand;
import org.kosta.member.domain.RegisterCommand;
import org.kosta.member.service.MemberService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

@Controller
public class MemberController {

	private static final Logger logger = LoggerFactory.getLogger(MemberController.class);

	@Inject
	private MemberService service;

	@Autowired
	public void setService(MemberService service) {
		this.service = service;
	}

	// 메인페이지
	@RequestMapping(value = "/")
	public String inert_form(Model model) {

		return "index";
	}

	// 메인페이지
	@RequestMapping(value = "/index")
	public String idex_form(Model model) {

		return "index";
	}

	// 회원가입폼
	@RequestMapping(value = "insert_member", method = RequestMethod.GET)
	public String insert_form2() {

		return "index";
	}

	// 회원가입
	@RequestMapping(value = "insert_member", method = RequestMethod.POST)
	public String insert_member(Member member, Model model) {
		/*
		 * new RegisterRequestValidator().validate(rcm, errors);
		 * if(errors.hasErrors()){ return "/"; } Member member = new Member();
		 * 
		 * member.setM_email(rcm.getM_email());
		 * member.setM_name(rcm.getM_name());
		 * member.setM_phone(rcm.getM_phone());
		 * 
		 * member.setM_question(rcm.getM_question());
		 * member.setM_answer(rcm.getM_answer()); ;
		 */
		System.out.println("왓니");
		member.setM_id(service.idSelect() + 1);
		member.setM_recentMember("");
		member.setM_pwd(testSHA256(member.getM_pwd()));
		service.insertMember(member);
		return "redirect:/";
	}

	// 회원수정
	@RequestMapping(value = "memberModify")
	public String memberModify(RegisterCommand rc, Model model, HttpServletRequest req) {
		System.out.println(rc.getM_email() + ", " + rc.getM_pwd());
		rc.setM_pwd(testSHA256(rc.getM_pwd()));
		Member member = service.serchEmail(rc);
		System.out.println(member);
		if (member == null) {
			System.out.println("실패?");
			model.addAttribute("pwdFalse", "비밀번호를 잘못 입력하셧습니다.");
			return "myPage";
		}
		member.setM_pwd(testSHA256(rc.getM_pwdCheck()));
		member.setM_name(rc.getM_name());
		member.setM_phone(rc.getM_phone());
		member.setM_question(rc.getM_question());
		member.setM_answer(rc.getM_answer());
		System.out.println(member);
		service.memberModify(member);

		req.getSession().removeAttribute("member");
		req.getSession().setAttribute("member", member);
		return "redirect:/myPage";
	}

	// 프로필 사진 삭제
	@RequestMapping(value = "proDelete")
	public String proDelete(@RequestParam("email") String email, HttpServletRequest req) {
		service.proDelete(email);
		req.getSession().removeAttribute("member");

		Member member = service.member(email);

		req.getSession().setAttribute("member", member);

		return "redirect:/myPage";
	}

	// 로그인폼
	@RequestMapping(value = "login_form", method = RequestMethod.GET)
	public String login_form() {

		return "/memberRegister/login_form";
	}

	// 로그인하기
	@RequestMapping(value = "login", method = RequestMethod.POST)
	public String loginMember(/* @RequestParam("m_email") String email */LoginCommand login, Model model,
			HttpServletRequest request) {
		login.setM_pwd(testSHA256(login.getM_pwd()));
		Member member = service.loginMember(login);
		if (member == null) {
			return "index";
		}
		request.getSession().setAttribute("member", member);
		/* model.addAttribute("member", member); */
		return "index";
	}

	// 세션이 존재할때 로그인 페이지를 못가게 만듬
	@RequestMapping(value = "loginMember2")
	public String loginMember2() {

		return "/memberRegister/insertMember";
	}

	// 로그아웃 세션 삭제
	@RequestMapping(value = "logout")
	public String logoutMember(HttpServletRequest request) {
		request.getSession().removeAttribute("member");
		return "redirect:/index";
	}

	// 회원정보보기
	@RequestMapping(value = "detailMember")
	public String detailMember() {

		return "/myPage";
	}

	// 회원탈퇴
	@RequestMapping(value = "deleteMember")
	public String deleteMember(DeleteMember dm, HttpServletRequest request, Model model) {
		dm.setM_pwd(testSHA256(dm.getM_pwd()));
		int result = service.deleteMember(dm);

		if (result == 0) {
			model.addAttribute("message", "비밀번호가 틀렸습니다.");
			return "redirect:/detailMember";
		} else {
			request.getSession().removeAttribute("member");
			return "redirect:/index";
		}
	}

	// 비밀번호 찾기 폼
	@RequestMapping(value = "serchMember", method = RequestMethod.GET)
	public String serchMember() {

		return "/memberRegister/serchMember";
	}

	// 임시 비밀번호 알려주기
	@RequestMapping(value = "serchMember", method = RequestMethod.POST)
	public String serchPWD(PassSerchCommand psc, Model model) {
		PassSerchCommand pscd = service.serchPWD(psc);
		if (pscd == null) {

			model.addAttribute("message", psc.getM_email() + " 라는 이메일은 존재 하지 않습니다.");
			return "redirect:/serchMember";
		} else {
			if (psc.getM_question() != pscd.getM_question()) {
				model.addAttribute("message", "질문이 잘 못 됐습니다.");
				return "redirect:/serchMember";
			} else if (!(psc.getM_answer().equals(pscd.getM_answer()))) {
				model.addAttribute("message", "답이 잘 못 됐습니다.");
				return "redirect:/serchMember";
			}
		}
		Random random = new Random();
		int a = random.nextInt(1000);
		Member member = new Member();
		member.setM_email(psc.getM_email());
		member.setM_pwd(testSHA256("koroject" + a));
		service.changePwd(member);
		model.addAttribute("message", "koroject" + a);
		return "redirect:/login_form";
	}

	@RequestMapping(value = "proImg", method = RequestMethod.POST)
	public String upload(MultipartFile file, Model model, HttpServletRequest req) throws IOException {

		System.out.println("-----------------");
		System.out.println("originalName: " + file.getOriginalFilename());
		String filename = file.getOriginalFilename(); // 업로드 파일 이름 받음
		// String path = "C:/Intel";
		File tempfile = new File(req.getSession().getServletContext().getRealPath("/profile/"),
				file.getOriginalFilename()); // 파일 생성후
		System.out.println(req.getSession().getServletContext().getRealPath("/profile/"));
		if (tempfile.exists() && tempfile.isFile()) { // 이미 존재하는 파일일경우 현재시간을
														// 가져와서 리네임

			filename = System.currentTimeMillis() + "_" + file.getOriginalFilename();

			tempfile = new File(req.getSession().getServletContext().getRealPath("/profile/"), filename); // 리네임된
																											// 파일이름으로
																											// 재생성

		}
		file.transferTo(tempfile);

		Member member = (Member) req.getSession().getAttribute("member");
		System.out.println(member.getM_id());
		// 업로드 디렉토리로 파일 이동

		// 이미지 리사이즈
		String imgePath = req.getSession().getServletContext().getRealPath("/profile") + "/" + filename;
		File src = new File(imgePath);
		String headName = filename.substring(0, filename.lastIndexOf("."));
		String pattern = filename.substring(filename.lastIndexOf(".") + 1);
		String reImagePath = req.getSession().getServletContext().getRealPath("/") + "profile/" + headName + "_resize."
				+ pattern;
		File dest = new File(reImagePath);

		ImageUtill.resize(src, dest, 100, ImageUtill.RATIO);

		member.setM_image(headName + "_resize." + pattern); // 업로드된 파일이름 등록

		service.profile(member);
		return "myPage";
	}

	/*
	 * //validation 바인드
	 * 
	 * @InitBinder protected void initBinder(WebDataBinder binder){
	 * binder.setValidator(new RegisterRequestValidator()); }
	 */
	// 비밀번호 암호화
	public String testSHA256(String str) {
		String SHA = "";
		try {
			MessageDigest sh = MessageDigest.getInstance("SHA-256");
			sh.update(str.getBytes());
			byte byteData[] = sh.digest();
			StringBuffer sb = new StringBuffer();
			for (int i = 0; i < byteData.length; i++) {
				sb.append(Integer.toString((byteData[i] & 0xff) + 0x100, 16).substring(1));
			}
			SHA = sb.toString();

		} catch (NoSuchAlgorithmException e) {
			e.printStackTrace();
			SHA = null;
		}
		return SHA;
	}
}
