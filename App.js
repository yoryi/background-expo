import { StatusBar } from 'expo-status-bar';
import { StyleSheet, Text, TouchableOpacity, View } from 'react-native';
import * as background from './modules/background-task/index';

export default function App() {
  const handleEvents1 = () => {
    const res = background.areActivitiesEnabled()
    console.log('response:  ', res);
  };

  const handleEvents2 = () => {
    const res = background.showLiveActivity()
    console.log('response:  ', res);
  };

  const handleEvents3 = () => {
    const res = background.endActivity()
    console.log('response:  ', res);
  };

  const Headers = () => {
    return (
      <View style={styles.Headers}>
        <Text style={styles.title}>Background Task</Text>
        <Text style={styles.subTitle}>Uploading App</Text>
      </View>
    );
  };

  const Contents = () => {
    return (
      <View style={styles.Contents}>
        <TouchableOpacity onPress={handleEvents1} style={styles.onButton}>
          <Text style={styles.onTitle}>Permisos Task</Text>
        </TouchableOpacity>
        <TouchableOpacity onPress={handleEvents2} style={styles.onButton}>
          <Text style={styles.onTitle}>Comenzar Task</Text>
        </TouchableOpacity>
        <TouchableOpacity onPress={handleEvents3} style={styles.onButton}>
          <Text style={styles.onTitle}>Terminar Task</Text>
        </TouchableOpacity>
      </View>
    );
  };

  const renderUI = () => {
    return (
      <View style={styles.container}>
        <StatusBar style={'light'}  />
        <Headers />
        <Contents />
      </View>
    );
  };
  return renderUI();
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: "#090A0E",
  },
  Contents: {
    paddingTop: 40,
    alignItems: 'center'
  },
  Headers: {
    height: "20%",
    padding: 20,
    paddingTop: 40,
    justifyContent: "center",
    backgroundColor: "#151A20",
  },
  button: {
    padding: 15,
    borderRadius: 10,
    backgroundColor: "blue",
  },
  title: {
    fontSize: 17,
    color: "white",
    fontWeight: "bold",
  },
  subTitle: {
    fontSize: 11,
    paddingTop: 5,
    color: "#5A6573",
  },
  onTitle: {
    fontSize: 12,
    color: 'white',
  },
  onButton: {
    width: 140,
    padding: 15,
    borderRadius: 10,
    alignItems: 'center',
    backgroundColor: '#07BE5E'
  }
});
