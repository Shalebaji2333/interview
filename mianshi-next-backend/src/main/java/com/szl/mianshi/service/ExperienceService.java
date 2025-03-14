package com.szl.mianshi.service;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.IService;
import com.szl.mianshi.model.entity.Experience;
import com.szl.mianshi.model.vo.ExperienceVO;

import javax.servlet.http.HttpServletRequest;

/**
 * 面试经验服务
 */
public interface ExperienceService extends IService<Experience> {

    /**
     * 点赞
     *
     * @param userId
     * @param experienceId
     * @return
     */
    long doExperienceThumb(long userId, long experienceId);

    /**
     * 获取点赞状态
     *
     * @param userId
     * @param experienceId
     * @return
     */
    boolean hasExperienceThumb(long userId, long experienceId);

    /**
     * 获取点赞数
     *
     * @param experienceId
     * @return
     */
    long getExperienceThumbCount(long experienceId);

    /**
     * 获取面试经验封装
     *
     * @param experience
     * @param request
     * @return
     */
    ExperienceVO getExperienceVO(Experience experience, HttpServletRequest request);

    /**
     * 分页获取面试经验封装
     *
     * @param experiencePage
     * @param request
     * @return
     */
    Page<ExperienceVO> getExperienceVOPage(Page<Experience> experiencePage, HttpServletRequest request);

    /**
     * 分页获取面试经验列表
     *
     * @param searchText
     * @param current
     * @param size
     * @return
     */
    Page<Experience> listExperienceByPage(String searchText, long current, long size);
} 