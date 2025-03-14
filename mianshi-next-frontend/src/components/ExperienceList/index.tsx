"use client";
import { Card, List, Space, Tag, Typography } from "antd";
import { LikeOutlined, MessageOutlined } from "@ant-design/icons";
import { useRouter } from "next/navigation";
import dayjs from "dayjs";

const { Title, Paragraph } = Typography;

interface ExperienceListProps {
  loading: boolean;
  experienceList: API.ExperienceVO[];
  total: number;
  current: number;
  pageSize: number;
  onPageChange: (page: number, pageSize: number) => void;
}

/**
 * 面试经验列表组件
 */
const ExperienceList: React.FC<ExperienceListProps> = ({
  loading,
  experienceList,
  total,
  current,
  pageSize,
  onPageChange
}) => {
  const router = useRouter();

  const IconText = ({ icon, text }: { icon: React.FC; text: string }) => (
    <Space>
      {React.createElement(icon)}
      {text}
    </Space>
  );

  return (
    <List
      loading={loading}
      itemLayout="vertical"
      size="large"
      pagination={{
        total,
        current,
        pageSize,
        onChange: onPageChange,
        showSizeChanger: true,
        showTotal: (total) => `共 ${total} 条记录`
      }}
      dataSource={experienceList}
      renderItem={(item) => (
        <Card 
          hoverable 
          style={{ marginBottom: 16 }}
          onClick={() => router.push(`/experience/${item.id}`)}
        >
          <List.Item
            key={item.id}
            actions={[
              <IconText icon={LikeOutlined} text={item.thumbNum?.toString() ?? "0"} key="list-vertical-like-o" />,
              <IconText icon={MessageOutlined} text="0" key="list-vertical-message" />,
            ]}
          >
            <List.Item.Meta
              title={<Title level={4}>{item.title}</Title>}
              description={
                <Space size={[0, 8]} wrap>
                  {item.tagList?.map((tag) => (
                    <Tag key={tag}>{tag}</Tag>
                  ))}
                  <Tag>{dayjs(item.createTime).format("YYYY-MM-DD")}</Tag>
                  <Tag>{item.user?.userName}</Tag>
                </Space>
              }
            />
            <Paragraph
              ellipsis={{ rows: 3 }}
              style={{ marginBottom: 0 }}
            >
              {item.content}
            </Paragraph>
          </List.Item>
        </Card>
      )}
    />
  );
};

export default ExperienceList; 