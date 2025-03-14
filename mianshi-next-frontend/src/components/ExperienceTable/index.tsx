"use client";
import { listExperienceByPageUsingPost } from "@/api/experienceController";
import type { ActionType, ProColumns } from "@ant-design/pro-components";
import { ProTable } from "@ant-design/pro-components";
import React, { useRef, useState, useEffect } from "react";
import TagList from "@/components/TagList";
import { TablePaginationConfig, Button, Modal, Form, Input, Select, message } from "antd";
import Link from "next/link";
import { PlusOutlined } from "@ant-design/icons";
import { addExperienceUsingPost } from "@/api/experienceController";
import MdEditor from "@/components/MdEditor";

interface Props {
  // 默认值（用于展示服务端渲染的数据）
  defaultExperienceList?: API.ExperienceVO[];
  defaultTotal?: number;
  // 默认搜索条件
  defaultSearchParams?: {
    searchText?: string;
  };
  defaultError?: string;
}

/**
 * 面试经验表格组件
 */
const ExperienceTable: React.FC<Props> = (props) => {
  const { defaultExperienceList, defaultTotal, defaultSearchParams = {}, defaultError } = props;
  const actionRef = useRef<ActionType>();
  const [form] = Form.useForm();
  
  // 是否显示新建窗口
  const [createModalVisible, setCreateModalVisible] = useState<boolean>(false);
  
  // 面试经验列表
  const [experienceList, setExperienceList] = useState<API.ExperienceVO[]>(
    defaultExperienceList || []
  );
  // 总数
  const [total, setTotal] = useState<number>(defaultTotal || 0);
  // 用于判断是否首次加载
  const [init, setInit] = useState<boolean>(true);

  useEffect(() => {
    if (defaultError) {
      message.error(defaultError);
    }
  }, [defaultError]);

  /**
   * 表格列配置
   */
  const columns: ProColumns<API.ExperienceVO>[] = [
    {
      title: "搜索",
      dataIndex: "searchText",
      valueType: "text",
      hideInTable: true,
    },
    {
      title: "标题",
      dataIndex: "title",
      valueType: "text",
      hideInSearch: true,
      render: (_, record) => (
        <Link href={`/experience/detail/${record.id}`}>{record.title}</Link>
      ),
    },
    {
      title: "标签",
      dataIndex: "tagList",
      valueType: "select",
      fieldProps: {
        mode: "tags",
      },
      render: (_, record) => (
        <TagList tagList={record.tagList} />
      ),
    },
    {
      title: "发布者",
      dataIndex: "user",
      valueType: "text",
      hideInSearch: true,
      width: 100,
      render: (_, record) => record.user?.userName || '-',
    },
  ];

  /**
   * 新增面试经验
   */
  const handleAdd = async (values: API.ExperienceAddRequest) => {
    const hide = message.loading('正在添加');
    try {
      await addExperienceUsingPost({
        ...values,
        tagList: values.tags || [],
        answer: '',
      });
      hide();
      message.success('创建成功');
      if (actionRef.current) {
        actionRef.current.reload();
      }
      return true;
    } catch (error: any) {
      hide();
      message.error('创建失败，' + error.message);
      return false;
    }
  };

  return (
    <div>
      <ProTable<API.ExperienceVO>
        actionRef={actionRef}
        size="large"
        search={{
          labelWidth: "auto",
        }}
        form={{
          initialValues: defaultSearchParams,
        }}
        toolBarRender={() => [
          <Button
            type="primary"
            key="primary"
            icon={<PlusOutlined />}
            onClick={() => setCreateModalVisible(true)}
          >
            新建
          </Button>,
        ]}
        dataSource={experienceList}
        pagination={{
          pageSize: 12,
          showTotal: (total) => `总共 ${total} 条`,
          showSizeChanger: false,
          total,
        } as TablePaginationConfig}
        request={async (params, sort, filter) => {
          // 首次请求
          if (init) {
            setInit(false);
            if (defaultExperienceList && defaultTotal) {
              return {
                data: defaultExperienceList,
                success: true,
                total: defaultTotal
              };
            }
          }

          const sortField = Object.keys(sort)?.[0] || "createTime";
          const sortOrder = sort?.[sortField] || "descend";

          try {
            const res = await listExperienceByPageUsingPost({
              ...params,
              size: params.pageSize ?? 12,
              sortField,
              sortOrder,
              searchText: params.searchText,
              ...filter,
            } as API.ExperienceQueryRequest);

            if (res?.data) {
              const newData = res.data.records ?? [];
              const newTotal = res.data.total ?? 0;
              
              setExperienceList(newData);
              setTotal(newTotal);

              return {
                data: newData,
                success: true,
                total: newTotal
              };
            }
            throw new Error('获取数据失败');
          } catch (error: any) {
            message.error(error.message || '获取面试经验列表失败');
            return {
              data: [],
              success: false,
              total: 0
            };
          }
        }}
        columns={columns}
      />
      
      <Modal
        destroyOnClose
        title="新建面试经验"
        open={createModalVisible}
        width={800}
        onOk={() => {
          form.validateFields()
            .then(async (values) => {
              const success = await handleAdd(values);
              if (success) {
                form.resetFields();
                setCreateModalVisible(false);
                if (actionRef.current) {
                  actionRef.current.reload();
                }
              }
            })
        }}
        onCancel={() => {
          form.resetFields();
          setCreateModalVisible(false);
        }}
      >
        <Form 
          form={form}
          layout="vertical"
          style={{ marginTop: 24 }}
        >
          <Form.Item
            name="title"
            label="标题"
            rules={[{ required: true, message: '请输入标题' }]}
          >
            <Input placeholder="请输入标题" />
          </Form.Item>
          <Form.Item
            name="content"
            label="内容"
            rules={[{ required: true, message: '请输入内容' }]}
          >
            <MdEditor />
          </Form.Item>
          <Form.Item
            name="tags"
            label="标签"
            rules={[{ required: true, message: '请选择标签' }]}
          >
            <Select
              mode="tags"
              style={{ width: '100%' }}
              placeholder="请选择标签"
              tokenSeparators={[',']}
            />
          </Form.Item>
        </Form>
      </Modal>
    </div>
  );
};

export default ExperienceTable; 