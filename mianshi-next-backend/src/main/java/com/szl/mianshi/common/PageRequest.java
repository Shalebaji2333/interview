package com.szl.mianshi.common;

import com.szl.mianshi.constant.CommonConstant;
import lombok.Data;

/**
 * 分页请求
 *
 * @author szl
 * @from www.szl.icu
 */
@Data
public class PageRequest {

    /**
     * 当前页号
     */
    private int current = 1;

    /**
     * 页面大小
     */
    private int pageSize = 10;

    /**
     * 排序字段
     */
    private String sortField;

    /**
     * 排序顺序（默认升序）
     */
    private String sortOrder = CommonConstant.SORT_ORDER_ASC;
}
