class OnBoardingModel {
  final String image;
  final String title;
  final String desc;
  final bool isSpecial;

  OnBoardingModel({
    required this.image,
    required this.title,
    required this.desc,
    this.isSpecial = false,
  });
}