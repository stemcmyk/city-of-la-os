import App from './src/App';
import { AppIcon } from './icon';

interface Settings {
  language: 'en';
}

export const path = '/services';
export default (settings: Settings) => ({
  id: 'SERVICES',
  path,
  nameLocale: "Services", 
  color: '#fff',
  backgroundColor: '#AFAFAF',
  icon: AppIcon,
  app: App,
});
