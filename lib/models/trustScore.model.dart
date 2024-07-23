class TrustScore {
  final int trustScore;

  TrustScore({required this.trustScore});

  factory TrustScore.fromJson(List<int> json) {
    var listNumber = json as List;
    print(listNumber);
    return TrustScore(trustScore: listNumber[0]);
  }
  Map<String, dynamic> toJson() => {'trust_score': trustScore};
}
