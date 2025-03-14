package com.szl.mianshi.model.dto.experience;

import com.szl.mianshi.model.dto.PageRequest;
import lombok.Data;
import lombok.EqualsAndHashCode;

import java.io.Serializable;
import java.util.List;

/**
 * 查询面试经验请求
 */
@EqualsAndHashCode(callSuper = true)
@Data
public class ExperienceQueryRequest extends PageRequest implements Serializable {

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
    private List<String> tags;

    /**
     * 创建用户 id
     */
    private Long userId;

    /**
     * 搜索词
     */
    private String searchText;

    private static final long serialVersionUID = 1L;
} 