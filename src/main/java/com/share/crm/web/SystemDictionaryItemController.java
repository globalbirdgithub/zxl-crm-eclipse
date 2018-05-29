package com.share.crm.web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.share.crm.domain.SystemDictionaryItem;
import com.share.crm.query.PageList;
import com.share.crm.query.SystemDictionaryItemQuery;
import com.share.crm.service.ISystemDictionaryItemService;
import com.share.crm.util.AjaxResult;

@Controller
@RequestMapping("/systemDictionaryItem")
public class SystemDictionaryItemController {
	@Autowired
	private ISystemDictionaryItemService systemDictionaryItemService;
	
	@RequestMapping("/index")
	public String index(){
		return "systemDictionaryItem";
	}
	
	@RequestMapping("/list")
	@ResponseBody
	public PageList list(SystemDictionaryItemQuery systemDictionaryItemQuery){
		PageList pageList = systemDictionaryItemService.findByQuery(systemDictionaryItemQuery);
		return pageList;
	}
	@RequestMapping(value="/delete/{id}",method=RequestMethod.GET)
	@ResponseBody
	public AjaxResult delete(@PathVariable(value="id") Long id){
		try {
			systemDictionaryItemService.delete(id);
			return new AjaxResult();
		} catch (Exception e) {
			e.printStackTrace();
			return new AjaxResult("删除失败！"+e.getMessage());
		}
	}
	@RequestMapping("/save")
	@ResponseBody
	public AjaxResult save(SystemDictionaryItem systemDictionaryItem){
		try {
			if(systemDictionaryItem.getId()==null){
				systemDictionaryItemService.save(systemDictionaryItem);
			}else{
				systemDictionaryItemService.update(systemDictionaryItem);
			}
			return new AjaxResult();
		} catch (Exception e) {
			e.printStackTrace();
			return new AjaxResult("保存失败！"+e.getMessage());
		}
	}
}
