import { ServerPromiseResp } from "../types/common";

export const isEnvBrowser = (): boolean => !(window as any).invokeNative;

export const getResourceName = () =>
	(window as any).GetParentResourceName ? (window as any)?.GetParentResourceName() : 'npwd';

export const buildRespObj = (
	data: any,
	status?: 'ok' | 'error' | undefined,
	errorMsg?: string,
): ServerPromiseResp<any> => ({
	data,
	status,
	errorMsg,
});