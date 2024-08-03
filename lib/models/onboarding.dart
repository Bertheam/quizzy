class OnboardingContent {
  String image;
  String title;

  OnboardingContent(
      {required this.image,
        required this.title,
      });
}

List<OnboardingContent> contents = [
  OnboardingContent(
    title: "Engagez-vous avec des jeux interactifs conçus pour rendre l'apprentissage agréable.",
    image: "assets/images/image1.jpg",
  ),
  OnboardingContent(
    title: "Créez facilement des quiz et des devoirs pour vos élèves",
    image: "assets/images/image2.jpeg",
  ),
  OnboardingContent(
    title: "Explorez divers sujets et améliorez vos compétences en jouant.",
    image: "assets/images/image3.jpg",
  ),
];
