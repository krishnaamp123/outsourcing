import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:outsourcing/components/text_widget.dart';

class DropdownPay extends StatefulWidget {
  final List<String> items;

  const DropdownPay({
    Key? key,
    required this.items,
  }) : super(key: key);

  @override
  _DropdownPayState createState() => _DropdownPayState();
}

class _DropdownPayState extends State<DropdownPay> {
  late String? selectedValue;
  late TextEditingController textEditingController;

  @override
  void initState() {
    super.initState();
    selectedValue = null;
    textEditingController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0.0),
      child: Column(children: [
        Container(
          alignment: Alignment.center,
          child: const TextWidget(
            'Pilih Tipe Pembayaran',
            14,
            Color.fromRGBO(129, 12, 168, 1),
            FontWeight.normal,
            letterSpace: 0,
            textAlign: TextAlign.left,
          ),
        ),
        const SizedBox(height: 5),
        Card(
          elevation: 5, // Atur elevation di sini
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton2<String>(
              isExpanded: true,
              hint: Text(
                'Select Payment Type',
                style: TextStyle(
                  fontSize: 14,
                  color: Theme.of(context).hintColor,
                ),
              ),
              items: widget.items
                  .map((item) => DropdownMenuItem(
                        value: item,
                        child: Text(
                          item,
                          style: const TextStyle(
                            fontSize: 15,
                          ),
                        ),
                      ))
                  .toList(),
              value: selectedValue,
              onChanged: (value) {
                setState(() {
                  selectedValue = value!;
                });
              },
              buttonStyleData: const ButtonStyleData(
                // padding: EdgeInsets.symmetric(horizontal: 5),
                padding: EdgeInsets.only(left: 0, right: 14),
                height: 50,
                // width: 200,
              ),
              iconStyleData: const IconStyleData(
                icon: Icon(
                  Icons.arrow_drop_down_outlined,
                ),
                iconSize: 25,
                iconEnabledColor: Colors.grey,
              ),
              dropdownStyleData: const DropdownStyleData(
                maxHeight: 200,
              ),
              menuItemStyleData: const MenuItemStyleData(
                height: 55,
              ),
              dropdownSearchData: DropdownSearchData(
                searchController: textEditingController,
                searchInnerWidgetHeight: 55,
                searchInnerWidget: Container(
                  height: 55,
                  padding: const EdgeInsets.only(
                    top: 8,
                    bottom: 4,
                    right: 8,
                    left: 8,
                  ),
                  child: TextFormField(
                    expands: true,
                    maxLines: null,
                    controller: textEditingController,
                    decoration: InputDecoration(
                      isDense: true,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 8,
                      ),
                      hintText: 'Search for an Order...',
                      hintStyle: const TextStyle(fontSize: 15),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
                searchMatchFn: (item, searchValue) {
                  return item.value.toString().contains(searchValue);
                },
              ),
              //This to clear the search value when you close the menu
              onMenuStateChange: (isOpen) {
                if (!isOpen) {
                  textEditingController.clear();
                }
              },
            ),
          ),
        ),
      ]),
    );
  }
}
