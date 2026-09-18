import 'package:flutter/material.dart';

void main() => runApp(const GroceryExpressApp());

class Product {
  final String id, name, unit, category;
  final double price;
  int stock;
  Product({
    required this.id,
    required this.name,
    required this.unit,
    required this.category,
    required this.price,
    this.stock = 20,
  });
}

final products = <Product>[
  Product(id:'p1', name:'Apple', unit:'1 kg', price:120, category:'Fruits & Vegetables'),
  Product(id:'p2', name:'Banana', unit:'1 dozen', price:60, category:'Fruits & Vegetables'),
  Product(id:'p3', name:'Tomato', unit:'1 kg', price:40, category:'Fruits & Vegetables'),
  Product(id:'p4', name:'Onion', unit:'1 kg', price:35, category:'Fruits & Vegetables'),
  Product(id:'p5', name:'Potato', unit:'1 kg', price:25, category:'Fruits & Vegetables'),
  Product(id:'p6', name:'Milk', unit:'1 litre', price:55, category:'Dairy & Eggs'),
  Product(id:'p7', name:'Basmati Rice', unit:'5 kg', price:350, category:'Grains & Staples'),
  Product(id:'p8', name:'Cauliflower', unit:'1 pc', price:45, category:'Fruits & Vegetables'),
];

final cart = <Product,int>{};
final orders = <Order>[];

class Order {
  final String id;
  final double total;
  final String payment;
  final String address;
  String status;
  final DateTime createdAt;
  Order({
    required this.id,
    required this.total,
    required this.payment,
    required this.address,
    this.status='Pending',
    required this.createdAt,
  });
}

class GroceryExpressApp extends StatelessWidget {
  const GroceryExpressApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner:false,
      title:'Mansoor Hussain Grocery Express',
      theme:ThemeData(
        useMaterial3:true,
        colorScheme:ColorScheme.fromSeed(seedColor:const Color(0xFF08783E)),
        scaffoldBackgroundColor:const Color(0xFFF7FAF7),
      ),
      home:const StoreShell(),
    );
  }
}

class StoreShell extends StatefulWidget {
  const StoreShell({super.key});
  @override State<StoreShell> createState()=>_StoreShellState();
}

class _StoreShellState extends State<StoreShell> {
  int tab=0;
  void refresh()=>setState((){});
  @override
  Widget build(BuildContext context) {
    final pages=[
      const HomePage(),
      const CategoriesPage(),
      CartPage(onChanged:refresh),
      const OrdersPage(),
      const ProfilePage(),
    ];
    return Scaffold(
      body:SafeArea(child:pages[tab]),
      bottomNavigationBar:NavigationBar(
        selectedIndex:tab,
        onDestinationSelected:(i)=>setState(()=>tab=i),
        destinations:const[
          NavigationDestination(icon:Icon(Icons.home_outlined),selectedIcon:Icon(Icons.home),label:'Home'),
          NavigationDestination(icon:Icon(Icons.grid_view_outlined),label:'Categories'),
          NavigationDestination(icon:Icon(Icons.shopping_cart_outlined),label:'Cart'),
          NavigationDestination(icon:Icon(Icons.receipt_long_outlined),label:'Orders'),
          NavigationDestination(icon:Icon(Icons.person_outline),label:'Profile'),
        ],
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override State<HomePage> createState()=>_HomePageState();
}
class _HomePageState extends State<HomePage> {
  String query='';
  @override
  Widget build(BuildContext context) {
    final filtered=products.where((p)=>p.name.toLowerCase().contains(query.toLowerCase())).toList();
    return CustomScrollView(slivers:[
      SliverAppBar(
        pinned:true, backgroundColor:const Color(0xFF00552D), foregroundColor:Colors.white,
        title:const Column(crossAxisAlignment:CrossAxisAlignment.start,children:[
          Text('Mansoor Hussain',style:TextStyle(fontSize:18,fontWeight:FontWeight.bold)),
          Text('Grocery Express',style:TextStyle(fontSize:12)),
        ]),
        actions:[IconButton(onPressed:(){Navigator.push(context,MaterialPageRoute(builder:(_)=>const AdminLoginPage()));},icon:const Icon(Icons.admin_panel_settings_outlined))],
      ),
      SliverToBoxAdapter(child:Padding(padding:const EdgeInsets.all(16),child:Column(children:[
        TextField(onChanged:(v)=>setState(()=>query=v),decoration:InputDecoration(
          hintText:'Search for groceries...',prefixIcon:const Icon(Icons.search),filled:true,fillColor:Colors.white,
          border:OutlineInputBorder(borderRadius:BorderRadius.circular(14),borderSide:BorderSide.none))),
        const SizedBox(height:14),
        Container(width:double.infinity,padding:const EdgeInsets.all(20),decoration:BoxDecoration(
          color:const Color(0xFF0A7D43),borderRadius:BorderRadius.circular(18)),
          child:const Column(crossAxisAlignment:CrossAxisAlignment.start,children:[
            Text('Fresh Groceries',style:TextStyle(color:Colors.white,fontSize:23,fontWeight:FontWeight.bold)),
            SizedBox(height:4),Text('Fresh products • Best prices',style:TextStyle(color:Colors.white70)),
            SizedBox(height:12),Text('Fast home delivery',style:TextStyle(color:Colors.white,fontWeight:FontWeight.bold)),
          ])),
        const SizedBox(height:20),
        const Align(alignment:Alignment.centerLeft,child:Text('Popular Products',style:TextStyle(fontSize:20,fontWeight:FontWeight.bold))),
      ]))),
      SliverPadding(padding:const EdgeInsets.symmetric(horizontal:16),sliver:SliverGrid(
        delegate:SliverChildBuilderDelegate((context,i)=>ProductCard(product:filtered[i],onAdded:()=>setState((){})),childCount:filtered.length),
        gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount:2,crossAxisSpacing:12,mainAxisSpacing:12,childAspectRatio:.76),
      )),
    ]);
  }
}

class ProductCard extends StatelessWidget {
  final Product product; final VoidCallback onAdded;
  const ProductCard({super.key,required this.product,required this.onAdded});
  @override Widget build(BuildContext context)=>Card(elevation:0,child:Padding(padding:const EdgeInsets.all(12),child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[
    Expanded(child:Container(width:double.infinity,decoration:BoxDecoration(color:const Color(0xFFE5F3E9),borderRadius:BorderRadius.circular(14)),child:const Icon(Icons.shopping_basket,size:65,color:Color(0xFF0A7D43)))),
    const SizedBox(height:8),Text(product.name,style:const TextStyle(fontWeight:FontWeight.bold)),
    Text(product.unit,style:TextStyle(color:Colors.grey.shade600,fontSize:12)),
    const SizedBox(height:5),Row(mainAxisAlignment:MainAxisAlignment.spaceBetween,children:[
      Text('₹${product.price.toStringAsFixed(0)}',style:const TextStyle(fontWeight:FontWeight.bold)),
      FilledButton(onPressed:product.stock>0?(){cart[product]=(cart[product]??0)+1;onAdded();ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text('${product.name} added')));}:null,child:const Text('Add')),
    ]),
  ])));
}

class CategoriesPage extends StatelessWidget {
  const CategoriesPage({super.key});
  @override Widget build(BuildContext context){
    final cats=['Fruits & Vegetables','Grains & Staples','Dairy & Eggs','Snacks & Beverages','Personal Care','Home & Kitchen','Cleaning'];
    return ListView(padding:const EdgeInsets.all(16),children:[
      const Text('Categories',style:TextStyle(fontSize:26,fontWeight:FontWeight.bold)),
      const SizedBox(height:12),
      ...cats.map((c)=>Card(child:ListTile(leading:const CircleAvatar(child:Icon(Icons.category_outlined)),title:Text(c),trailing:const Icon(Icons.chevron_right))))
    ]);
  }
}

class CartPage extends StatefulWidget {
  final VoidCallback onChanged;
  const CartPage({super.key,required this.onChanged});
  @override State<CartPage> createState()=>_CartPageState();
}
class _CartPageState extends State<CartPage>{
  double get subtotal=>cart.entries.fold(0,(s,e)=>s+e.key.price*e.value);
  @override Widget build(BuildContext context){
    if(cart.isEmpty)return const Center(child:Column(mainAxisSize:MainAxisSize.min,children:[Icon(Icons.shopping_cart_outlined,size:70),SizedBox(height:10),Text('Your cart is empty',style:TextStyle(fontSize:20,fontWeight:FontWeight.bold))]));
    return ListView(padding:const EdgeInsets.all(16),children:[
      const Text('My Cart',style:TextStyle(fontSize:26,fontWeight:FontWeight.bold)),
      const SizedBox(height:12),
      ...cart.entries.map((e)=>Card(child:ListTile(leading:const CircleAvatar(child:Icon(Icons.shopping_basket)),title:Text(e.key.name),subtitle:Text('₹${e.key.price.toStringAsFixed(0)} × ${e.value}'),trailing:Row(mainAxisSize:MainAxisSize.min,children:[
        IconButton(onPressed:()=>setState((){if(e.value<=1)cart.remove(e.key);else cart[e.key]=e.value-1;}),icon:const Icon(Icons.remove_circle_outline)),
        Text('${e.value}'),IconButton(onPressed:()=>setState(()=>cart[e.key]=e.value+1),icon:const Icon(Icons.add_circle_outline))
      ])))),
      Card(child:Padding(padding:const EdgeInsets.all(16),child:Column(children:[
        row('Item total',subtotal),row('Delivery fee',30),const Divider(),row('Total',subtotal+30,bold:true)
      ]))),
      const SizedBox(height:12),
      FilledButton(onPressed:()=>Navigator.push(context,MaterialPageRoute(builder:(_)=>const CheckoutPage())),child:const Padding(padding:EdgeInsets.all(14),child:Text('Proceed to Checkout')))
    ]);
  }
  Widget row(String a,double b,{bool bold=false})=>Padding(padding:const EdgeInsets.symmetric(vertical:4),child:Row(mainAxisAlignment:MainAxisAlignment.spaceBetween,children:[Text(a,style:TextStyle(fontWeight:bold?FontWeight.bold:null)),Text('₹${b.toStringAsFixed(0)}',style:TextStyle(fontWeight:bold?FontWeight.bold:null))]));
}

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({super.key});
  @override State<CheckoutPage> createState()=>_CheckoutPageState();
}
class _CheckoutPageState extends State<CheckoutPage>{
  String payment='Cash on Delivery';
  final address=TextEditingController();
  double get total=>cart.entries.fold(30,(s,e)=>s+e.key.price*e.value);
  @override Widget build(BuildContext context)=>Scaffold(appBar:AppBar(title:const Text('Checkout')),body:ListView(padding:const EdgeInsets.all(16),children:[
    const Text('Delivery Address',style:TextStyle(fontSize:18,fontWeight:FontWeight.bold)),const SizedBox(height:8),
    TextField(controller:address,maxLines:3,decoration:const InputDecoration(hintText:'Enter full delivery address',border:OutlineInputBorder())),
    const SizedBox(height:20),const Text('Payment Method',style:TextStyle(fontSize:18,fontWeight:FontWeight.bold)),
    RadioListTile(value:'Cash on Delivery',groupValue:payment,onChanged:(v)=>setState(()=>payment=v!),title:const Text('Cash on Delivery'),secondary:const Icon(Icons.payments_outlined)),
    RadioListTile(value:'Online Payment',groupValue:payment,onChanged:(v)=>setState(()=>payment=v!),title:const Text('Online Payment'),subtitle:const Text('UPI / Card / Wallet'),secondary:const Icon(Icons.credit_card)),
    Card(child:Padding(padding:const EdgeInsets.all(16),child:Column(children:[row('Order total',total,bold:true)]))),
    const SizedBox(height:14),
    FilledButton(onPressed:placeOrder,child:Padding(padding:const EdgeInsets.all(14),child:Text('Place Order • ₹${total.toStringAsFixed(0)}')))
  ]));
  Widget row(String a,double b,{bool bold=false})=>Row(mainAxisAlignment:MainAxisAlignment.spaceBetween,children:[Text(a,style:TextStyle(fontWeight:bold?FontWeight.bold:null)),Text('₹${b.toStringAsFixed(0)}',style:TextStyle(fontWeight:bold?FontWeight.bold:null))]);
  void placeOrder(){
    if(address.text.trim().isEmpty){ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content:Text('Please enter your address')));return;}
    final order=Order(id:'GE${DateTime.now().millisecondsSinceEpoch.toString().substring(5)}',total:total,payment:payment,address:address.text.trim(),createdAt:DateTime.now());
    orders.insert(0,order);cart.clear();
    if(payment=='Online Payment'){
      showDialog(context:context,builder:(_)=>AlertDialog(title:const Text('Online Payment'),content:const Text('Payment gateway is ready for integration. Add your Razorpay/other gateway keys and server verification before production.'),actions:[TextButton(onPressed:(){Navigator.pop(context);Navigator.pop(context);},child:const Text('Continue'))]));
    }else{
      showDialog(context:context,builder:(_)=>AlertDialog(title:const Text('Order Confirmed'),content:Text('Order ${order.id} placed with Cash on Delivery.'),actions:[TextButton(onPressed:(){Navigator.popUntil(context,(r)=>r.isFirst);},child:const Text('Done'))]));
    }
  }
}

class OrdersPage extends StatefulWidget { const OrdersPage({super.key}); @override State<OrdersPage> createState()=>_OrdersPageState(); }
class _OrdersPageState extends State<OrdersPage>{
  @override Widget build(BuildContext context)=>ListView(padding:const EdgeInsets.all(16),children:[
    const Text('My Orders',style:TextStyle(fontSize:26,fontWeight:FontWeight.bold)),const SizedBox(height:12),
    if(orders.isEmpty) const Card(child:ListTile(leading:Icon(Icons.receipt_long),title:Text('No orders yet'),subtitle:Text('Your orders will appear here.'))),
    ...orders.map((o)=>Card(child:ListTile(leading:const CircleAvatar(child:Icon(Icons.local_shipping_outlined)),title:Text(o.id),subtitle:Text('${o.payment} • ${o.status}\n₹${o.total.toStringAsFixed(0)}'),isThreeLine:true)))
  ]);
}

class ProfilePage extends StatelessWidget{
  const ProfilePage({super.key});
  @override Widget build(BuildContext context)=>ListView(padding:const EdgeInsets.all(16),children:[
    const CircleAvatar(radius:42,child:Icon(Icons.person,size:45)),const SizedBox(height:10),
    const Center(child:Text('Mansoor Hussain',style:TextStyle(fontSize:22,fontWeight:FontWeight.bold))),const Center(child:Text('Grocery Express')),
    const SizedBox(height:20),
    ...['My Orders','My Addresses','Payment Methods','Offers & Coupons','Help & Support','About Us'].map((x)=>Card(child:ListTile(title:Text(x),leading:const Icon(Icons.chevron_right))))
  ]);
}

class AdminLoginPage extends StatefulWidget{
  const AdminLoginPage({super.key});
  @override State<AdminLoginPage> createState()=>_AdminLoginPageState();
}
class _AdminLoginPageState extends State<AdminLoginPage>{
  final user=TextEditingController(),pass=TextEditingController();
  @override Widget build(BuildContext context)=>Scaffold(appBar:AppBar(title:const Text('Admin Login')),body:Padding(padding:const EdgeInsets.all(20),child:Column(children:[
    const Icon(Icons.admin_panel_settings,size:70,color:Color(0xFF08783E)),const SizedBox(height:20),
    TextField(controller:user,decoration:const InputDecoration(labelText:'Admin email',border:OutlineInputBorder())),
    const SizedBox(height:12),TextField(controller:pass,obscureText:true,decoration:const InputDecoration(labelText:'Password',border:OutlineInputBorder())),
    const SizedBox(height:16),FilledButton(onPressed:()=>Navigator.pushReplacement(context,MaterialPageRoute(builder:(_)=>const AdminDashboardPage())),child:const Text('Demo Login'))
  ]));
}

class AdminDashboardPage extends StatefulWidget{
  const AdminDashboardPage({super.key});
  @override State<AdminDashboardPage> createState()=>_AdminDashboardPageState();
}
class _AdminDashboardPageState extends State<AdminDashboardPage>{
  @override Widget build(BuildContext context)=>Scaffold(appBar:AppBar(title:const Text('Grocery Express Admin')),body:ListView(padding:const EdgeInsets.all(16),children:[
    Row(children:[
      stat('Orders','${orders.length}'),const SizedBox(width:10),stat('Products','${products.length}'),const SizedBox(width:10),stat('Customers','—')
    ]),
    const SizedBox(height:20),const Text('Products & Stock',style:TextStyle(fontSize:20,fontWeight:FontWeight.bold)),
    ...products.map((p)=>Card(child:ListTile(title:Text(p.name),subtitle:Text('${p.unit} • ₹${p.price.toStringAsFixed(0)}'),trailing:SizedBox(width:110,child:Row(children:[
      IconButton(onPressed:p.stock>0?()=>setState(()=>p.stock--):null,icon:const Icon(Icons.remove)),Text('${p.stock}'),IconButton(onPressed:()=>setState(()=>p.stock++),icon:const Icon(Icons.add))
    ])))),
    const SizedBox(height:20),const Text('Orders',style:TextStyle(fontSize:20,fontWeight:FontWeight.bold)),
    ...orders.map((o)=>Card(child:ListTile(title:Text(o.id),subtitle:Text('${o.payment} • ₹${o.total.toStringAsFixed(0)}'),trailing:DropdownButton<String>(
      value:o.status,items:['Pending','Confirmed','Out for Delivery','Delivered','Cancelled'].map((s)=>DropdownMenuItem(value:s,child:Text(s))).toList(),
      onChanged:(v)=>setState(()=>o.status=v!)
    )))
  ]));
  Widget stat(String a,String b)=>Expanded(child:Card(child:Padding(padding:const EdgeInsets.all(14),child:Column(children:[Text(b,style:const TextStyle(fontSize:22,fontWeight:FontWeight.bold)),Text(a)]))));
}
