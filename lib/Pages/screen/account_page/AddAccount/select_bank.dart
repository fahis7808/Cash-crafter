import 'package:cash_crafter/Pages/widget/text_field/custom_text_field.dart';
import 'package:cash_crafter/constant/app_font.dart';
import 'package:cash_crafter/constant/bnak_details.dart';
import 'package:flutter/material.dart';

import '../../../../constant/app_colors.dart';
import '../../../widget/custom_appbar.dart';
import 'add_acount_page.dart';

class SelectBank extends StatefulWidget {
  const SelectBank({super.key});

  @override
  State<SelectBank> createState() => _SelectBankState();
}

class _SelectBankState extends State<SelectBank> {
  List<Map<String, String>> filteredBankList = [];
  String searchValue = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    filteredBankList = List.from(bankList);
  }

  void _filterBanks(String query) {
    setState(() {
      filteredBankList = bankList
          .where((bank) =>
              bank['name']!.toLowerCase().startsWith(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CustomAppBar(title: "Select Bank"),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              CustomTextField(
                  value: searchValue,
                  labelText: "Search Bank",
                  onChanged: (val) {
                    searchValue = val;
                    _filterBanks(val);
                  }),
              Expanded(
                child: ListView.builder(
                  itemCount: filteredBankList.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: DecoratedBox(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border:
                              Border.all(color: AppColors.cardColor, width: 1),
                        ),
                        child: CircleAvatar(
                          backgroundColor: Colors.transparent,
                          backgroundImage:
                              AssetImage(filteredBankList[index]['logo']!),
                        ),
                      ),
                      title: Text(filteredBankList[index]['name']!,
                          style: AppFont.textFieldText),
                      onTap: () => Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const AddAccountPage())),
                    );
                  },
                ),
              ),
            ],
          ),
        ));
  }
}

class SearchListExample extends StatefulWidget {
  @override
  _SearchListExampleState createState() => _SearchListExampleState();
}

class _SearchListExampleState extends State<SearchListExample> {
  TextEditingController _searchController = TextEditingController();

  List<String> allItems = [
    'Apple',
    'Banana',
    'Cherry',
    'Date',
    'Elderberry',
    'Fig',
    'Grape',
    'Guava',
    'Kiwi',
    'Lemon',
  ];

  List<String> filteredItems = [];

  @override
  void initState() {
    super.initState();
    filteredItems = List.from(allItems); // show all initially
  }

  void _filterItems(String query) {
    setState(() {
      filteredItems = allItems
          .where((item) => item.toLowerCase().startsWith(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Search Filter Example')),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(12),
            child: TextField(
              controller: _searchController,
              onChanged: _filterItems,
              decoration: InputDecoration(
                hintText: 'Search by first letter...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
          Expanded(
            child: filteredItems.isNotEmpty
                ? ListView.builder(
                    itemCount: filteredItems.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(filteredItems[index]),
                      );
                    },
                  )
                : Center(child: Text("No items match")),
          )
        ],
      ),
    );
  }
}
