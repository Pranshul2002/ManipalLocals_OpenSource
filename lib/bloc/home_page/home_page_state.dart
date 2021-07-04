part of 'home_page_bloc.dart';

abstract class HomePageState extends Equatable {
  const HomePageState();
}

class HomePageLoading extends HomePageState {
  @override
  List<Object> get props => [];
}

class HomePageLoaded extends HomePageState {
  final double height;
  final int selectedIndex;

  final list = [
    GalleryScreen(),
    TopPart(),
    NotificationPage(),
  ];
  HomePageLoaded.name(
    this.height,
    this.width,
    this.selectedIndex,
  );

  final double width;
  @override
  List<Object> get props => [height, width, list];
}
