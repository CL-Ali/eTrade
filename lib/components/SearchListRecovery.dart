import 'package:eTrade/components/NavigationBar.dart';
import 'package:eTrade/components/ViewRecoveryTabBar.dart';
import 'package:eTrade/components/sqlhelper.dart';
import 'package:eTrade/entities/ViewBooking.dart';
import 'package:eTrade/entities/ViewRecovery.dart';
import 'package:eTrade/screen/TakeOrderScreen.dart';
import 'package:eTrade/screen/RecoveryScreen.dart';
import 'package:eTrade/screen/ViewRecoveryDetailScreen.dart';
import 'package:eTrade/screen/ViewOrderScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';

class ListOfRecovery extends StatefulWidget {
  ListOfRecovery({required this.matchItem, required this.tabName});
  String matchItem;
  String tabName;
  @override
  State<ListOfRecovery> createState() => _ListOfRecoveryState();
}

class _ListOfRecoveryState extends State<ListOfRecovery> {
  List<ViewRecovery> dummyOrderList = [];
  CheckList(List list) {
    dummyOrderList.clear();

    for (var element in list) {
      if (element.partyName.toLowerCase().contains(widget.matchItem)) {
        setState(() {
          print(element.partyName.toLowerCase());
          dummyOrderList.add(element);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    ScrollController _controller = ScrollController();
    CheckList(RecoveryTabBarItem.listOfRecovery);
    return dummyOrderList.isNotEmpty
        ? ListView.builder(
            controller: _controller,
            itemBuilder: (BuildContext context, index) {
              return Slidable(
                  key: const ValueKey(0),
                  endActionPane: ActionPane(
                    motion: const ScrollMotion(),
                    children: [
                      SlidableAction(
                        onPressed: (((context) async {
                          RecoveryScreen.isEditRecovery = true;
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MyNavigationBar(
                                        selectedIndex: 3,
                                        orderDate: "",
                                        editRecovery: dummyOrderList[index],
                                        orderList: [],
                                        orderId: 0,
                                        orderPartyName: "",
                                      )));
                        })),
                        backgroundColor: const Color(0xFF21B7CA),
                        foregroundColor: Colors.white,
                        icon: Icons.edit,
                        label: 'Edit',
                      ),
                      SlidableAction(
                        onPressed: (((context) async {
                          await SQLHelper.deleteItem("Recovery", "RecoveryID",
                              dummyOrderList[index].recoveryID);

                          var _recovery;
                          DateFormat dateFormat = DateFormat('dd/MM/yyyy');
                          if (widget.tabName == "Search") {
                            _recovery = await SQLHelper.getFromToRecovery(
                                RecoveryTabBarItem.getFromDate(),
                                RecoveryTabBarItem.getToDate());
                          } else if (widget.tabName == "Today") {
                            String todayDate =
                                dateFormat.format(DateTime.now());
                            _recovery =
                                await SQLHelper.getSpecificRecovery(todayDate);
                          } else if (widget.tabName == "Yesterday") {
                            String yesterdayDate = dateFormat.format(
                                DateTime.now().subtract(Duration(days: 1)));
                            _recovery = await SQLHelper.getSpecificRecovery(
                                yesterdayDate);
                          } else {
                            _recovery = await SQLHelper.getAllRecovery();
                          }
                          setState(() {
                            RecoveryTabBarItem.listOfRecovery =
                                ViewRecovery.ViewRecoveryFromDb(_recovery);
                            if (RecoveryTabBarItem.listOfRecovery.isNotEmpty) {
                              CheckList(RecoveryTabBarItem.listOfRecovery);
                            }
                          });
                        })),
                        backgroundColor: const Color(0xFFFE4A49),
                        foregroundColor: Colors.white,
                        icon: Icons.delete,
                        label: 'Delete',
                      ),
                    ],
                  ),
                  child: Padding(
                      padding: EdgeInsets.all(6.0),
                      child: Container(
                          height: 110,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey,
                                  offset: Offset(0.0, 0.5), //(x,y)
                                  blurRadius: 3.0,
                                ),
                              ],
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5))),
                          child: Padding(
                            padding: EdgeInsets.all(12.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "RecoveryID: #${dummyOrderList[index].recoveryID}",
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                    Text(
                                      " ${dummyOrderList[index].party.partyName}",
                                      style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        // fontStyle: FontStyle.italic,
                                      ),
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text("Recovery On",
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.grey,
                                                fontWeight: FontWeight.bold)),
                                        Text(
                                          "${dummyOrderList[index].dated}",
                                          style: TextStyle(
                                              color: Colors.grey, fontSize: 13),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.all(4),
                                      decoration: BoxDecoration(
                                          color: Color(0xff00620b),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(5))),
                                      child: Text(
                                        "Rs ${dummyOrderList[index].amount}",
                                        style: TextStyle(
                                            fontStyle: FontStyle.italic,
                                            color: Colors.white),
                                      ),
                                    ),
                                    MaterialButton(
                                      onPressed: () async {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    ViewRecoveryDetailScreen(
                                                      selectedRecovery:
                                                          RecoveryTabBarItem
                                                                  .listOfRecovery[
                                                              index],
                                                    )));
                                      },
                                      padding: EdgeInsets.zero,
                                      child: Container(
                                        padding: EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                            color: Colors.grey.shade300,
                                            // border: Border.all(
                                            //     color:
                                            //         Color(0xff00620b),
                                            //     width: 1),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(5))),
                                        child: Text(
                                          "Recovery Detail",
                                          style: TextStyle(
                                              color: Color(0xff00620b),
                                              // fontStyle: FontStyle.italic,
                                              fontSize: 15),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ))));
            },
            itemCount: dummyOrderList.length,
            shrinkWrap: true,
            padding: const EdgeInsets.all(5),
            scrollDirection: Axis.vertical,
          )
        : const Center(
            child: const Text("Not Found"),
          );
  }
}
