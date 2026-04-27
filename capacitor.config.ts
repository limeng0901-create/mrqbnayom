import { CapacitorConfig } from '@capacitor/cli';

const config: CapacitorConfig = {
  appId: 'com.hunchachaapp.hcc',
  appName: '婚查查',
  webDir: 'app/src/main/assets',
  server: {
    androidScheme: 'https'
  },
  ios: {
    contentInset: 'automatic',
    backgroundColor: '#6B3FA0',
    allowsLinkPreview: false,
    scrollEnabled: false
  },
  plugins: {
    SplashScreen: {
      launchShowDuration: 2000,
      backgroundColor: '#6B3FA0',
      showSpinner: false
    }
  }
};

export default config;
