package com.share.crm.web;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.share.crm.domain.SystemDictionary;
import com.share.crm.query.PageList;
import com.share.crm.query.SystemDictionaryQuery;
import com.share.crm.service.ISystemDictionaryService;
import com.share.crm.util.AjaxResult;

@Controller
@RequestMapping("/systemDictionary")
public class SystemDictionaryController {
	@Autowired
	private ISystemDictionaryService systemDictionaryService;
	
	@RequestMapping("/index")
	public String index(){
		return "systemDictionary";
	}
	
	@RequestMapping("/list")
	@ResponseBody
	public PageList list(SystemDictionaryQuery systemDictionaryQuery){
		PageList pageList = systemDictionaryService.findByQuery(systemDictionaryQuery);
		return pageList;
	}
	@RequestMapping(value="/delete/{id}",method=RequestMethod.GET)
	@ResponseBody
	public AjaxResult delete(@PathVariable(value="id") Long id){
		try {
			systemDictionaryService.delete(id);
			return new AjaxResult();
		} catch (Exception e) {
			e.printStackTrace();
			return new AjaxResult("删除失败！"+e.getMessage());
		}
	}
	@RequestMapping("/save")
	@ResponseBody
	public AjaxResult save(SystemDictionary systemDictionary){
		try {
			if(systemDictionary.getId()==null){
				systemDictionaryService.save(systemDictionary);
			}else{
				systemDictionaryService.update(systemDictionary);
			}
			return new AjaxResult();
		} catch (Exception e) {
			e.printStackTrace();
			return new AjaxResult("保存失败！"+e.getMessage());
		}
	}
	//获取所有目录
	@RequestMapping("/all")
	@ResponseBody
	public List<SystemDictionary> all(){
		List<SystemDictionary> all = systemDictionaryService.getAll();
		return all;
	}
}
