import 'package:flutter/material.dart';

import '../models/castle.dart';
import '../services/got_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Castle?>? _listCastles;
  bool _progress = false;

  _rowProgress() {
    return Column(
     mainAxisAlignment: MainAxisAlignment.center,
     crossAxisAlignment: CrossAxisAlignment.center,
     children: const <Widget> [
       Center(
         child: CircularProgressIndicator(),
       ),
     ],
    );
  }

  _rowListCastles() {
    if(_listCastles == null) {
      return const Text('Sem castelos para exibir');
    }

    return ListView.builder(
      itemCount: _listCastles!.length,
      itemBuilder: (context, index) {
        return ListTile(
            isThreeLine: true,
            title: Text(_listCastles!.elementAt(index)!.name),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(_listCastles!.elementAt(index)!.location),
                Text('${_listCastles!.elementAt(index)!.religion}'),
              ],
            ),
            leading: const CircleAvatar(backgroundColor: Colors.blue,),
            trailing: const Icon(Icons.android),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('clicou no ${_listCastles!.elementAt(index).toString()}', style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
                  )
              );
            }
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter GoT'),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: _progress ? _rowProgress() : _rowListCastles()
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          _fetchCastles(context);
        },
        tooltip: 'Buscar lista do servidor',
        child: const Icon(Icons.refresh),
      ),
    );
  }

  _fetchCastles(BuildContext context) async {
    final gotService = GotService();

    setState(() {
      _progress = true;
    });

    _listCastles = await gotService.fetchCastles();

    setState(() {
      _progress = false;
    });
  }
}