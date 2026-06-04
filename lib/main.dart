import 'package:flutter/material.dart';

//Samuel Nunn
//sln0021
void main() {
  runApp(const MyApp());
}

class ListItem extends StatelessWidget {
  final IconData iconData;
  final String itemName;
  final String price;
  final int count;
  final VoidCallback onAdd;
  final VoidCallback onRemove;

  const ListItem({
    super.key, required this.iconData, required this.itemName, required this.price, required this.count, required this.onAdd, required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(iconData),
      title: Text(itemName),
      subtitle: Text(price),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(onPressed: onRemove, icon: Icon(Icons.remove)),
          Text("$count"),
          IconButton(onPressed: onAdd, icon: Icon(Icons.add)),
        ],
      ),
    );
  }
}

class TipSelector extends StatelessWidget {
  final bool addTip;
  final int selectedTip;
  final List<int> tipOptions;
  final ValueChanged<bool> onTipToggled;
  final ValueChanged<int> onTipSelected;

  const TipSelector({
    super.key, required this.addTip, required this.selectedTip, required this.tipOptions, required this.onTipToggled, required this.onTipSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SwitchListTile(
          title: Text("Add a tip?"),
          value: addTip,
          onChanged: onTipToggled,
        ),
        if (addTip)
          Wrap(
            spacing: 8,
            children: tipOptions.map((tip) {
              return ChoiceChip(
                label: Text("$tip%"),
                selected: selectedTip == tip,
                onSelected: (selected) {
                  onTipSelected(tip);
                },
              );
            }).toList(),
          )
      ],
    );
  }
}

class ConfirmSelection extends StatelessWidget {
  final double total;

  const ConfirmSelection({super.key, required this.total});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text("Order Confirmation"),
              content: Text("Your order has been placed.\n\nTotal: \$${total.toStringAsFixed(2)}"),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("Dismiss"))
              ],
            );
          });
      },
      child: Text("Confirm Order"));
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.brown),
      ),
      home: const MyHomePage(title: "Coffee 2 Go :)"),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int blackCoffeeCount = 0;
  int latteCount = 0;
  int cappuccinoCount = 0;
  int croissantCount = 0;
  int baconEggCheeseCount = 0;

  bool addTip = false;
  int selectedTip = 10;

  double getTotal() {
    double total = 0;
    total += blackCoffeeCount * 2.00;
    total += latteCount * 3.00;
    total += cappuccinoCount * 5.00;
    total += croissantCount * 6.00;
    total += baconEggCheeseCount * 7.00;
    if (addTip) {
      total += total * (selectedTip / 100);
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Container( //learned about this one online as a way to have the coffee mug be the background
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/coffee_image.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(16),
          child: ListView(
            children: [
              SizedBox(height: 20),
              Card(
                child: Column(
                  children: [
                    ListItem(
                      iconData: Icons.local_cafe,
                      itemName: "Black Coffee",
                      price: "2.00",
                      count: blackCoffeeCount,
                      onAdd: () { 
                        setState(() {
                           blackCoffeeCount++; 
                           }); 
                        },
                      onRemove: () { 
                        setState(() {
                           if (blackCoffeeCount > 0) blackCoffeeCount--; 
                           }); 
                        },
                    ),
                    ListItem(
                      iconData: Icons.local_cafe,
                      itemName: "Latte",
                      price: "3.00",
                      count: latteCount,
                      onAdd: () {
                         setState(() {
                           latteCount++; 
                           }); 
                         },
                      onRemove: () {
                         setState(() {
                           if (latteCount > 0) latteCount--; 
                           }); 
                         },
                    ),
                    ListItem(
                      iconData: Icons.local_cafe,
                      itemName: "Cappuccino",
                      price: "5.00",
                      count: cappuccinoCount,
                      onAdd: () {
                         setState(() {
                           cappuccinoCount++; 
                           }); 
                         },
                      onRemove: () {
                         setState(() {
                           if (cappuccinoCount > 0) cappuccinoCount--; 
                           }); 
                         },
                    ),
                    ListItem(
                      iconData: Icons.local_dining,
                      itemName: "Croissant",
                      price: "6.00",
                      count: croissantCount,
                      onAdd: () {
                         setState(() {
                           croissantCount++; 
                           }); 
                         },
                      onRemove: () {
                         setState(() {
                           if (croissantCount > 0) croissantCount--; 
                           }); 
                         },
                    ),
                    ListItem(
                      iconData: Icons.local_dining,
                      itemName: "Bacon Egg n Cheese",
                      price: "7.00",
                      count: baconEggCheeseCount,
                      onAdd: () {
                         setState(() {
                           baconEggCheeseCount++; 
                           }); 
                         },
                      onRemove: () {
                         setState(() {
                           if (baconEggCheeseCount > 0) baconEggCheeseCount--; 
                           }); 
                         },
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30),
              Card(
                child: TipSelector(
                  addTip: addTip,
                  selectedTip: selectedTip,
                  tipOptions: [10, 15, 20, 25],
                  onTipToggled: (value) {
                    setState(() {
                      addTip = value;
                    });
                  },
                  onTipSelected: (tip) {
                    setState(() {
                      selectedTip = tip;
                    });
                  },
                ),
              ),
              SizedBox(height: 30),
              ConfirmSelection(total: getTotal()),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}