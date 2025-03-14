package com.szl.mianshi.service.impl;

import cn.hutool.core.collection.CollUtil;
import cn.hutool.json.JSONUtil;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.szl.mianshi.common.ErrorCode;
import com.szl.mianshi.exception.ThrowUtils;
import com.szl.mianshi.mapper.ExperienceMapper;
import com.szl.mianshi.model.entity.Experience;
import com.szl.mianshi.model.entity.ExperienceThumb;
import com.szl.mianshi.model.entity.User;
import com.szl.mianshi.model.vo.ExperienceVO;
import com.szl.mianshi.model.vo.UserVO;
import com.szl.mianshi.service.ExperienceService;
import com.szl.mianshi.service.ExperienceThumbService;
import com.szl.mianshi.service.UserService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.StringUtils;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.stream.Collectors;

/**
 * 面试经验服务实现
 */
@Slf4j
@Service
public class ExperienceServiceImpl extends ServiceImpl<ExperienceMapper, Experience>
        implements ExperienceService {

    @Resource
    private ExperienceThumbService experienceThumbService;

    @Resource
    private UserService userService;

    @Override
    public long doExperienceThumb(long userId, long experienceId) {
        // 1. 判断实体是否存在
        Experience experience = this.getById(experienceId);
        ThrowUtils.throwIf(experience == null, ErrorCode.NOT_FOUND_ERROR);
        // 2. 是否已点赞
        long result = doExperienceThumbInner(userId, experienceId);
        // 3. 更新点赞数
        if (result > 0) {
            this.update()
                .setSql("thumbNum = thumbNum + 1")
                .eq("id", experienceId)
                .update();
        } else if (result < 0) {
            this.update()
                .setSql("thumbNum = thumbNum - 1")
                .eq("id", experienceId)
                .update();
        }
        return result;
    }

    @Override
    public boolean hasExperienceThumb(long userId, long experienceId) {
        ExperienceThumb experienceThumb = new ExperienceThumb();
        experienceThumb.setUserId(userId);
        experienceThumb.setExperienceId(experienceId);
        QueryWrapper<ExperienceThumb> thumbQueryWrapper = new QueryWrapper<>(experienceThumb);
        return experienceThumbService.selectCount(thumbQueryWrapper) > 0;
    }

    @Override
    public long getExperienceThumbCount(long experienceId) {
        ExperienceThumb experienceThumb = new ExperienceThumb();
        experienceThumb.setExperienceId(experienceId);
        QueryWrapper<ExperienceThumb> thumbQueryWrapper = new QueryWrapper<>(experienceThumb);
        return experienceThumbService.selectCount(thumbQueryWrapper);
    }

    @Override
    public ExperienceVO getExperienceVO(Experience experience, HttpServletRequest request) {
        ExperienceVO experienceVO = ExperienceVO.objToVo(experience);
        if (experienceVO == null) {
            return null;
        }
        // 关联查询用户信息
        Long userId = experience.getUserId();
        User user = null;
        if (userId != null && userId > 0) {
            user = userService.getById(userId);
        }
        UserVO userVO = userService.getUserVO(user);
        experienceVO.setUser(userVO);
        // 转换标签格式
        String tagsStr = experience.getTags();
        experienceVO.setTagList(convertTagsToList(tagsStr));
        return experienceVO;
    }

    @Override
    public Page<ExperienceVO> getExperienceVOPage(Page<Experience> experiencePage, HttpServletRequest request) {
        List<Experience> experienceList = experiencePage.getRecords();
        Page<ExperienceVO> experienceVOPage = new Page<>(experiencePage.getCurrent(), experiencePage.getSize(), experiencePage.getTotal());
        if (CollUtil.isEmpty(experienceList)) {
            return experienceVOPage;
        }
        // 1. 关联查询用户信息
        Set<Long> userIdSet = experienceList.stream().map(Experience::getUserId).collect(Collectors.toSet());
        Map<Long, List<User>> userIdUserListMap = userService.listByIds(userIdSet).stream()
                .collect(Collectors.groupingBy(User::getId));
        // 2. 填充信息
        List<ExperienceVO> experienceVOList = experienceList.stream().map(experience -> {
            ExperienceVO experienceVO = ExperienceVO.objToVo(experience);
            Long userId = experience.getUserId();
            User user = null;
            if (userIdUserListMap.containsKey(userId)) {
                user = userIdUserListMap.get(userId).get(0);
            }
            experienceVO.setUser(userService.getUserVO(user));
            // 转换标签格式
            String tagsStr = experience.getTags();
            experienceVO.setTagList(convertTagsToList(tagsStr));
            return experienceVO;
        }).collect(Collectors.toList());
        experienceVOPage.setRecords(experienceVOList);
        return experienceVOPage;
    }

    @Override
    public Page<Experience> listExperienceByPage(String searchText, long current, long size) {
        QueryWrapper<Experience> queryWrapper = new QueryWrapper<>();
        if (StringUtils.hasText(searchText)) {
            queryWrapper.and(wrapper -> wrapper
                    .like("title", searchText)
                    .or()
                    .like("content", searchText)
                    .or()
                    .like("tags", searchText)
            );
        }
        queryWrapper.orderByDesc("thumbNum", "createTime");
        return this.page(new Page<>(current, size), queryWrapper);
    }

    /**
     * 内部方法，处理点赞逻辑
     */
    private int doExperienceThumbInner(long userId, long experienceId) {
        ExperienceThumb experienceThumb = new ExperienceThumb();
        experienceThumb.setUserId(userId);
        experienceThumb.setExperienceId(experienceId);
        QueryWrapper<ExperienceThumb> thumbQueryWrapper = new QueryWrapper<>(experienceThumb);
        ExperienceThumb oldExperienceThumb = experienceThumbService.selectOne(thumbQueryWrapper);
        
        boolean result;
        // 已点赞
        if (oldExperienceThumb != null) {
            result = experienceThumbService.deleteById(oldExperienceThumb.getId()) > 0;
            return result ? -1 : 0;
        } else {
            result = experienceThumbService.insert(experienceThumb) > 0;
            return result ? 1 : 0;
        }
    }

    private List<String> convertTagsToList(String tagsStr) {
        if (!StringUtils.hasText(tagsStr)) {
            return new ArrayList<>();
        }
        try {
            return JSONUtil.parseArray(tagsStr).toList(String.class);
        } catch (Exception e) {
            log.error("标签转换失败, tagsStr = {}", tagsStr, e);
            return new ArrayList<>();
        }
    }
} 