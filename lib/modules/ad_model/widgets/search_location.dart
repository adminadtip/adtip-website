import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PlacesSearchWidget extends StatefulWidget {
  final TextEditingController searchController;
  final Function(Map<String, dynamic>) onPlaceSelected;

  const PlacesSearchWidget(
      {Key? key, required this.onPlaceSelected, required this.searchController})
      : super(key: key);

  @override
  _PlacesSearchWidgetState createState() => _PlacesSearchWidgetState();
}

class _PlacesSearchWidgetState extends State<PlacesSearchWidget> {
  List<dynamic> _places = [];
  final String _googleAPIKey = 'YOUR_GOOGLE_API_KEY';
  OverlayEntry? _overlayEntry;

  void _searchPlaces(String input) async {
    final url =
        Uri.parse('https://adtip2.qa.ad-tip.com/api/googleplace?input=$input');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      setState(() {
        _places = jsonResponse['predictions'];
        _showOverlay();
      });
    }
  }

  void _getPlaceDetails(String placeId, String placeName) async {
    final url = Uri.parse(
        'https://adtip2.qa.ad-tip.com/api/googleplacedetails/?placeid=$placeId');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      final location = jsonResponse['result']['geometry']['location'];
      widget.onPlaceSelected(
          {'name': placeName, 'lat': location['lat'], 'lng': location['lng']});
    }
  }

  void _showOverlay() {
    final RenderBox textFieldRenderBox =
        context.findRenderObject() as RenderBox;
    final textFieldPosition = textFieldRenderBox.localToGlobal(Offset.zero);

    final topPosition = textFieldPosition.dy + textFieldRenderBox.size.height;
    final leftPosition = textFieldPosition.dx;
    if (_overlayEntry != null) {
      _overlayEntry!.remove();
    }

    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: topPosition,
        left: leftPosition,
        child: Material(
          elevation: 4.0,
          child: Container(
            height: 200,
            width: 400,
            color: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: ListView.builder(
              itemCount: _places.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_places[index]['description']),
                  onTap: () {
                    _getPlaceDetails(
                      _places[index]['place_id'],
                      _places[index]['description'],
                    );
                    setState(() {
                      _places = [];
                    });
                    _overlayEntry!.remove();
                    _overlayEntry = null;
                  },
                );
              },
            ),
          ),
        ),
      ),
    );

    Overlay.of(context).insert(_overlayEntry!);
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.searchController,
      decoration: const InputDecoration(labelText: 'Search Places'),
      onChanged: (value) {
        if (value.isNotEmpty) {
          _searchPlaces(value);
        } else {
          setState(() {
            _places = [];
            _overlayEntry?.remove();
            _overlayEntry = null;
          });
        }
      },
    );
  }

  @override
  void dispose() {
    widget.searchController.dispose();
    _overlayEntry?.remove();
    super.dispose();
  }
}
