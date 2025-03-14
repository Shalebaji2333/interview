package com.szl.mianshi.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.szl.mianshi.mapper.QuestionThumbMapper;
import com.szl.mianshi.model.entity.QuestionThumb;
import com.szl.mianshi.service.QuestionThumbService;
import org.springframework.stereotype.Service;

/**
 * 题目点赞服务实现
 */
@Service
public class QuestionThumbServiceImpl extends ServiceImpl<QuestionThumbMapper, QuestionThumb>
        implements QuestionThumbService {

    @Override
    public int insert(QuestionThumb questionThumb) {
        return baseMapper.insert(questionThumb);
    }

    @Override
    public int deleteById(Long id) {
        return baseMapper.deleteById(id);
    }

    @Override
    public QuestionThumb selectOne(QueryWrapper<QuestionThumb> queryWrapper) {
        return baseMapper.selectOne(queryWrapper);
    }

    @Override
    public long selectCount(QueryWrapper<QuestionThumb> queryWrapper) {
        return baseMapper.selectCount(queryWrapper);
    }
} 