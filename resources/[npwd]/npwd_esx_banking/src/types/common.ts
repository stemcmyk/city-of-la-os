export interface ServerPromiseResp<T = undefined> {
	errorMsg?: string;
	status: 'ok' | 'error' | undefined;
	data?: T;
}


export interface Transaction {
	name: string;
	amount: number;
	date: Date;
	type: number;
}
