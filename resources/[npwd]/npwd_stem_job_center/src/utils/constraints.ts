import { Job } from "../types/jobs";

export const MockJobCenter: Job[] = [
    {
        grade: 0,
        id: "garbage",
        isWhitelisted: false,
        title: "Garbage Man - Recruit"
    },
    {
        grade: 1,
        id: "lspd",
        isWhitelisted: true,
        title: "LSPD - Officer 1",
    },
    {
        grade: 5,
        id: "burgershot",
        isWhitelisted: true,
        title: "Burger Shot - CEO",
    },
    {
        grade: 0,
        id: "trucking",
        isWhitelisted: false,
        title: "Trucker - Recruit",
    },
    {
        grade: 0,
        id: "bus",
        isWhitelisted: false,
        title: "Bus Driver - Recruit",
    },
    {
        grade: 5,
        id: "burgershot",
        isWhitelisted: true,
        title: "Burger Shot - CEO",
    },
    {
        grade: 0,
        id: "trucking",
        isWhitelisted: false,
        title: "Trucker - Recruit",
    },
    {
        grade: 0,
        id: "bus",
        isWhitelisted: false,
        title: "Bus Driver - Recruit",
    },
    {
        grade: 5,
        id: "burgershot",
        isWhitelisted: true,
        title: "Burger Shot - CEO",
    },
    {
        grade: 0,
        id: "trucking",
        isWhitelisted: false,
        title: "Trucker - Recruit",
    },
    {
        grade: 0,
        id: "bus",
        isWhitelisted: false,
        title: "Bus Driver - Recruit",
    },
  ];

export const MockCurrentJob = {name: "lspd", grade: 1}