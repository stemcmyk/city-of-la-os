import React from 'react';

const Loading: React.FC = () => {
  return (
    <div className="h-full w-full flex items-center justify-center flex-col text-xl">
      <div className="inline-block h-8 w-8 animate-spin rounded-full border-4 border-solid border-current border-r-transparent align-[-0.125em] motion-reduce:animate-[spin_1.5s_linear_infinite]"></div>
      <span>Loading ...</span>
    </div>
  );
};

export default Loading;
