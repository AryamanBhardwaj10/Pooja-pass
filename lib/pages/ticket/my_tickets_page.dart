import 'package:flutter/material.dart';
import 'package:pooja_pass/components/ticket_details_tile.dart';
import 'package:pooja_pass/models/ticket.dart';
import 'package:pooja_pass/models/user.dart';
import 'package:pooja_pass/pages/ticket/ticket_qr_page.dart';
import 'package:pooja_pass/provider/user_provider.dart';
import 'package:pooja_pass/services/ticket_services.dart';
import 'package:provider/provider.dart';

class MyTicketPage extends StatefulWidget {
  const MyTicketPage({super.key});

  @override
  State<MyTicketPage> createState() => _MyTicketPageState();
}

// class _MyTicketPageState extends State<MyTicketPage> {
//   TicketServices _ticketServices = TicketServices();
//   List<String> tickets = ["", "", "", "", "", "", ""];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Theme.of(context).colorScheme.background,
//       appBar: AppBar(
//         title: const Text("My Tickets"),
//       ),
//       body: Consumer<UserProvider>(
//         builder: (context, userProvider, _) {
//           User user = userProvider.user;

//           return Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 8.0),
//             child: Column(
//               children: [
//                 Expanded(
//                   child: ListView.builder(
//                     itemCount: tickets.length,
//                     shrinkWrap: true,
//                     physics: BouncingScrollPhysics(),
//                     itemBuilder: (context, index) {
//                       return TicketDetailsTile(
//                         onTap: () {
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                               builder: (context) => TicketQrPage(),
//                             ),
//                           );
//                         },
//                       );
//                     },
//                   ),
//                 ),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

class _MyTicketPageState extends State<MyTicketPage> {
  TicketServices _ticketServices = TicketServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: const Text("My Tickets"),
      ),
      body: Consumer<UserProvider>(
        builder: (context, userProvider, _) {
          User user = userProvider.user;

          return FutureBuilder<List<Ticket>>(
            future: _ticketServices.getUserTickets(context, user.id),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (snapshot.data!.length == 0) {
                return const Center(
                    child: Text(
                  'No tickets available',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ));
              } else {
                List<Ticket> tickets = snapshot.data!;
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                          itemCount: tickets.length,
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            Ticket ticket = tickets[index];
                            debugPrint(ticket.ticketDate);
                            return TicketDetailsTile(
                              ticket: ticket,
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => TicketQrPage(
                                      ticket: ticket,
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                );
              }
            },
          );
        },
      ),
    );
  }
}
