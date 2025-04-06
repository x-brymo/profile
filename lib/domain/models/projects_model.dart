
class UIXProject {
  final String title;
  final String category;
  final String description;
  final String previewImageUrl;
  final String downloadUrl;
  final List<String>? tags;
  final List<String>? images;
  final String githubUrl;
  final String? sourceCodeUrl;
  final String? demo;
  final String? startedAt;
  final String? finishedAt;
  final String? duration;

  UIXProject({
    required this.title,
    required this.category,
    required this.description,
    required this.previewImageUrl,
    required this.downloadUrl,
    required this.githubUrl,
    this.tags,
    this.images,
    this.sourceCodeUrl,
    this.demo,
    this.startedAt,
    this.finishedAt,
    this.duration,
  });

  // Optional: JSON support
  factory UIXProject.fromJson(Map<String, dynamic> json) {
    return UIXProject(
      title: json['title'],
      category: json['category'],
      description: json['description'],
      previewImageUrl: json['previewImageUrl'],
      downloadUrl: json['downloadUrl'],
      githubUrl: json['githubUrl'],
      tags: List<String>.from(json['tags'] ?? []),
      images: List<String>.from(json['images'] ?? []),
      sourceCodeUrl: json['sourceCodeUrl'],
      demo: json['demo'],
      startedAt: json['startedAt'],
      finishedAt: json['finishedAt'],
      duration: json['duration'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'category': category,
      'description': description,
      'previewImageUrl': previewImageUrl,
      'downloadUrl': downloadUrl,
      'tags': tags,
      'images': images,
      'githubUrl': githubUrl,
      'sourceCodeUrl': sourceCodeUrl,
      'demo': demo,
      'startedAt': startedAt,
      'finishedAt': finishedAt,
      'duration': duration,
    };
  }
}


