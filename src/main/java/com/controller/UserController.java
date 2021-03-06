package com.controller;

import com.domain.UserInfo;
import com.dto.ManagerGroupDto;
import com.services.interfaces.ManagerGroupService;
import com.services.interfaces.UserInfoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import java.util.Date;

/**
 * Created by 20150831 on 2015/9/15.
 */
@Controller
public class UserController {
    @Autowired
    private UserInfoService servieece;
    @Autowired
    private ManagerGroupService managerGroupService;
    @RequestMapping("/user/info")
    @ResponseBody
    public UserInfo UserInfo() {
        UserInfo userInfo = new UserInfo();
        userInfo.setUserName("防御条约try");
        userInfo.setPassword("发士大夫");
        return userInfo;
    }

    @RequestMapping("/user/list")
    public ModelAndView UserList() {
        ManagerGroupDto dto=new ManagerGroupDto();
        dto.setDescription("deeeeeeemo");
        dto.setRolename("demeeeeeeeo");
        dto.setGroupid(1);
       managerGroupService.AddManagerGroup(dto);
        return new ModelAndView("/user/list");
    }

}
