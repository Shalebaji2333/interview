"use client";
import React, { useState, useEffect } from 'react';
import { Card, Space, Button, message } from 'antd';
import Title from "antd/es/typography/Title";
import TagList from "@/components/TagList";
import MdViewer from "@/components/MdViewer";
import useAddUserSignInRecord from "@/hooks/useAddUserSignInRecord";
import { LikeOutlined, UserOutlined } from "@ant-design/icons";
import { 
  thumbExperienceUsingPost, 
  checkExperienceThumbUsingGet,
  getExperienceThumbCountUsingGet 
} from "@/api/experienceController";
import "./index.css";

interface Props {
  experience: API.ExperienceVO;
}

/**
 * 面试经验详情
 * @param props
 * @constructor
 */
const ExperienceDetail: React.FC<Props> = (props) => {
  const { experience } = props;
  const [thumbNum, setThumbNum] = useState<number>(experience.thumbNum || 0);
  const [hasThumb, setHasThumb] = useState<boolean>(false);

  // 签到
  useAddUserSignInRecord();

  // 获取点赞状态和点赞数
  const loadThumbData = async () => {
    if (!experience.id) {
      return;
    }
    try {
      // 获取点赞状态
      const thumbRes = await checkExperienceThumbUsingGet(experience.id);
      setHasThumb(thumbRes.data);  // 从 data.data 获取布尔值
      
      // 获取点赞数
      const countRes = await getExperienceThumbCountUsingGet(experience.id);
      setThumbNum(Number(countRes.data) || 0);  // 从 data.data 获取数字
    } catch (error: any) {
      message.error('获取点赞信息失败，' + error.message);
    }
  };

  useEffect(() => {
    loadThumbData();
  }, [experience.id]);

  // 点赞/取消点赞
  const handleThumb = async () => {
    if (!experience.id) {
      return;
    }
    try {
      // 发送请求
      const res = await thumbExperienceUsingPost(experience.id);
      if (res.code === 0) {
        // 请求成功后获取最新数据
        await loadThumbData();
        message.success(hasThumb ? '已取消点赞' : '点赞成功');
      } else {
        message.error('操作失败');
      }
    } catch (error: any) {
      message.error('操作失败，' + error.message);
    }
  };

  return (
    <div className="question-card">
      <Card>
        <Title level={1} style={{ fontSize: 24 }}>
          {experience.title}
        </Title>

        <div className="question-meta">
          <Space>
            <Space>
              <UserOutlined />
              <span className="publisher">{experience.user?.userName}</span>
            </Space>
            <Button 
              type={hasThumb ? "primary" : "text"} 
              icon={<LikeOutlined />} 
              onClick={handleThumb}
            >
              {thumbNum}
            </Button>
          </Space>
        </div>

        <TagList tagList={experience.tagList} />
        <div style={{ marginBottom: 16 }} />
      </Card>
      <div style={{ marginBottom: 16 }} />
      <Card title="内容">
        <MdViewer value={experience.content} />
      </Card>
    </div>
  );
};

export default ExperienceDetail; 