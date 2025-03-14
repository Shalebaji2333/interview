package com.szl.mianshi.service;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.service.IService;
import com.szl.mianshi.model.entity.ExperienceThumb;

/**
 * 面试经验点赞服务
 */
public interface ExperienceThumbService extends IService<ExperienceThumb> {

    /**
     * 点赞
     *
     * @param experienceThumb
     * @return
     */
    int insert(ExperienceThumb experienceThumb);

    /**
     * 删除点赞
     *
     * @param id
     * @return
     */
    int deleteById(Long id);

    /**
     * 查询点赞
     *
     * @param queryWrapper
     * @return
     */
    ExperienceThumb selectOne(QueryWrapper<ExperienceThumb> queryWrapper);

    /**
     * 查询点赞数
     *
     * @param queryWrapper
     * @return
     */
    long selectCount(QueryWrapper<ExperienceThumb> queryWrapper);
} 