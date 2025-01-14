export interface Job {
    title: string,
    amount: number,
}

export interface SeparatedJobs {
    [key: string]: Job | undefined
}