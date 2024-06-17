import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:outsourcing/components/text_widget.dart';

class StatusDropdown extends StatefulWidget {
  final List<String> statusList;
  final Function(String) onFilterChanged;

  const StatusDropdown({
    Key? key,
    required this.statusList,
    required this.onFilterChanged,
  }) : super(key: key);

  @override
  _StatusDropdownState createState() => _StatusDropdownState();
}

class _StatusDropdownState extends State<StatusDropdown> {
  late String _selectedStatus;
  late TextEditingController textEditingController;

  @override
  void initState() {
    super.initState();
    _selectedStatus = widget.statusList.first;
    textEditingController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(children: [
        Container(
          alignment: Alignment.centerLeft,
          child: const TextWidget(
            'Filter Status',
            15,
            Color.fromRGBO(129, 12, 168, 1),
            FontWeight.normal,
            letterSpace: 0,
            textAlign: TextAlign.left,
          ),
        ),
        const SizedBox(height: 5),
        Card(
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton2<String>(
              isExpanded: true,
              value: _selectedStatus,
              onChanged: (newValue) {
                setState(() {
                  _selectedStatus = newValue!;
                  widget.onFilterChanged(newValue);
                });
              },
              items: widget.statusList
                  .map<DropdownMenuItem<String>>((String value) {
                // Tentukan warna untuk setiap status
                Color statusColor = _getStatusColor(value);
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    value,
                    style: TextStyle(
                      color:
                          value == _selectedStatus ? statusColor : statusColor,
                      fontWeight: value == _selectedStatus
                          ? FontWeight.bold
                          : FontWeight.normal,
                    ),
                  ),
                );
              }).toList(),
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
                height: 50,
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
                      hintText: 'Search for an Status...',
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
            ),
          ),
        ),
      ]),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'waiting_for_mou':
        return Colors.orange;
      case 'waiting_for_initial_payment':
        return Colors.orange;
      case 'waiting_for_further_payment':
        return Colors.orange;
      case 'waiting_for_confirmation':
        return Colors.orange;
      case 'waiting_for_mou_confirmation':
        return Colors.orange;
      case 'ongoing':
        return Colors.green;
      case 'done':
        return Colors.blue;
      case 'confirmed':
        return Colors.blue;
      case 'suspended':
        return Colors.red;
      default:
        return const Color.fromRGBO(45, 3, 59, 1);
    }
  }
}
