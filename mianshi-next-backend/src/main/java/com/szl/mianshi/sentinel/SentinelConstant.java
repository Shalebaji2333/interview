package com.szl.mianshi.sentinel;

/**
 * Sentinel 限流熔断常量
 *
 * @author szl
 * @from www.szl.icu
 */
public interface SentinelConstant {

    /**
     * 分页获取题库列表接口限流
     */
    String listQuestionBankVOByPage = "listQuestionBankVOByPage";

    /**
     * 分页获取题目列表接口限流
     */
    String listQuestionVOByPage = "listQuestionVOByPage";
}
