"use client";
import { Card, message, Space, Typography, Skeleton } from "antd";
import "./index.css";
import { useEffect, useState } from "react";
import QuestionCard from "@/components/QuestionCard";
import { 
    ClockCircleOutlined, 
    UserOutlined, 
    EyeOutlined, 
    ReadOutlined
} from "@ant-design/icons";
import dayjs from "dayjs";

// 生成测试数据的辅助函数
function generateMockData(startId: number, count: number): API.QuestionVO[] {
  const companies = ["阿里巴巴", "腾讯", "字节跳动", "美团", "百度", "京东", "华为", "小米"];
  const positions = ["前端", "后端", "全栈", "算法", "测试", "运维", "安全"];
  const tags = [
    "React", "Vue", "TypeScript", "Node.js", "Java", "Python", "Go",
    "MySQL", "Redis", "MongoDB", "Docker", "Kubernetes", "微服务",
    "系统设计", "算法", "网络", "操作系统", "设计模式"
  ];
  const users = [
    { name: "张工程", profile: "3年前端开发经验，热爱技术分享" },
    { name: "李算法", profile: "5年后端开发经验，算法竞赛金牌" },
    { name: "王全栈", profile: "4年全栈开发经验，擅长系统设计" },
    { name: "赵测试", profile: "6年测试开发经验，质量专家" },
    { name: "钱运维", profile: "7年运维开发经验，架构师" }
  ];

  function generateContent(company: string, position: string, tags: string[]): string {
    return `# ${company}${position}工程师面试经验分享

## 面试流程
1. 一面：技术面试（约60分钟）
2. 二面：技术+项目面试（约90分钟）
3. 三面：架构师面试（约60分钟）
4. HR面：薪资谈判（约30分钟）

## 技术要点
${tags.map(tag => `### ${tag}
- ${tag}相关的核心概念和原理
- ${tag}在实际项目中的应用场景
- ${tag}的性能优化和最佳实践\n`).join('\n')}

## 面试官提问
1. 介绍一下你最近做的项目？
2. 项目中遇到的最大挑战是什么？
3. 如何解决项目中的技术难点？
4. 对于系统性能优化有什么经验？
5. 如何保证代码质量和可维护性？

## 个人总结
1. 技术准备要全面，不仅要懂原理，还要有实践经验
2. 项目经验很重要，要能说清楚项目的难点和解决方案
3. 注意表达方式，要简洁清晰，逻辑性强
4. 对公司和团队保持足够的了解和兴趣`;
  }

  function generateAnswer(company: string, position: string, tags: string[]): string {
    return `# 面试准备要点

## 技术准备
${tags.map(tag => `### ${tag}
- 深入学习${tag}的核心概念和原理
- 准备${tag}相关的实际项目案例
- 总结${tag}的最佳实践和性能优化方案\n`).join('\n')}

## 项目准备
1. 梳理项目经验，准备2-3个重点项目
2. 针对每个项目，准备：
   - 项目背景和目标
   - 技术选型和架构设计
   - 个人职责和贡献
   - 遇到的挑战和解决方案
   - 项目成果和收获

## 面试技巧
1. 表达要清晰简洁，突出重点
2. 多举实例，展示实践经验
3. 主动沟通，展示解决问题的思路
4. 保持谦虚学习的态度

## 需要提升的地方
1. 继续深入学习核心技术
2. 加强系统设计和架构能力
3. 积累更多实战项目经验
4. 提升沟通表达能力`;
  }

  return Array.from({ length: count }, (_, index) => {
    const id = startId + index;
    const companyIndex = id % companies.length;
    const positionIndex = id % positions.length;
    const userIndex = id % users.length;
    
    // 随机选择2-4个标签
    const selectedTags = [...tags]
      .sort(() => Math.random() - 0.5)
      .slice(0, 2 + Math.floor(Math.random() * 3));
    
    // 添加公司和职位标签
    selectedTags.push(companies[companyIndex], positions[positionIndex]);

    const createTime = new Date(2024, 2, 20 - id).toISOString();
    
    return {
      id,
      title: `${companies[companyIndex]}${positions[positionIndex]}工程师面试经验分享`,
      tagList: selectedTags,
      createTime,
      updateTime: createTime,
      content: generateContent(companies[companyIndex], positions[positionIndex], selectedTags),
      answer: generateAnswer(companies[companyIndex], positions[positionIndex], selectedTags),
      userId: userIndex + 1,
      user: {
        id: userIndex + 1,
        userName: users[userIndex].name,
        userAvatar: `/assets/avatar${(userIndex % 5) + 1}.png`,
        userProfile: users[userIndex].profile,
        userRole: "user",
        createTime
      }
    };
  });
}

/**
 * 面试经验详情页
 */
export default function ExperiencePage({ params }: any) {
    const { id } = params;
    const [question, setQuestion]: any = useState(null);
    const [loading, setLoading] = useState(true);
    const [error, setError] = useState<string | null>(null);

    useEffect(() => {
        setLoading(true);
        try {
            const mockData = generateMockData(1, 50);
            const questionData = mockData.find(item => item.id === Number(id));
            if (questionData) {
                setQuestion(questionData);
            } else {
                setError("未找到该面试经验");
            }
        } catch (error: any) {
            message.error("获取面试经验详情失败，" + error.message);
            setError("获取面试经验详情失败，请稍后重试。");
        } finally {
            setLoading(false);
        }
    }, [id]);

    // 加载状态组件
    if (loading) {
        return (
            <div id="experiencePage">
                <div className="max-width-content">
                    <div className="experience-main">
                        <Card>
                            <Skeleton active paragraph={{ rows: 4 }} />
                        </Card>
                        <Card>
                            <Skeleton active paragraph={{ rows: 12 }} />
                        </Card>
                    </div>
                </div>
            </div>
        );
    }

    // 错误状态组件
    if (error || !question) {
        return (
            <div id="experiencePage">
                <div className="max-width-content">
                    <div className="experience-main">
                        <Card>
                            <div className="error-message">{error || "未找到该面试经验"}</div>
                        </Card>
                    </div>
                </div>
            </div>
        );
    }

    return (
        <div id="experiencePage">
            <div className="max-width-content">
                <div className="experience-main">
                    <Card className="title-card">
                        <Typography.Title level={1} style={{ margin: 0 }}>
                            {question.title}
                        </Typography.Title>
                    
                    </Card>
                    <div className="experience-content">
                        <QuestionCard question={question} />
                    </div>
                </div>
            </div>
        </div>
    );
} 