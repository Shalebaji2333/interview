package com.szl.mianshi.service;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.IService;
import com.szl.mianshi.model.dto.question.QuestionQueryRequest;
import com.szl.mianshi.model.entity.Question;
import com.szl.mianshi.model.vo.QuestionVO;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

/**
 * 题目服务
 *
 * @author szl
 * @from www.szl.icu
 */
public interface QuestionService extends IService<Question> {

    /**
     * 校验数据
     *
     * @param question
     * @param add      对创建的数据进行校验
     */
    void validQuestion(Question question, boolean add);

    /**
     * 获取查询条件
     *
     * @param questionQueryRequest
     * @return
     */
    QueryWrapper<Question> getQueryWrapper(QuestionQueryRequest questionQueryRequest);

    /**
     * 获取题目封装
     *
     * @param question
     * @param request
     * @return
     */
    QuestionVO getQuestionVO(Question question, HttpServletRequest request);

    /**
     * 分页获取题目封装
     *
     * @param questionPage
     * @param request
     * @return
     */
    Page<QuestionVO> getQuestionVOPage(Page<Question> questionPage, HttpServletRequest request);

    /**
     * 分页获取题目列表
     *
     * @param questionQueryRequest
     * @return
     */
    Page<Question> listQuestionByPage(QuestionQueryRequest questionQueryRequest);

    /**
     * 从 ES 查询题目
     *
     * @param questionQueryRequest
     * @return
     */
    Page<Question> searchFromEs(QuestionQueryRequest questionQueryRequest);

    /**
     * 批量删除题目
     *
     * @param questionIdList
     */

    void batchDeleteQuestions(List<Long> questionIdList);

    /**
     * 点赞
     *
     * @param userId
     * @param questionId
     * @return
     */
    long doQuestionThumb(long userId, long questionId);

    /**
     * 题目点赞（内部服务）
     *
     * @param userId
     * @param questionId
     * @return
     */
    int doQuestionThumbInner(long userId, long questionId);

    /**
     * 获取点赞状态
     * @param userId
     * @param questionId
     * @return
     */
    boolean hasQuestionThumb(long userId, long questionId);

    /**
     * 获取点赞数
     * @param questionId
     * @return
     */
    long getQuestionThumbCount(long questionId);
}