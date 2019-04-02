import 'package:flutter/material.dart';
import 'package:flutter_weather/apiClient.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Weather Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
 
  String _zip = '60640';

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(

        body: new Container(
            child: new FutureBuilder<WeatherResult>(
              future: ApiClient.fetchWeather(_zip),
              builder: (context, result) {
                if (result.hasData) {
                  return new Scaffold(
                      body: Center(
                        child: Column (
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Padding (
                                padding: EdgeInsets.only(top:100.0, bottom: 100.0, left: 10.0, right: 10.0),
                                child: TextField(
                              decoration: InputDecoration(
                                hintText: 'Please provide zip code'
                              ),
                                  onSubmitted: (text){
                                setState(() {
                                  _zip = text;
                                });
                                  },
                            )),
                            Text(
                              result.data.name,
                              style: Theme.of(context).textTheme.display3,
                            ),
                            Text(
                              result.data.weather[0].description,
                              style: Theme.of(context).textTheme.display1,
                            ),
                            Text (
                              result.data.main.temp.toString() + "F",
                              style: Theme.of(context).textTheme.display1,

                      )
                          ],
                        ),
                      )
                  );
                } else if (result.hasError) {
                  return new Scaffold(
                    body: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "Error:"
                          ),
                          Text(
                            result.error.toString()
                          )
                        ],
                      )
                    )
                  );
                }
                // By default, show a loading spinner
                return new Scaffold(
                    body: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            CircularProgressIndicator()
                          ],
                        )
                    )
                );
              },
            )
        )
    );
  }
}
