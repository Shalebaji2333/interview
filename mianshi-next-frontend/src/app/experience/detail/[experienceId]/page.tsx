"use server";
import { getExperienceVoByIdUsingGet } from "@/api/experienceController";
import { notFound } from "next/navigation";
import ExperienceDetail from "@/components/ExperienceDetail";
import "./index.css";

/**
 * 面试经验详情页面
 */
export default async function ExperienceDetailPage({
  params,
}: {
  params: { experienceId: string };
}) {
  const { experienceId } = params;
  
  try {
    const res = await getExperienceVoByIdUsingGet(parseInt(experienceId));
    
    // 如果获取不到数据，返回 404
    if (!res?.data) {
      return notFound();
    }

    return (
      <div id="experienceDetailPage">
        <div className="max-width-content">
          <ExperienceDetail experience={res.data} />
        </div>
      </div>
    );
  } catch (error) {
    return notFound();
  }
} 