String shortText({required String text, required int lengthMax}) {
  if (text.length > lengthMax) {
    String textStranle = "";
    for (int i = 0; i < lengthMax; i++) {
      textStranle += text[i];
    }
    return "$textStranle...";
  }
  return text;
}