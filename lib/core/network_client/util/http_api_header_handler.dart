abstract class HttpApiHeaderHandler {
  String extractNextPage(String linkHeader);
}

class HttpApiHeaderHandlerImpl implements HttpApiHeaderHandler {
  @override
  String extractNextPage(String linkHeader) {
    if (linkHeader.isEmpty) {
      return "-1";
    }
    // Split the string by comma to separate each link
    List<String> links = linkHeader.split(', ');

    // Iterate through each link to find the 'rel="next"' part
    for (String link in links) {
      if (link.contains('rel="next"')) {
        // Extract the page value from the link
        RegExp pageRegExp = RegExp(r'&page=(\d+)');

        RegExpMatch? match = pageRegExp.firstMatch(link);
        // Convert the matched group to an integer and return it
        if (match != null) {
          return match.group(1)!;
        }
      }
    }

    // If 'rel="next"' is not found, return page -1 (end of paged results reached)
    return "-1";
  }
}
