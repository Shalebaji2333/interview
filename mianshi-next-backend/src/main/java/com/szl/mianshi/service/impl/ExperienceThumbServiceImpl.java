package com.szl.mianshi.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.szl.mianshi.mapper.ExperienceThumbMapper;
import com.szl.mianshi.model.entity.ExperienceThumb;
import com.szl.mianshi.service.ExperienceThumbService;
import org.springframework.stereotype.Service;

/**
 * 面试经验点赞服务实现
 */
@Service
public class ExperienceThumbServiceImpl extends ServiceImpl<ExperienceThumbMapper, ExperienceThumb>
        implements ExperienceThumbService {

    @Override
    public int insert(ExperienceThumb experienceThumb) {
        return baseMapper.insert(experienceThumb);
    }

    @Override
    public int deleteById(Long id) {
        return baseMapper.deleteById(id);
    }

    @Override
    public ExperienceThumb selectOne(QueryWrapper<ExperienceThumb> queryWrapper) {
        return baseMapper.selectOne(queryWrapper);
    }

    @Override
    public long selectCount(QueryWrapper<ExperienceThumb> queryWrapper) {
        return baseMapper.selectCount(queryWrapper);
    }
} 