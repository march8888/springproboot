package kr.bit.controller;

import java.lang.ProcessBuilder.Redirect;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.aspectj.lang.annotation.Pointcut;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.bit.entity.Board;
import kr.bit.entity.Criteria;
import kr.bit.entity.PageMaker;
import kr.bit.service.BoardService;

@Controller //POJO
@RequestMapping("/board/*")
public class BoardController {
	
	@Autowired
	BoardService boardService;
	@RequestMapping("/api")
	public @ResponseBody String api(String key){
		System.out.println("success api!!!!!");
		return "success";
	}
	
	@RequestMapping("/list")
	public String getList(Criteria cri, Model model) {
		
		List<Board> list = boardService.getList(cri);
		//객체바인딩
		model.addAttribute("list", list);
		//페이징 처리에 필요한 부분
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		pageMaker.setTotalCount(boardService.totalCount(cri));
		
		model.addAttribute("pageMaker", pageMaker);
		
		return "board/list";
	}
	
	//글쓰기 폼
	@GetMapping("/register")
	public String register() {
		return "board/register";
	}
	
	//글쓰기
	@PostMapping("/register")			//1회성 session
	public String register(Board vo, RedirectAttributes rttr) {
		
		boardService.insertSelectKey(vo);
		
		rttr.addFlashAttribute("result", vo.getIdx()); // ${result}
		
		return "redirect:/board/list";
	}
	
	@GetMapping("/get")
	public String get(@RequestParam("idx") int idx,Model model,@ModelAttribute("cri") Criteria cri) {
		
		Board vo = boardService.get(idx);
		model.addAttribute("vo", vo);
		
		return "board/get";
	}
	
	@GetMapping("/modify")
	public String modify(@RequestParam("idx") int idx,Model model,@ModelAttribute("cri") Criteria cri) {
		
		Board vo = boardService.get(idx);
		model.addAttribute("vo", vo);
		
		return "board/modify";
	}
	
	@PostMapping("/modify")
	public String modify(Board vo,Criteria cri,RedirectAttributes rttr) {
		
		boardService.modify(vo);
		//Flash는 1회성 
		//계속 유지하고 싶으면 addAttribute
		rttr.addAttribute("page", cri.getPage());
		rttr.addAttribute("perPageNum", cri.getPerPageNum());
		rttr.addAttribute("type", cri.getType());
		rttr.addAttribute("keyword", cri.getKeyword());
		
		return "redirect:/board/list";
	}

	@GetMapping("/remove")
	public String remove(@RequestParam("idx") int idx,Criteria cri,RedirectAttributes rttr) {
		
		boardService.remove(idx);
		rttr.addAttribute("page", cri.getPage());
		rttr.addAttribute("perPageNum", cri.getPerPageNum());
		rttr.addAttribute("type", cri.getType());
		rttr.addAttribute("keyword", cri.getKeyword());
		
		return "redirect:/board/list";
	}
	
	@GetMapping("/reply")
	public String reply(int idx, Model model,@ModelAttribute("cri") Criteria cri) {
		Board vo = boardService.get(idx);
		model.addAttribute("vo", vo);
		return "board/reply";
	}
	
	@PostMapping("/reply")
	public String reply(Board vo,Criteria cri,RedirectAttributes rttr) {
		
		boardService.reply(vo);
		
		rttr.addAttribute("page", cri.getPage());
		rttr.addAttribute("perPageNum", cri.getPerPageNum());
		rttr.addAttribute("type", cri.getType());
		rttr.addAttribute("keyword", cri.getKeyword());
		
		return "redirect:/board/list";
	}
	
}
