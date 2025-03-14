package com.szl.mianshi.controller;

import cn.dev33.satoken.annotation.SaCheckRole;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.szl.mianshi.common.BaseResponse;
import com.szl.mianshi.common.ErrorCode;
import com.szl.mianshi.common.ResultUtils;
import com.szl.mianshi.constant.UserConstant;
import com.szl.mianshi.exception.BusinessException;
import com.szl.mianshi.exception.ThrowUtils;
import com.szl.mianshi.model.entity.Experience;
import com.szl.mianshi.model.entity.User;
import com.szl.mianshi.model.dto.experience.ExperienceAddRequest;
import com.szl.mianshi.model.dto.experience.ExperienceUpdateRequest;
import com.szl.mianshi.model.dto.experience.ExperienceQueryRequest;
import com.szl.mianshi.model.vo.ExperienceVO;
import com.szl.mianshi.service.ExperienceService;
import com.szl.mianshi.service.UserService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.BeanUtils;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

/**
 * 面试经验接口
 */
@RestController
@RequestMapping("/experience")
@Slf4j
public class ExperienceController {

    @Resource
    private ExperienceService experienceService;

    @Resource
    private UserService userService;

    /**
     * 点赞
     *
     * @param experienceId
     * @param request
     * @return
     */
    @PostMapping("/thumb")
    public BaseResponse<Boolean> thumbExperience(@RequestParam long experienceId, HttpServletRequest request) {
        if (experienceId <= 0) {
            throw new BusinessException(ErrorCode.PARAMS_ERROR);
        }
        // 登录才能点赞
        final User loginUser = userService.getLoginUser(request);
        long userId = loginUser.getId();
        // 判断实体是否存在
        Experience experience = experienceService.getById(experienceId);
        ThrowUtils.throwIf(experience == null, ErrorCode.NOT_FOUND_ERROR);
        // 是否已点赞
        long result = experienceService.doExperienceThumb(userId, experienceId);
        return ResultUtils.success(result > 0);
    }

    /**
     * 获取点赞状态
     *
     * @param experienceId
     * @param request
     * @return
     */
    @GetMapping("/thumb/check")
    public BaseResponse<Boolean> checkExperienceThumb(@RequestParam long experienceId, HttpServletRequest request) {
        if (experienceId <= 0) {
            throw new BusinessException(ErrorCode.PARAMS_ERROR);
        }
        // 登录才能点赞
        final User loginUser = userService.getLoginUser(request);
        long userId = loginUser.getId();
        // 判断实体是否存在
        Experience experience = experienceService.getById(experienceId);
        ThrowUtils.throwIf(experience == null, ErrorCode.NOT_FOUND_ERROR);
        // 获取点赞状态
        boolean result = experienceService.hasExperienceThumb(userId, experienceId);
        return ResultUtils.success(result);
    }

    /**
     * 获取点赞数
     *
     * @param experienceId
     * @return
     */
    @GetMapping("/thumb/count")
    public BaseResponse<Long> getExperienceThumbCount(@RequestParam long experienceId) {
        if (experienceId <= 0) {
            throw new BusinessException(ErrorCode.PARAMS_ERROR);
        }
        // 获取点赞数
        long result = experienceService.getExperienceThumbCount(experienceId);
        return ResultUtils.success(result);
    }

    /**
     * 创建面试经验
     */
    @PostMapping("/add")
    public BaseResponse<Long> addExperience(@RequestBody ExperienceAddRequest experienceAddRequest, HttpServletRequest request) {
        if (experienceAddRequest == null) {
            throw new BusinessException(ErrorCode.PARAMS_ERROR);
        }
        Experience experience = new Experience();
        BeanUtils.copyProperties(experienceAddRequest, experience);

        if (experienceAddRequest.getTags() != null) {
            experience.setTags(experienceAddRequest.getTags().toString());
        }

        experience.setAnswer(experienceAddRequest.getAnswer());

        User loginUser = userService.getLoginUser(request);
        experience.setUserId(loginUser.getId());
        boolean result = experienceService.save(experience);
        ThrowUtils.throwIf(!result, ErrorCode.OPERATION_ERROR);
        return ResultUtils.success(experience.getId());
    }

    /**
     * 删除面试经验
     */
    @PostMapping("/delete")
    public BaseResponse<Boolean> deleteExperience(@RequestParam long id, HttpServletRequest request) {
        if (id <= 0) {
            throw new BusinessException(ErrorCode.PARAMS_ERROR);
        }
        User loginUser = userService.getLoginUser(request);
        // 判断是否存在
        Experience experience = experienceService.getById(id);
        ThrowUtils.throwIf(experience == null, ErrorCode.NOT_FOUND_ERROR);
        // 仅本人或管理员可删除
        if (!experience.getUserId().equals(loginUser.getId()) && !userService.isAdmin(loginUser)) {
            throw new BusinessException(ErrorCode.NO_AUTH_ERROR);
        }
        boolean result = experienceService.removeById(id);
        return ResultUtils.success(result);
    }

    /**
     * 更新面试经验
     */
    @PostMapping("/update")
    public BaseResponse<Boolean> updateExperience(@RequestBody ExperienceUpdateRequest experienceUpdateRequest, HttpServletRequest request) {
        if (experienceUpdateRequest == null || experienceUpdateRequest.getId() <= 0) {
            throw new BusinessException(ErrorCode.PARAMS_ERROR);
        }
        Experience experience = new Experience();
        BeanUtils.copyProperties(experienceUpdateRequest, experience);
        User loginUser = userService.getLoginUser(request);
        // 判断是否存在
        Experience oldExperience = experienceService.getById(experience.getId());
        ThrowUtils.throwIf(oldExperience == null, ErrorCode.NOT_FOUND_ERROR);
        // 仅本人或管理员可更新
        if (!oldExperience.getUserId().equals(loginUser.getId()) && !userService.isAdmin(loginUser)) {
            throw new BusinessException(ErrorCode.NO_AUTH_ERROR);
        }
        boolean result = experienceService.updateById(experience);
        return ResultUtils.success(result);
    }

    /**
     * 根据 id 获取面试经验
     */
    @GetMapping("/get")
    public BaseResponse<ExperienceVO> getExperienceById(@RequestParam long id, HttpServletRequest request) {
        if (id <= 0) {
            throw new BusinessException(ErrorCode.PARAMS_ERROR);
        }
        Experience experience = experienceService.getById(id);
        if (experience == null) {
            throw new BusinessException(ErrorCode.NOT_FOUND_ERROR);
        }
        return ResultUtils.success(experienceService.getExperienceVO(experience, request));
    }

    /**
     * 分页获取面试经验列表
     */
    @PostMapping("/list/page")
    public BaseResponse<Page<ExperienceVO>> listExperienceByPage(@RequestBody ExperienceQueryRequest experienceQueryRequest,
            HttpServletRequest request) {
        long current = experienceQueryRequest.getCurrent();
        long size = experienceQueryRequest.getSize();
        // 限制爬虫
        ThrowUtils.throwIf(size > 20, ErrorCode.PARAMS_ERROR);
        Page<Experience> experiencePage = experienceService.listExperienceByPage(experienceQueryRequest.getSearchText(), current, size);
        return ResultUtils.success(experienceService.getExperienceVOPage(experiencePage, request));
    }

    /**
     * 分页获取当前用户创建的面试经验列表
     */
    @PostMapping("/my/list/page")
    public BaseResponse<Page<ExperienceVO>> listMyExperienceByPage(@RequestBody ExperienceQueryRequest experienceQueryRequest,
            HttpServletRequest request) {
        if (experienceQueryRequest == null) {
            throw new BusinessException(ErrorCode.PARAMS_ERROR);
        }
        User loginUser = userService.getLoginUser(request);
        experienceQueryRequest.setUserId(loginUser.getId());
        long current = experienceQueryRequest.getCurrent();
        long size = experienceQueryRequest.getSize();
        // 限制爬虫
        ThrowUtils.throwIf(size > 20, ErrorCode.PARAMS_ERROR);
        QueryWrapper<Experience> queryWrapper = new QueryWrapper<>();
        queryWrapper.eq("userId", loginUser.getId());
        queryWrapper.orderByDesc("createTime");
        Page<Experience> experiencePage = experienceService.page(new Page<>(current, size), queryWrapper);
        return ResultUtils.success(experienceService.getExperienceVOPage(experiencePage, request));
    }



} 