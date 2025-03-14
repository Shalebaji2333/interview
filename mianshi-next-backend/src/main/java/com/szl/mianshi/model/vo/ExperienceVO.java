package com.szl.mianshi.model.vo;

import com.szl.mianshi.model.entity.Experience;
import lombok.Data;
import org.springframework.beans.BeanUtils;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

/**
 * 面试经验视图
 */
@Data
public class ExperienceVO implements Serializable {

    /**
     * id
     */
    private Long id;

    /**
     * 标题
     */
    private String title;

    /**
     * 内容
     */
    private String content;

    /**
     * 标签列表
     */
    private List<String> tagList;

    /**
     * 参考答案
     */
    private String answer;

    /**
     * 创建用户 id
     */
    private Long userId;

    /**
     * 创建用户信息
     */
    private UserVO user;

    /**
     * 点赞数
     */
    private Integer thumbNum;

    /**
     * 创建时间
     */
    private Date createTime;

    /**
     * 更新时间
     */
    private Date updateTime;

    private static final long serialVersionUID = 1L;

    /**
     * 包装类转对象
     *
     * @param experienceVO
     * @return
     */
    public static Experience voToObj(ExperienceVO experienceVO) {
        if (experienceVO == null) {
            return null;
        }
        Experience experience = new Experience();
        BeanUtils.copyProperties(experienceVO, experience);
        return experience;
    }

    /**
     * 对象转包装类
     *
     * @param experience
     * @return
     */
    public static ExperienceVO objToVo(Experience experience) {
        if (experience == null) {
            return null;
        }
        ExperienceVO experienceVO = new ExperienceVO();
        BeanUtils.copyProperties(experience, experienceVO);
        return experienceVO;
    }
} 