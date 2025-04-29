import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_movie/bloc/film/film_bloc.dart';
import 'package:flutter_movie/models/film_model.dart';

class FilmIndexPage extends StatelessWidget {
  const FilmIndexPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Movie Metadata Film'),
      ),
      body: BlocProvider(
        create: (context) => FilmBloc()..add(FilmIndexEvent()),
        child: BlocBuilder<FilmBloc, FilmState>(
          builder: (context, state) {
            if (state is FilmLoading){
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is FilmError){
              return Center(
                child: Text(state.message.toString()),
              );
            } else if (state is FilmLoaded){
              return ListView.builder(
                  itemCount: state.listFilmModel.length,
                  itemBuilder: (context, index) {
                    FilmModel filmModel =
                        state.listFilmModel[index];
                    return ListTile(
                      title: Text(filmModel.judul.toString()),
                    );
                  });
            }
            return Container();
          },
        ),
      ),
    );
  }
}
