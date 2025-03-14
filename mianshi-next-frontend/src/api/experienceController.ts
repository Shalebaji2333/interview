import request from "@/libs/request";

/** 创建面试经验 */
export async function addExperienceUsingPost(
  body: API.ExperienceAddRequest,
  options?: { [key: string]: any }
) {
  return request<API.BaseResponseLong_>("/api/experience/add", {
    method: "POST",
    headers: {
      "Content-Type": "application/json",
    },
    data: body,
    ...(options || {}),
  });
}

/** 获取面试经验 */
export async function getExperienceVoByIdUsingGet(id: number) {
  return request<API.BaseResponseExperienceVO_>(`/api/experience/get?id=${id}`);
}

/** 分页获取面试经验列表 */
export async function listExperienceByPageUsingPost(
  body: API.ExperienceQueryRequest,
  options?: { [key: string]: any }
) {
  return request<API.BaseResponsePageExperienceVO_>("/api/experience/list/page", {
    method: "POST",
    headers: {
      "Content-Type": "application/json",
    },
    data: body,
    ...(options || {}),
  });
}

/** 点赞 */
export async function thumbExperienceUsingPost(experienceId: number) {
  return request<API.BaseResponseBoolean_>(`/api/experience/thumb?experienceId=${experienceId}`, {
    method: "POST",
  });
}

/** 获取点赞状态 */
export async function checkExperienceThumbUsingGet(experienceId: number) {
  return request<API.BaseResponseBoolean_>(`/api/experience/thumb/check?experienceId=${experienceId}`);
}

/** 获取点赞数 */
export async function getExperienceThumbCountUsingGet(experienceId: number) {
  return request<API.BaseResponseLong_>(`/api/experience/thumb/count?experienceId=${experienceId}`);
}

export const experienceApi = {
  searchExperiences: async (params: SearchParams) => {
    return request.post('/api/experience/search', params);
  },
  
  getExperienceDetail: async (id: number) => {
    return request.get(`/api/experience/${id}`);
  }
}; 