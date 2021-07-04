part of 'home_page_bloc.dart';

abstract class HomePageEvent extends Equatable {
  const HomePageEvent();
}

class HomePageInit extends HomePageEvent {
  final BuildContext context;

  HomePageInit(this.context);
  @override
  List<Object> get props => [];
}

class HomePageFeedback extends HomePageEvent {
  @override
  List<Object> get props => [];
}

class HomePageInstagram extends HomePageEvent {
  @override
  List<Object> get props => [];
}

class HomePageMail extends HomePageEvent {
  @override
  List<Object> get props => [];
}

class HomePageTwitter extends HomePageEvent {
  @override
  List<Object> get props => [];
}

class HomePageWhatsApp extends HomePageEvent {
  @override
  List<Object> get props => [];
}

class HomePageComingSoon extends HomePageEvent {
  @override
  List<Object> get props => [];
}

class HomePageMap extends HomePageEvent {
  @override
  List<Object> get props => [];
}

class HomePageChangeBottom extends HomePageEvent {
  final HomePageLoaded homePageLoaded;
  final int val;
  HomePageChangeBottom(this.homePageLoaded, this.val);
  @override
  List<Object> get props => [];
}

class HomePageChangeStudentClubTab extends HomePageEvent {
  final int tab;

  HomePageChangeStudentClubTab(this.tab);
  @override
  List<Object> get props => [];
}

class HomePageChangeFAQTab extends HomePageEvent {
  final int tab;

  HomePageChangeFAQTab(this.tab);

  @override
  List<Object> get props => [];
}
