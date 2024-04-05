import 'package:flutter/material.dart';

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

  @override
  Widget build(BuildContext context) {
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
                      icon: Icon(
                        Icons.calendar_month,
                        color: Colors.black,
                      ),
                      label: Text(
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
                    //Todo: finish booking
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
