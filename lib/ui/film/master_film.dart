import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_movie/bloc/film/film_bloc.dart';
import 'package:flutter_movie/core/bloc/app_setting_bloc.dart';
import 'package:flutter_movie/core/session_manager.dart';
import 'package:flutter_movie/models/film_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_movie/ui/user/login/login_user.dart';

import '../../repo/film_assets.dart';
import 'detail_film.dart';
import '../user/profile/profile_user.dart';
import 'package:flutter_movie/ui/custom_colors.dart';

class FilmMasterPage extends StatelessWidget {
  FilmMasterPage({Key? key}) : super(key: key);
  final sessionManager = SessionManager();

  @override
  Widget build(BuildContext context) {
    final firstName = sessionManager.getActiveFirstName();
    final lastName = sessionManager.getActiveLastName();
    final avatarFilename = getAvatarFilename();

    return Theme(
      data: Theme.of(context).copyWith(
        scaffoldBackgroundColor: Color(0xFF101010),
        appBarTheme: AppBarTheme(
          backgroundColor: CustomColors.primary2,
        ),
      ),
      child: WillPopScope(
        onWillPop: () async {
          // Tindakan yang ingin Anda lakukan saat tombol back ditekan
          // Misalnya, menampilkan dialog konfirmasi sebelum keluar dari aplikasi
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text('Keluar'),
              backgroundColor: CustomColors.secondary1,
              content: Text('Anda yakin ingin keluar?'),
              actions: [
                TextButton(
                  child: Text('Batal'),
                  onPressed: () => Navigator.pop(context),
                ),
                TextButton(
                  child: Text('Keluar'),
                  onPressed: () {
                    Navigator.pop(context, true);
                    SystemNavigator.pop(); // Keluar dari aplikasi
                  },
                ),
              ],
            ),
          );
          return false; // Set false untuk mencegah penanganan tombol back secara default
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              'Metadata Film',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white),
            ),
            automaticallyImplyLeading: false,
            centerTitle: true,
            leading: Builder(
              builder: (BuildContext context) {
                return IconButton(
                  icon: Icon(Icons.menu),
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                );
              },
            ),
          ),
          drawer: Drawer(
            child: Container(
              color: CustomColors
                  .primary2, // Ubah warna latar belakang sesuai kebutuhan
              child: ListView(
                padding: EdgeInsets.zero,
                children: <Widget>[
                  DrawerHeader(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage('$profileImage/$avatarFilename'),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: null),
                  ListTile(
                    title: Text(
                      'Selamat datang $firstName $lastName!',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onPrimary,
                        fontSize: 24,
                      ),
                    ),
                  ),
                  ListTile(
                    title: Text(
                      'Profile',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                    ),
                    onTap: () {
                      Navigator.pop(context); // Menutup drawer setelah navigasi
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ProfilePage()),
                      );
                    },
                  ),
                  ListTile(
                    title: Text(
                      'Logout',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                    ),
                    onTap: () {
                      sessionManager.signOut();

                      context.read<AppSettingBloc>()..add(SettingAppEvent());
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => LoginPage()),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
          body: BlocProvider(
            create: (context) => FilmBloc()..add(FilmIndexEvent()),
            child: BlocBuilder<FilmBloc, FilmState>(
              builder: (context, state) {
                if (state is FilmLoading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is FilmError) {
                  return Center(
                    child: Text(state.message.toString()),
                  );
                } else if (state is FilmLoaded) {
                  return GridView.count(
                    crossAxisCount: 2,
                    children:
                        List.generate(state.listFilmModel.length, (index) {
                      FilmModel filmModel = state.listFilmModel[index];
                      String fileName =
                          filmModel.thumbnail?.split('/').last ?? '';
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  FilmDetailPage(filmModel: filmModel),
                            ),
                          );
                        },
                        child: Card(
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          color: Colors.grey[800],
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(8.0),
                                    topRight: Radius.circular(8.0),
                                  ),
                                  child: Image.network(
                                    '$serverAssets/$fileName',
                                    fit: BoxFit.cover,
                                    width: double.infinity,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      filmModel.judul ?? '',
                                      style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onPrimary,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(height: 4),
                                    Text(
                                      filmModel.tahun?.toString() ?? '',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey[400],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
                  );
                }
                return Container();
              },
            ),
          ),
        ),
      ),
    );
  }
}
