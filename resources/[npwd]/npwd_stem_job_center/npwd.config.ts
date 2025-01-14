import App from './src/App';
import { AppIcon } from './icon';

interface Settings {
  language: 'en';
}

export const path = '/job-center';
export default (settings: Settings) => ({
  id: 'JOB_CENTER',
  path,
  nameLocale: "Job Center", 
  color: '#fff',
  backgroundColor: '#d03df4',
  icon: AppIcon,
  app: App,
});
