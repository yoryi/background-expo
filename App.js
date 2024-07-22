import { useState } from 'react';
import { StatusBar } from 'expo-status-bar';
import * as background from './modules/background-task';
import { StyleSheet, Text, TextInput, TouchableOpacity, View, Keyboard, TouchableWithoutFeedback } from 'react-native';

export default function App() {
  const [num, setNum] = useState(0)

  const handleEvents1 = () => {
    const res = background.requestPermissions()
    console.log('Notifications:  ', res);
  };

  const handleEvents2 = () => {
    const numAsInt = parseInt(num, 10);
    if (!isNaN(numAsInt)) {
      return background.startSimulation(numAsInt);
    }
  };

  const renderHeaders = () => {
    return (
      <View style={styles.Headers}>
        <Text style={styles.title}>Background Task</Text>
        <Text style={styles.subTitle}>Uploading App</Text>
      </View>
    );
  };

  const renderContents = () => {
    return (
      <View style={styles.Contents}>
        <TextInput
          value={num}
          maxLength={2}
          style={styles.input}
          onChangeText={setNum}
          keyboardType={"numeric"}
          placeholderTextColor={'black'}
          placeholder={"Numero Peticiones"}
        />
        <TouchableOpacity onPress={handleEvents1} style={styles.onButton}>
          <Text style={styles.onTitle}>Permisos Notificaciones</Text>
        </TouchableOpacity>
        <TouchableOpacity
          onPress={handleEvents2}
          style={styles.onButton}
        >
          <Text style={styles.onTitle}>Simulacion Carga {num}</Text>
        </TouchableOpacity>
      </View>
    );
  };

  const renderUI = () => {
    return (
      <TouchableWithoutFeedback onPress={Keyboard.dismiss}>
        <View style={styles.container}>
          <StatusBar style={"light"} />
          {renderHeaders()}
          {renderContents()}
        </View>
      </TouchableWithoutFeedback>
    );
  };
  return renderUI();
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: "#F9F9F9",
  },
  Contents: {
    gap: 20,
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
  input: {
    padding: 15,
    minWidth: 180,
    borderRadius: 10,
    backgroundColor: "white",
  },
  title: {
    fontSize: 18,
    color: "white",
    fontWeight: "bold",
  },
  subTitle: {
    fontSize: 13,
    paddingTop: 5,
    color: "#5A6573",
  },
  onTitle: {
    fontSize: 14,
    color: 'white',
  },
  onButton: {
    padding: 15,
    minWidth: 180,
    borderRadius: 10,
    alignItems: 'center',
    backgroundColor: '#07BE5E'
  }
});
