package com.szl.mianshi.service;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.service.IService;
import com.szl.mianshi.model.entity.QuestionThumb;

/**
 * 题目点赞服务
 */
public interface QuestionThumbService extends IService<QuestionThumb> {

    /**
     * 点赞
     *
     * @param questionThumb
     * @return
     */
    int insert(QuestionThumb questionThumb);

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
    QuestionThumb selectOne(QueryWrapper<QuestionThumb> queryWrapper);

    /**
     * 查询点赞数
     *
     * @param queryWrapper
     * @return
     */
    long selectCount(QueryWrapper<QuestionThumb> queryWrapper);
} 