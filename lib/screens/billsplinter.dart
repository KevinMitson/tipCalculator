import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:tipcalc/util/hexcolor.dart';

class BillSplinter extends StatefulWidget {
  const BillSplinter({Key? key}) : super(key: key);

  @override
  State<BillSplinter> createState() => _BillSplinterState();
}

class _BillSplinterState extends State<BillSplinter> {
  int _tipPercentange = 0;
  int _personCounter = 1;
  double _billAmount = 0.0;

  Color _purple = HexColor("#6908D6");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(
          top: MediaQuery.of(context).size.height * 0.1,
        ),
        alignment: Alignment.center,
        color: Colors.white,
        child: ListView(
            scrollDirection: Axis.vertical,
            padding: EdgeInsets.all(20.5),
            children: [
              Container(
                height: 150,
                width: 150,
                decoration: BoxDecoration(
                  color: _purple.withOpacity(0.1), //Colors.purple.shade100,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Total Per Person",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15.0,
                          color: _purple,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Text(
                          "\$ ${calculateTotalPerPerson(_billAmount, _personCounter, _tipPercentange)}",
                          style: TextStyle(
                            fontSize: 34.9,
                            fontWeight: FontWeight.bold,
                            color: _purple,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 20),
                padding: EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  border: Border.all(
                    color: Colors.blueGrey.shade100,
                    style: BorderStyle.solid,
                  ),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Column(
                  children: [
                    TextField(
                      keyboardType:
                          TextInputType.numberWithOptions(decimal: true),
                      style: TextStyle(
                        color: _purple,
                      ),
                      decoration: InputDecoration(
                        prefix: Text("Bill Amount"),
                        prefixIcon: Icon(Icons.attach_money),
                      ),
                      onChanged: (String value) {
                        try {
                          _billAmount = double.parse(value);
                        } catch (Exception) {
                          _billAmount = 0.0;
                        }
                      },
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Split",
                          style: TextStyle(
                            color: Colors.grey.shade700,
                          ),
                        ),
                        Row(
                          children: [
                            InkWell(
                              onTap: () {
                                setState(() {
                                  if (_personCounter > 1) {
                                    _personCounter--;
                                  } else {
                                    //nothing
                                  }
                                });
                              },
                              child: Container(
                                width: 40,
                                height: 40,
                                margin: EdgeInsets.all(10.0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(7.0),
                                  color: _purple.withOpacity(0.1),
                                ),
                                child: Center(
                                  child: Text(
                                    "-",
                                    style: TextStyle(
                                      color: _purple,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17.0,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Text(
                              "$_personCounter",
                              style: TextStyle(
                                color: _purple,
                                fontSize: 17.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  _personCounter++;
                                });
                              },
                              child: Container(
                                width: 40,
                                height: 40,
                                margin: EdgeInsets.all(10.0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(7.0),
                                  color: _purple.withOpacity(0.1),
                                ),
                                child: Center(
                                  child: Text(
                                    "+",
                                    style: TextStyle(
                                      color: _purple,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17.0,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    //tip
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Tip",
                          style: TextStyle(color: Colors.grey.shade700),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: Text(
                              "\$ ${(calculateTotalTip(_billAmount, _personCounter, _tipPercentange)).toStringAsFixed(2)}",
                              style: TextStyle(
                                fontSize: 17,
                                color: _purple,
                                fontWeight: FontWeight.bold,
                              )),
                        )
                      ],
                    ),
                    //slider
                    Column(
                      children: [
                        Text("$_tipPercentange%",
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              color: _purple,
                            )),
                        Slider(
                            min: 0,
                            max: 100,
                            activeColor: _purple,
                            inactiveColor: Colors.grey,
                            //divisions: 10,
                            value: _tipPercentange.toDouble(),
                            onChanged: (double value) {
                              setState(() {
                                _tipPercentange = value.round();
                              });
                            })
                      ],
                    ),
                  ],
                ),
              ),
            ]),
      ),
    );
  }

  calculateTotalPerPerson(double billAmount, int splintBy, int tipPercentage) {
    var totalPerPerson =
        (calculateTotalTip(billAmount, splintBy, tipPercentage) + billAmount) /
            splintBy;
    return totalPerPerson.toStringAsFixed(2);
  }

  calculateTotalTip(double billAmount, int splintBy, int tipPercentage) {
    double totalTip = 0.0;
    if (billAmount < 0 || billAmount.toString().isEmpty || billAmount == null) {
      //no go
    } else {
      totalTip = (billAmount * tipPercentage) / 100;
    }
    return totalTip;
  }
}
