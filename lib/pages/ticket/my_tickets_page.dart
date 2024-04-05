import 'package:flutter/material.dart';
import 'package:pooja_pass/components/ticket_details_tile.dart';
import 'package:pooja_pass/pages/ticket/ticket_qr_page.dart';

class MyTicketPage extends StatefulWidget {
  const MyTicketPage({super.key});

  @override
  State<MyTicketPage> createState() => _MyTicketPageState();
}

class _MyTicketPageState extends State<MyTicketPage> {
  //TODO: replace the dummy stuff
  List<String> tickets = ["", "", "", "", "", "", ""];
  ////////
  //
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: const Text("My Tickets"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: tickets.length,
                shrinkWrap: true,
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  return TicketDetailsTile(
                    onTap: () {
                      //TODO: passing data
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => TicketQrPage()));
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
