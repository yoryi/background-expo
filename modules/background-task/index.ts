import BackgroundTaskModule from './src/BackgroundTaskModule';

export function requestPermissions() {
  return BackgroundTaskModule.requestPermissions();
}

export function startSimulation(numberPost: number) {
  return BackgroundTaskModule.startSimulation(numberPost);
}