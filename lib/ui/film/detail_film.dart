import 'package:flutter/material.dart';
import 'package:flutter_movie/models/film_model.dart';
import '../../repo/film_assets.dart';
import 'package:flutter_movie/ui/custom_colors.dart';
import 'package:glassmorphism/glassmorphism.dart';

class FilmDetailPage extends StatelessWidget {
  final FilmModel filmModel;

  const FilmDetailPage({required this.filmModel, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    String fileName = filmModel.thumbnail?.split('/').last ?? '';
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Detail Film',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: CustomColors.primary2,
      ),
      body: Stack(
        children: [
          Image.network('$serverAssets/$fileName',
            fit: BoxFit.cover,
            height: double.infinity,
            width: double.infinity,
          ),
          SafeArea(
            child: Center(
              child: GlassmorphicContainer(
                  height: double.infinity,
                  width: double.infinity,
                  borderRadius: 0,
                  blur: 30,
                  border: 0,
                  linearGradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Colors.black.withOpacity(0.3),
                        Colors.black.withOpacity(1),
                      ],
                      stops: [
                        0.1,
                        1,
                      ]),
                  borderGradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color(0xFFffffff).withOpacity(0.5),
                      Color((0xFFFFFFFF)).withOpacity(0.5),
                    ],
                  ),
                  child:
                  Stack(
                    children: [
                      Container(
                        height: screenHeight * 0.2,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage('$serverAssets/$fileName'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Container(
                        height: screenHeight * 0.2,
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.5), // Warna overlay gelap
                        ),
                      ),
                    ],
                  ),
              ),
            ),
          ),
          SingleChildScrollView(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: screenHeight * .03),
                Container(
                  alignment: Alignment.center,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child:
                    Image.network('$serverAssets/$fileName',
                      width: 200,),
                  ),
                ),
                SizedBox(height: screenHeight * .03),
                Text(
                  filmModel.judul ?? '',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: screenHeight * .03),
                _buildDetailItem('Tahun', filmModel.tahun?.toString() ?? ''),
                _buildDetailItem('Rating', filmModel.average_rating?.toString() ?? '0.0'),
                _buildDetailItem('Durasi', '${filmModel.durasi?.toString() ?? ''} menit'),
                _buildDetailItem('Status', filmModel.status?.toString() ?? ''),
                _buildDetailItem('Negara', filmModel.negara?.join(', ') ?? ''),
                _buildDetailItem('Sinopsis', filmModel.deskripsi ?? ''),
                _buildDetailItem('Bahasa', filmModel.bahasa?.join(', ') ?? ''),
                _buildDetailItem('Genre', filmModel.genre?.join(', ') ?? ''),
                _buildDetailItem('Sutradara', filmModel.sutradara?.join(', ') ?? ''),
                _buildDetailItem('Aktor', filmModel.aktor?.join(', ') ?? ''),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(
              fontSize: 18,
              color: Colors.white.withOpacity(.80),
            ),
          ),
        ],
      ),
    );
  }
}