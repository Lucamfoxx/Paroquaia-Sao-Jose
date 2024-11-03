import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class FestasPage extends StatefulWidget {
  @override
  _FestasPageState createState() => _FestasPageState();
}

class _FestasPageState extends State<FestasPage> {
  List<String> _bannerUrls = [];

  @override
  void initState() {
    super.initState();
    _fetchBannerUrls();
  }

  Future<void> _fetchBannerUrls() async {
    final url =
        'https://gist.githubusercontent.com/Lucamfoxx/23a5b08abcb00a0f57f8d068f47c90ad/raw/a014a6104fd49bc3b4badb3126645e1b5530291f/banners_S%25C3%25A3o_Jos%25C3%25A9.json';
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          _bannerUrls =
              List<String>.from(data['images'].map((item) => item['url']));
        });
      } else {
        print('Erro ao carregar JSON: ${response.statusCode}');
      }
    } catch (e) {
      print('Erro ao carregar JSON: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Eventos'),
      ),
      body: Center(
        child: _bannerUrls.isEmpty
            ? CircularProgressIndicator()
            : SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: _bannerUrls
                      .map((url) => BannerImage(imageUrl: url))
                      .toList(),
                ),
              ),
      ),
    );
  }
}

class BannerImage extends StatelessWidget {
  final String imageUrl;

  const BannerImage({Key? key, required this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Image.network(
              imageUrl,
              fit: BoxFit.fitWidth,
              width: constraints.maxWidth,
            );
          },
        ),
      ),
    );
  }
}
