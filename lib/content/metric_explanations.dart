class MetricExplanations {
  static Map<String, Map<String, String>> get explanations {
    return {
      'cases_per_month': {
        'title': 'Monthly Reported GBV Cases',
        'description':
            'Shows the number of gender-based violence cases reported each month. This helps identify seasonal patterns and measure the effectiveness of awareness campaigns.',
        'interpretation':
            'Look for trends over multiple months rather than focusing on individual data points. Seasonal variations are common, and increases may reflect better reporting systems.',
        'limitations':
            'Represents only reported cases. Many incidents go unreported due to stigma, fear, or lack of access to reporting channels.',
      },
      'cases_by_region': {
        'title': 'GBV Cases by Region',
        'description':
            'Geographical distribution of reported cases helps target resources and support services where they are most needed.',
        'interpretation':
            'Higher numbers may indicate better reporting infrastructure rather than higher incidence rates. Consider population density and service accessibility.',
        'limitations':
            'Reporting completeness varies by region. Some areas have stronger support systems that encourage reporting.',
      },
      'cases_by_type': {
        'title': 'Types of Violence Reported',
        'description':
            'Breakdown of different forms of gender-based violence to understand patterns and specific support needs.',
        'interpretation':
            'Each category requires different intervention approaches. Many survivors experience multiple forms of violence simultaneously.',
        'limitations':
            'Categorization can vary, and many cases involve overlapping types of violence.',
      },
      'reporting_trends': {
        'title': 'Reporting Trends Over Time',
        'description':
            'Shows changes in reporting behavior, which can indicate growing awareness or trust in support systems.',
        'interpretation':
            'Increasing trends often reflect successful awareness campaigns and improved trust in support services.',
        'limitations':
            'Many factors influence reporting rates beyond actual incidence levels.',
      },
      'support_usage': {
        'title': 'Support Service Usage',
        'description':
            'Shows how many people are accessing different types of support services.',
        'interpretation':
            'Increased usage indicates growing awareness and trust in available support systems.',
        'limitations':
            'Does not capture unmet needs or barriers to accessing services.',
      },
    };
  }

  static String getMetricTitle(String metricKey) {
    return explanations[metricKey]?['title'] ?? 'GBV Statistics';
  }

  static String getMetricDescription(String metricKey) {
    return explanations[metricKey]?['description'] ??
        'This chart shows important trends and patterns in gender-based violence data.';
  }

  static String getMetricInterpretation(String metricKey) {
    return explanations[metricKey]?['interpretation'] ??
        'Focus on long-term trends rather than individual data points.';
  }
}
