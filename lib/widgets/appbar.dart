import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:scouting_app_865/utils/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  const CustomAppBar({Key? key}) : super(key: key);

  //copied from https://stackoverflow.com/a/52678686/18758848
  @override
  Size get preferredSize => const Size.fromHeight(40);

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  final _teamNumberController = TextEditingController();
  final _matchNumberController = TextEditingController();

  Future _getTeamNumberData() async {
    final _teamNumberPrefrences = await SharedPreferences.getInstance();
    setState(
        () => _teamNumberController.text = _teamNumberPrefrences.getString("Team") ?? "");
  }

  Future _setTeamNumberData(value) async {
    final _teamNumberPrefrences = await SharedPreferences.getInstance();
    _teamNumberPrefrences.setString("Team", value);
  }

  Future _getMatchNumberData() async {
    final _matchNumberPrefrences = await SharedPreferences.getInstance();
    setState(
            () => _matchNumberController.text = _matchNumberPrefrences.getString("Team") ?? "");
  }

  Future _setMatchNumberData(value) async {
    final _matchNumberPrefrences = await SharedPreferences.getInstance();
    _matchNumberPrefrences.setString("Team", value);
  }

  @override
  void initState() {
    _getTeamNumberData();
    _getMatchNumberData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("Match Number"),
          const SizedBox(width: 5),
          SizedBox(
            width: 54,
            height: 30,
            child: TextFormField(
              maxLength: 4,
              keyboardType: TextInputType.number,
              controller: _matchNumberController,
              onChanged: (value) => _setMatchNumberData(value),
              style: TextStyle(
                fontSize: 20,
                color: palette().onPrimary,
              ),
              textAlignVertical: TextAlignVertical.bottom,
              decoration: const InputDecoration(
                isDense: true,
                contentPadding: EdgeInsets.all(3.0),
                counterText: "",
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                )
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.clear_rounded),
            onPressed: (){
              setState(() => _matchNumberController.text = "");
              _setMatchNumberData("");
            },
          ),
          const Text("Team Number:"),
          const SizedBox(width: 5),
          SizedBox(
            width: 50,
            height: 25,
            child: TextFormField(
              maxLength: 4,
              keyboardType: TextInputType.number, // brings up numpad on mobile
              controller: _teamNumberController,
              onChanged: (value) => _setTeamNumberData(value),
              style: TextStyle(
                fontSize: 20,
                color: palette().onPrimary,
              ),
              textAlignVertical: TextAlignVertical.bottom,
              decoration: const InputDecoration(
                isDense: true, // reduces vertical space
                contentPadding: EdgeInsets.all(3.0), // reduce vertical space
                counterText: "", // hides a character counter which takes space
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.clear_rounded),
            onPressed: () {
              setState(() => _teamNumberController.text = "");
              _setTeamNumberData("");
            },
          ),
        ],
      ),
      centerTitle: true,
    );
  }
}
