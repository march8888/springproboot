package kr.bit.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.bit.entity.Board;
import kr.bit.service.BoardService;

@Controller
public class BoardController {
	
	@Autowired
	BoardService boardService;
	
	@RequestMapping("/list")
	public String list(Model model) {
		List<Board> list = boardService.getList();
		model.addAttribute("list", list);
		
		return "list";
	}
	
	@GetMapping("/register")
	public String register() {
		return "register";
	}
	
	@PostMapping("/register")
	public String register(Board vo) {
		boardService.register(vo);
		return "redirect:/list";
	}
	
	@GetMapping("/get")
	public @ResponseBody Board get(long idx) {
		Board vo = boardService.get(idx);
		return vo;
	}
	
	@GetMapping("/remove")
	public String remove(long idx) {
		
		boardService.remove(idx);
		
		return "redirect:/list";
	}
	
	@PostMapping("/modify")
	public String modify(Board vo) {
		boardService.update(vo);
		return "redirect:/list";
	}
	
}
