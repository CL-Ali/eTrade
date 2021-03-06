import 'package:dart_ping/dart_ping.dart';
import 'package:eTrade/components/AddItemModelSheet.dart';
import 'package:eTrade/components/NavigationBar.dart';
import 'package:eTrade/components/sqlhelper.dart';
import 'package:eTrade/entities/Customer.dart';
import 'package:eTrade/entities/Order.dart';
import 'package:eTrade/entities/Products.dart';
import 'package:eTrade/entities/ViewBooking.dart';
import 'package:eTrade/entities/ViewRecovery.dart';
import 'package:eTrade/screen/ViewBookingScreen.dart';
import "package:flutter/material.dart";
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class ViewRecoveryDetailScreen extends StatefulWidget {
  ViewRecoveryDetailScreen({
    required this.selectedRecovery,
  });
  ViewRecovery selectedRecovery;

  @override
  State<ViewRecoveryDetailScreen> createState() =>
      _ViewRecoveryDetailScreenState();
}

class _ViewRecoveryDetailScreenState extends State<ViewRecoveryDetailScreen> {
  ScrollController _controller = ScrollController();
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(30),
            ),
          ),
          backgroundColor: Color(0xFF00620b),
          toolbarHeight: 80,
          title: Text(
            'Order Detail',
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      left: 20.0, right: 20.0, top: 20.0, bottom: 5.0),
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        height: 50,
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Text(
                                  "Customer Name: ",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Text(
                                "${widget.selectedRecovery.party.partyName}",
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold),
                              ),
                            ]),
                      ),
                      Container(
                        width: double.infinity,
                        height: 50,
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Text(
                                  "Amount: ",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Text(
                                "${widget.selectedRecovery.amount}",
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold),
                              ),
                            ]),
                      ),
                      Container(
                        width: double.infinity,
                        height: 50,
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Text(
                                  "Order Date: ",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Text(
                                "${widget.selectedRecovery.dated}",
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold),
                              ),
                            ]),
                      ),
                    ],
                  ),
                ),
                Divider(
                  thickness: 2,
                  color: Color(0xff00620b),
                ),
                Center(
                  child: Text(widget.selectedRecovery.description),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
