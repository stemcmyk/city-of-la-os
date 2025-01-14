export interface Job {
    title: string,
    id: string,
    grade: number,
    jobCategory: string
}

export interface SeparatedJobs {
    [key: string]: Job[] | undefined
}

export interface JobCenterData {
    currentJob: string | undefined;
    jobs: Job[]
}

export interface JobUpdateData  {
    id: string;
    grade: number;
}

export interface JobData { name: string, grade: number}