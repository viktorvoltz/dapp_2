import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:web3dart/web3dart.dart';
import 'package:web_socket_channel/io.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  
 
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

   String rpcUrl = 'HTTP://127.0.0.1:7545';
  String wsUrl = 'ws://127.0.0.1:7545/';
  
  void sendEther() async {
    Web3Client client = Web3Client(rpcUrl, Client(), socketConnector: (){
      return IOWebSocketChannel.connect(wsUrl).cast<String>();
    });

    String privateKey = "0856f1ca6515b71149ed30b14a3b71351a54085e623fbbe640923d3f214ecd18";
    Credentials credentials = await client.credentialsFromPrivateKey(privateKey);

    EthereumAddress ownAddress = await credentials.extractAddress();
    print(ownAddress);

    client.sendTransaction(credentials, Transaction(from: ownAddress));
  }


  @override
  Widget build(BuildContext context) {
  
    return Scaffold(
      appBar: AppBar(
        
        title: Text(widget.title),
      ),
      body: Center(
     
        child: Column(
          
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: sendEther,
        tooltip: 'sendEther',
        child: Icon(Icons.add),
      ),
    );
  }
}
