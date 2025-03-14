package com.szl.mianshi.model.dto.experience;

import lombok.Data;

import java.io.Serializable;
import java.util.List;

/**
 * 创建面试经验请求
 */
@Data
public class ExperienceAddRequest implements Serializable {

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
    private List<String> tags;

    /**
     * 参考答案
     */
    private String answer;

    private static final long serialVersionUID = 1L;
} 