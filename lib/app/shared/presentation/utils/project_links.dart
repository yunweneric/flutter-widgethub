/// Canonical links to the project's home on GitHub.
///
/// Every chrome surface that points at the repository — nav bar, sidebar,
/// footers — reads its URL from here, so the repo can move without a
/// grep-and-replace across the app.
class ProjectLinks {
  ProjectLinks._();

  static const String repo = 'https://github.com/yunweneric/flutter-widgethub';
  static const String newIssue = '$repo/issues/new';
  static const String discussions = '$repo/discussions';
  static const String license = '$repo/blob/main/LICENSE';
  static const String contributing = '$repo/blob/main/CONTRIBUTION.md';
  static const String codeOfConduct = '$repo/blob/main/CODE_OF_CONDUCT.md';

  /// Owner and repo, for the GitHub API star count.
  static const String owner = 'yunweneric';
  static const String repoName = 'flutter-widgethub';

  static const String x = 'https://x.com/yunweneric';
  static const String linkedIn = 'https://www.linkedin.com/in/yunweneric';
  static const String tiktok = 'https://www.tiktok.com/@yunweneric';
}
