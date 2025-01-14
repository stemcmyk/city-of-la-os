import { ServerPromiseResp } from '@project-error/npwd-types';
import React, { useEffect, useState } from 'react';
import { Transaction } from '../types/common';
import { mockTransactions } from '../utils/consts';
import fetchNui from '../utils/fetchNui';
import Loading from './Loading';
import { isEnvBrowser } from '../utils/misc';
import { useNuiEvent } from 'react-fivem-hooks';

const Account: React.FC = () => {
  const [banking, setBanking] = useState<number | undefined>();
  const [lastTransactions, setLastTransactions] = useState<Transaction[]>();
  const [phoneNumber, setPhoneNumber] = useState<string>('');
  const [amount, setAmount] = useState<string>('');

  const formatText = (value: number | undefined) => {
    if (value == undefined) {
      return '0,00';
    }
    return value.toLocaleString('de-DE');
  };

  const { data } = useNuiEvent<any>({ event: 'npwd:esx-banking:updateTransactions' });

  const submitPay = () => {
    let currentDate = new Date();
    var month = currentDate.getMonth(); // Dodajemy 1, ponieważ styczeń to 0
    var day = currentDate.getDate();
    var year = currentDate.getFullYear();
    var formattedDate = (month < 10 ? '0' : '') + month + '-' + (day < 10 ? '0' : '') + day + '-' + year;
    fetchNui<ServerPromiseResp<any>>('npwd:esx-banking:tryTransfer', {date: formattedDate,phoneNumber : phoneNumber, amount: amount})
  };

  const getTimeString = (date: Date) => {
    let day = date.getDate() >= 10 ? date.getDate() : '0' + date.getDate();
    let month = date.getMonth() + 1 >= 10 ? date.getMonth() + 1 : '0' + (date.getMonth() + 1);
    let year = date.getFullYear();
    return day + '.' + month + '.' + year;
  };

  const handleInputChange = (event: any) => {
    // console.log(event.target.value)
    const regex = /[0-9-]/;
    if (regex.test(event.target.value.slice(-1)) || event.target.value == '') {
      setPhoneNumber(event.target.value);
    }
  };
  const handleInput2Change = (event: any) => {
    // console.log(event.target.value)
    const regex = /[0-9]/;
    if (regex.test(event.target.value.slice(-1)) || event.target.value == '') {
      setAmount(event.target.value);
    }
  };

  useEffect(()=>{
    if (data){
      setBanking(data.bankBalance)
      setLastTransactions(data.transactions)
    }
  }, [data])

  useEffect(() => {
    setTimeout(() => {
      if (isEnvBrowser()) {
        setBanking(1125332);
        setLastTransactions(
          mockTransactions.sort((a: Transaction, b: Transaction) => {
            return b.date.getTime() - a.date.getTime();
          }),
        );
      } else {
        fetchNui<ServerPromiseResp<any>>('npwd:esx-banking:getBalance').then((resp) => {
          if (!resp.data) {
            setBanking(0);
            setLastTransactions([]);
            return;
          }
          setBanking(resp.data.amount);
          setLastTransactions(
            resp.data.transactions.sort((a: Transaction, b: Transaction) => {
              return new Date(b.date).getTime() - new Date(a.date).getTime();
            }),
          );
        });
      }
    }, 200);
  }, []);
  return (
    <>
      {banking != undefined && lastTransactions != undefined ? (
        <main className="w-full p-4 flex h-[90%] m-0 flex-col">
          <section className="w-full h-min p-2 bg-gray-200 dark:bg-neutral-800 shadow-lg flex flex-col rounded-sm border-[1px] border-gray-400 dark:border-neutral-900">
            <span className="text-lg font-mono font-semibold text-gray-600 dark:text-neutral-100">
              Los Santos Amkira Bank
            </span>
            <span className="text-sm mt-[-1px] text-gray-400">00 (...) 0000 0000</span>
            <span className="ml-auto text-sm text-gray-400 mt-auto">Verfügbares Vermögen</span>
            <span className="ml-auto text-2xl select-none">{formatText(banking)} EUR</span>
          </section>

          <section className="w-full h-min p-2 bg-gray-200 dark:bg-neutral-800 shadow-lg mt-5 flex flex-col rounded-sm border-[1px] border-gray-400 dark:border-neutral-900">
            <span className="text-lg font-mono font-semibold text-gray-600 dark:text-neutral-100">Geld überweisen</span>
            <div className="w-full  mt-4 flex gap-1 items-center justify-center flex-col">
              <input
                className="w-3/4 h-8 placeholder:px-1 text-sm px-1 rounded-md placeholder:text-sm outline-none border-[2px] focus:border-gray-600 dark:bg-neutral-800 transition-all duration-300 border-gray-400 dark:border-neutral-900 dark:focus:border-neutral-950"
                type="text"
                value={phoneNumber}
                onChange={handleInputChange}
                placeholder="z.B. 111-111-1111"
              />
              <input
                className="w-3/4 h-8 placeholder:px-1 text-sm px-1 placeholder:text-sm rounded-md outline-none border-[2px] focus:border-gray-600 dark:bg-neutral-800 transition-all duration-300 border-gray-400 dark:border-neutral-900 dark:focus:border-neutral-950"
                type="text"
                value={amount}
                onChange={handleInput2Change}
                placeholder="Summe"
              />
              <button
                onClick={submitPay}
                className="w-3/4 rounded-md h-8 border-[1px] font-mono font-semibold hover:bg-green-500 transition-colors duration-300 border-green-400 dark:bg-neutral-900 dark:border-neutral-950 dark:hover:bg-neutral-950  bg-green-100 text-gray-600 dark:text-neutral-100 px-2"
              >
                Überweisen
              </button>
            </div>
          </section>

          <section className="w-full p-2 h-[50%] bg-gray-200 no-scrollbar dark:bg-neutral-800 shadow-lg mt-4 overflow-x-hidden overflow-y-auto rounded-sm border-[1px] border-gray-400 relative dark:border-neutral-900">
            <div className="text-lg w-full sticky left-0 -top-2 bg-gray-200 dark:bg-neutral-800 font-mono font-semibold text-gray-600 dark:text-neutral-100">
              Verlauf der Transaktionen
            </div>
            {lastTransactions.length == 0 ? (
              <div className="absolute top-1/2 left-1/2 -translate-x-1/2 -translate-y-1/2 text-2xl text-gray-600 dark:text-neutral-100">
                <i className="fa-solid fa-face-sad-tear"></i> Nothing Here
              </div>
            ) : (
              lastTransactions.map((Transaction, key) => (
                <div
                  key={key}
                  className="w-full h-max border-b-[1px] mt-1 border-gray-400 dark:border-neutral-950 font-sans p-1 flex flex-col"
                >
                  <div className="w-full h-max items-center flex justify-between">
                    <span className="text-lg text-gray-600 dark:text-neutral-100 font-semibold">{Transaction.name}</span>
                    <span className="text-sm text-gray-400">
                      {getTimeString(new Date(Transaction.date))}
                    </span>
                  </div>
                  <div className="w-full h-max items-center justify-end flex text-lg">
                    <span className={Transaction.type == 0 ? 'text-red-600' : 'text-green-600'}>
                      {Transaction.type == 0 ? '-' : '+'}
                      {Transaction.amount.toLocaleString('de-DE')} EUR
                    </span>
                  </div>
                </div>
              ))
            )}
          </section>
        </main>
      ) : (
        <Loading />
      )}
    </>
  );
};

export default Account;
