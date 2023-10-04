import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpodflutter2/productsriverpod.dart';

import 'Products.dart';


void main() {
  // wrap the entire app with a ProviderScope so that widgets
  // will be able to read providers
  runApp(
    const ProviderScope(child: MaterialApp(
        home: HelloWorldWidget()
    )),
  );
}

// Note: MyApp is a HookConsumerWidget, from hooks_riverpod.
final counterProvider = NotifierProvider<ProductsProvider, List<Products>>(ProductsProvider.new);


class HelloWorldWidget extends StatelessWidget {
  const HelloWorldWidget({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(),
      body: Consumer(
        builder: (context, ref, _) {
          ref.read(counterProvider.notifier).update();
          return Example();
        },
      ),
      floatingActionButton:FloatingActionButton( onPressed: (){

        //ref.read(counterProvider.notifier).update();
      },child: Text("fetch"),),
    );

  }
}
class Example extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final plist = ref.watch(counterProvider.notifier).products;
    return   ListView.builder(
      shrinkWrap: true,
      itemCount:plist.length == null ? 0 : plist.length,
      itemBuilder: (BuildContext context, int index) {
        Products st = plist[index];
        return Card(
          child: Row(
            children: <Widget>[
              Image.network('${plist[index].thumbnail}',fit:BoxFit.cover,height: 150,width: 150,),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: SizedBox(
                  child: Column(
                    children: <Widget>[
                      Text('id: ${st.id}'),
                      Container(width: MediaQuery.of(context).size.width-400,
                          child: Text('todo: ${st.title}',maxLines: 3,)),
                      Text('description: ${st.description}'),
                      Text('price: ${st.price}'),
                      Text('discountPercentage: ${st.discountPercentage}'),
                      Text('rating: ${st.rating}'),
                      Text('stock: ${st.stock}'),
                      Text('brand: ${st.brand}'),
                      Text('category: ${st.category}'),
                      Text('thumbnail: ${st.thumbnail}'),
                      Text('images: ${st.images}'),

                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}