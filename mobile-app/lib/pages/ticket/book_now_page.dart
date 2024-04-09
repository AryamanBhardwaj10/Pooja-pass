// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:pooja_pass/models/ticket.dart';
import 'package:pooja_pass/models/user.dart';
import 'package:pooja_pass/provider/user_provider.dart';
import 'package:pooja_pass/services/date_crowd_info_services.dart';
import 'package:pooja_pass/services/ticket_services.dart';
import 'package:provider/provider.dart';

class BookNowPage extends StatefulWidget {
  const BookNowPage({super.key});

  @override
  State<BookNowPage> createState() => _BookNowPageState();
}

class _BookNowPageState extends State<BookNowPage> {
  TextEditingController member1Controller = TextEditingController();
  TextEditingController member2Controller = TextEditingController();
  TextEditingController member3Controller = TextEditingController();
  TextEditingController member4Controller = TextEditingController();
  TextEditingController member5Controller = TextEditingController();

  //ticket service
  final TicketServices _ticketServices = TicketServices();

  //user
  User? user;
  //date picker
  DateTime _bookingDate = DateTime.now();
  void _showDatePicker() {
    showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      initialDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 45)),
    ).then((value) {
      setState(() {
        _bookingDate = value!;
      });
    });
  }

  //book ticket
  void bookTicket(BuildContext context) async {
    List<String> memberNames = [];
    if (member1Controller.text != "") {
      memberNames.add(member1Controller.text);
    }
    if (member2Controller.text != "") {
      memberNames.add(member2Controller.text);
    }
    if (member3Controller.text != "") {
      memberNames.add(member3Controller.text);
    }
    if (member4Controller.text != "") {
      memberNames.add(member4Controller.text);
    }

    String bookingDate = DateCrowdInfoServices.formatDateToString(_bookingDate);
    Ticket? ticket = await _ticketServices.bookTicket(
        context, user!.id, user!.email, bookingDate, memberNames);
    if (ticket == null) {
      showDialog(
          context: context,
          builder: (context) => const AlertDialog(
                icon: Icon(
                  Icons.error,
                  color: Colors.red,
                  size: 30,
                ),
                title: Text(
                  "Booking failed",
                  style: TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ));
    } else {
      showDialog(
          context: context,
          builder: (context) => const AlertDialog(
                icon: Icon(
                  Icons.check_circle,
                  color: Colors.green,
                  size: 30,
                ),
                title: Text(
                  "Booking Done",
                  style: TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ));
    }
  }

  @override
  Widget build(BuildContext context) {
    user = Provider.of<UserProvider>(context).user;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: const Text("Book Now"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Column(
            children: [
              const SizedBox(height: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildTextfield(member1Controller, "Member 1 Name"),
                  _buildTextfield(member2Controller, "Member 2 Name"),
                  _buildTextfield(member3Controller, "Member 3 Name"),
                  _buildTextfield(member4Controller, "Member 4 Name"),
                  _buildTextfield(member5Controller, "Member 5 Name"),
                  TextButton.icon(
                      onPressed: _showDatePicker,
                      icon: const Icon(
                        Icons.calendar_month,
                        color: Colors.black,
                      ),
                      label: const Text(
                        "Choose Date",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.black54,
                        ),
                      )),
                ],
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.6,
                child: ElevatedButton(
                  onPressed: () {
                    bookTicket(context);
                  },
                  style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      backgroundColor: Colors.purple,
                      foregroundColor: Colors.white),
                  child: const Text(
                    "Finish booking!",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 19,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextfield(
    TextEditingController controller,
    String hintText,
  ) {
    return Container(
      margin: EdgeInsets.only(bottom: 15),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
            color: Theme.of(context).colorScheme.tertiary,
          )),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
            color: Theme.of(context).colorScheme.primary,
          )),
          fillColor: Theme.of(context).colorScheme.tertiary,
          filled: true,
          hintText: hintText,
          hintStyle: TextStyle(color: Theme.of(context).colorScheme.primary),
        ),
      ),
    );
  }
}
