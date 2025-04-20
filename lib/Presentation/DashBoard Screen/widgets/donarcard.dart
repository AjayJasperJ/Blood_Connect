import 'package:blood_bank_application/Global/colors.dart';
import 'package:blood_bank_application/API/UserAPI/userprovider.dart';
import 'package:blood_bank_application/main.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DonarCard extends StatefulWidget {
  const DonarCard({Key? key}) : super(key: key);

  @override
  State<DonarCard> createState() => _DonarCardState();
}

class _DonarCardState extends State<DonarCard> {
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);

    return Stack(
      alignment: Alignment.topRight,
      children: [
        GestureDetector(
          onTap: () {},
          child: Card(
            color: Colors.white,
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: EdgeInsets.only(top: displaysize.height * .01),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (userProvider.donarcardstatus)
                    const Center(
                      child: CircularProgressIndicator(),
                    )
                  else if (userProvider.users.isEmpty)
                    const Center(
                      child: Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Text(
                          "No donor data available",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
                          ),
                        ),
                      ),
                    )
                  else
                    ListTile(
                      leading: CircleAvatar(
                        radius: 25,
                        backgroundImage:
                            NetworkImage(userProvider.users[0].avatar),
                      ),
                      title: Text(
                        'Donor Name: ${userProvider.users[0].fullName[0].toUpperCase()}${userProvider.users[0].fullName.substring(1)}',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: appColor,
                            fontSize: displaysize.height * .016),
                      ),
                      subtitle: Text(
                        'Role: ${userProvider.users[0].role}',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                            color: Colors.grey),
                      ),
                    ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: displaysize.width * .04),
                    child: Consumer<UserProvider>(
                      builder: (context, value, child) {
                        if (value.users.isEmpty) {
                          return const Text(
                            'Blood Group: Not Available',
                            style: TextStyle(
                                color: Colors.grey,
                                fontSize: 14,
                                fontWeight: FontWeight.w500),
                          );
                        }
                        return Text(
                          'Blood Group: ${value.users[0].bloodGroup}',
                          style: TextStyle(
                              color: Colors.grey[800],
                              fontSize: displaysize.height * .016,
                              fontWeight: FontWeight.w500),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: displaysize.height * .02),
                  Container(
                    height: displaysize.height * 0.05,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10)),
                      color: appColor,
                    ),
                    child: const Center(
                      child: Text(
                        'Organization: Blood Bank Organization',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
