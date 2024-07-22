import BackgroundTaskModule from './src/BackgroundTaskModule';

export function showLiveActivity() {
  return BackgroundTaskModule.startActivity();
}

export function areActivitiesEnabled() {
  return BackgroundTaskModule.areActivitiesEnabled();
}

export function endActivity() {
  return BackgroundTaskModule.endActivity();
}
