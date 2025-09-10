class BoardingModel {
  late final String image;
  late final String title;
  late final String body;

  BoardingModel({required this.image, required this.title, required this.body});
}

List<BoardingModel> boarding = [
  BoardingModel(
    image: 'assets/images/image1.jpg',
    title: 'Lorem Ipsum is simply dummy',
    body:
        'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
  ),
  BoardingModel(
    image: 'assets/images/image2.jpg',
    title: 'Lorem Ipsum is simply dummy',
    body:
        'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
  ),
  BoardingModel(
    image: 'assets/images/image3.jpg',
    title: 'Lorem Ipsum is simply dummy',
    body:
        'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
  ),
];
