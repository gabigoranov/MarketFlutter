import 'package:flutter/material.dart';
import 'package:market/models/user-service.dart';
import 'package:market/models/user.dart';


class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  User userData = UserService.instance.user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.fromLTRB(0,0,0,16),
        margin:  const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  constraints: const BoxConstraints(
                    maxHeight: 350,
                    //maximum width set to 100% of width
                  ),
                  child: Image.network(
                    "https://th.bing.com/th/id/OIP._pXeW2oQdkvkpBoEHdw5qAHaJQ?rs=1&pid=ImgDetMain",
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Center(
                  child: Container(
                    height: 38,
                    padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 14),
                    margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                    decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    borderRadius: BorderRadius.circular(20),
                      boxShadow: const[
                        BoxShadow(
                          color: Colors.black38,
                          spreadRadius: 2.0,
                          blurRadius: 2,
                          offset: Offset(2, 3), // changes position of shadow
                        ),
                      ],
                    ),

                    child: Text("${userData.firstName} ${userData.lastName}", style: TextStyle(fontSize: 18.0, color: Theme.of(context).colorScheme.background),),
                  ),
                ),

              ],
            ),
            

          ],
        ),
      ),
    );
  }
}
