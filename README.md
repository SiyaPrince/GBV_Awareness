# 📘 GBV Awareness Platform

A cross-platform **Flutter** application (mobile + web + desktop) designed to:

* Raise awareness about **Gender-Based Violence (GBV)**
* Provide **emergency and support resources**
* Share **educational articles and blogs**
* Display **real-time GBV-related statistics**
* Ethically promote a **support-oriented product/tool**
* Offer a **trauma-informed, safety-first** user experience

This repo contains both a **GBV Awareness App** (emergency/support oriented) and a **GBV Awareness Web Platform** (information hub, dashboard, product module), built on a shared architecture and codebase.

---

## 🚀 Key Features

### 🆘 1. Emergency & Support Features

* **Emergency Contacts / Hotlines**

  * One-tap calling to emergency numbers and GBV helplines
  * Dedicated “Emergency Banner” for critical contacts
* **Support Resources Directory**

  * Shelters, legal aid, healthcare, counseling, NGOs
  * Region-based filtering
  * Categorization by type (hotline, shelter, legal, health, organisation)
* **Quick Exit (Web)**

  * Button that redirects immediately to a neutral site (e.g. Google) for safety

---

### 📚 2. Information Hub (Articles & Blogs)

* Educational content on GBV, rights, safety planning, and support
* Blog and article listing with:

  * Categories and tags
  * Search and filter (where applicable)
* Long-form articles designed with **trauma-informed language** and clear, accessible formatting

---

### 📊 3. Real-Time Dashboard

* Real-time statistics streamed from **Firestore**
* Line and bar charts using **FL Chart**
* KPI cards for quick metric overviews
* Interpretive text & disclaimers to prevent misinterpretation
* Optional region-based views
* Shared chart configuration for consistent styling and behavior

---

### 🛍️ 4. Product & Testimonials Module

* **Product Overview Page**

  * Firestore-backed product details (name, description, pillars, CTA)
* **Features Page**

  * Static curated feature cards describing the app’s capabilities
* **FAQ Page**

  * Firestore-backed frequently asked questions, grouped by category
* **Testimonials Page**

  * Firestore-backed testimonials from practitioners or organisations

---

### 🧱 5. Cross-Platform UX

* Responsive design:

  * **Mobile:** iOS, Android
  * **Web:** Chrome and other major browsers
  * **Desktop:** Experimental support for Windows, macOS, Linux
* Calm, soft color palette and typography suitable for sensitive subject matter
* Consistent design system and reusable components

---

## 🧩 Tech Stack

* **Framework:** Flutter `3.35.0+`
* **Language:** Dart `3.10.0+`
* **Backend / Services:**

  * Firebase (Firestore, optionally Analytics, Hosting)
* **State Management:** `flutter_riverpod` `3.0.3`
* **Routing:** `go_router` `17.0.0`
* **Charts:** `fl_chart` `1.1.1`
* **Networking / Images:** `cached_network_image` `3.3.0`
* **Styling & Assets:**

  * `google_fonts` `6.3.2`
  * `flutter_svg` `2.2.2`
* **Other:** `url_launcher` for external links (planned/optional)

---

## 📁 Project Structure

High-level structure:

```text
lib/
├── main.dart               # Application entry point
├── app_router.dart         # Routing configuration
├── theme/
│   └── app_theme.dart      # Global theming, colors, typography
│
├── common/
│   ├── models/             # Data models (Product, FaqItem, Testimonial, SupportResource, Stats, etc.)
│   ├── services/           # Firestore services & abstractions
│   │   ├── product_service.dart
│   │   ├── firebase_product_service.dart
│   │   ├── support_service.dart
│   │   ├── stats_service.dart
│   │   └── contact_service.dart
│   ├── widgets/            # Reusable UI components
│   │   ├── app_page.dart
│   │   ├── page_section.dart
│   │   ├── primary_button.dart
│   │   ├── feature_card.dart
│   │   ├── personal_card.dart
│   │   ├── emergency_banner.dart
│   │   ├── emergency_contacts.dart
│   │   ├── important_notice.dart
│   │   ├── what_it_does_section.dart
│   │   └── what_its_for_section.dart
│   └── utils/              # Utilities & helpers
│
├── features/
│   ├── home/               # Landing page, hero section, previews
│   ├── about/              # About the platform
│   ├── info/
│   │   ├── blog/           # Blog listing & details
│   │   ├── articles/       # Articles listing & details
│   │   └── dashboard/      # Shared dashboard info components
│   ├── dashboard/
│   │   ├── pages/
│   │   │   └── dashboard_page.dart
│   │   ├── widgets/
│   │   │   ├── dashboard_primary_section.dart
│   │   │   ├── metric_card.dart
│   │   │   ├── metric_line_chart.dart
│   │   │   ├── metric_bar_chart.dart
│   │   │   └── metric_chart_shared.dart
│   │   └── controllers/    # Dashboard controller (if used)
│   │
│   ├── support/            # Support resources listing, filters, contact info
│   │   ├── support_page.dart
│   │   └── widgets/
│   │       ├── support_search_bar.dart
│   │       ├── region_filter.dart
│   │       ├── categorized_resources.dart
│   │       └── support_resource_card.dart
│   │
│   ├── product/            # Product, FAQ, testimonials
│   │   ├── product_overview_page.dart
│   │   ├── product_overview_body.dart
│   │   ├── features_page.dart
│   │   ├── features_body.dart
│   │   ├── faq_page.dart
│   │   ├── faq_body.dart
│   │   ├── testimonials_page.dart
│   │   └── testimonials_body.dart
│   │
│   ├── contact/            # Contact form & submission success
│   └── legal/              # Privacy Policy, Terms of Use
│
└── tools/
    └── seed/
        └── seed_support_resources.dart
```

Assets:

```text
assets/
├── images/                 # App logos, illustrations
└── seed/                   # Firestore seed JSON files
    ├── articles.json
    ├── blogPosts.json
    ├── statistics.json
    ├── faqItems.json
    ├── testimonials.json
    ├── support_resources.json
    ├── messages.json
    ├── products.json
    ├── metrics.json
    └── metricData.json
```

---

## 🗄️ Firestore Collections & Data Models

### 1. `support_resources`

Stores GBV support services.

**Example document:**

```json
{
  "name": "South African National GBV Command Centre",
  "type": "hotline",        // hotline | shelter | legal | health | organisation
  "contact": "0800 428 428",
  "region": "National",
  "hours": "24/7",
  "description": "Emergency hotline for survivors of GBV.",
  "isEmergency": true,
  "url": ""
}
```

Used in the **Support** feature for:

* Region filtering
* Categorized listings (hotline/shelter/etc.)
* One-tap calling and external link buttons

---

### 2. `articles` & `blog_posts`

Educational content and blogs.

**Example schema:**

```json
{
  "title": "Understanding GBV",
  "content": "Full article content…",
  "author": "Author Name",
  "publishedDate": { ".sv": "timestamp" },
  "tags": ["awareness", "support"],
  "category": "Education",
  "imageUrl": "https://example.com/image.png"
}
```

Rendered in **Articles** and **Blog** pages (listing + detail views).

---

### 3. `products`

Describes the GBV support product/hub.

**Model sketch:**

```dart
class Product {
  final String id;
  final String name;
  final String slug;
  final String shortDescription;
  final String longDescription;
  final String? icon;
  final String? heroImageUrl;
  final List<String> pillars;
  final String? ctaLabel;
  final String? ctaUrl;
  final bool isFeatured;
  final int order;
  // ...
}
```

**Example document:**

```json
{
  "name": "GBV Aware Hub",
  "slug": "gbv-aware-hub",
  "shortDescription": "A support-oriented platform for GBV awareness and help.",
  "longDescription": "Full detailed description...",
  "icon": "shield",
  "heroImageUrl": "https://example.com/image.png",
  "pillars": [
    "Learn about GBV",
    "Find safe support resources",
    "Connect with organisations"
  ],
  "ctaLabel": "Learn more",
  "ctaUrl": "/product/faq",
  "isFeatured": true,
  "order": 1
}
```

---

### 4. `faqItems` / `faqs`

Frequently Asked Questions for the product and platform.

```json
{
  "question": "Is my information anonymous?",
  "answer": "We do not collect identifying info unless you explicitly choose to share it.",
  "category": "Safety",     // Optional
  "order": 1,
  "isHighlighted": true
}
```

---

### 5. `testimonials`

Testimonials from users or organisations.

```json
{
  "quote": "The hub helped us structure our GBV response strategy.",
  "name": "Alex M.",
  "role": "Programme Manager",
  "organisation": "Community Org X",
  "avatarUrl": null,
  "order": 1,
  "isFeatured": true,
  "rating": 5
}
```

---

### 6. `stats`, `metrics`, and `metricData`

Used for the **dashboard**.

* `metrics` / `stats` defines **which metrics exist** and how they should be displayed.
* `metricData` contains **time-series points**.

**Metric example:**

```json
{
  "title": "Helpline Calls (Weekly)",
  "shortLabel": "Helpline Calls",
  "chartType": "line",      // line | bar
  "frequency": "weekly",
  "category": "Engagement",
  "interpretationHint": "Higher may suggest increased awareness or distress.",
  "priority": 1,
  "minExpected": 0,
  "maxExpected": 500
}
```

**MetricData example:**

```json
{
  "metricId": "helpline_calls_weekly",
  "timestamp": { ".sv": "timestamp" },
  "value": 123,
  "region": "Gauteng",
  "notes": "Awareness campaign running this week."
}
```

---

### 7. `messages`

Contact form submissions.

```json
{
  "name": "User Name",
  "email": "user@example.com",
  "subject": "Question about support services",
  "message": "Message content...",
  "timestamp": { ".sv": "timestamp" },
  "isRead": false
}
```

---

## 🔥 Seeder Scripts

### Support Resources Seeder

A CLI-like script to populate `support_resources` from JSON:

```bash
flutter run -t tools/seed/seed_support_resources.dart
```

Seeder responsibilities:

* Load `assets/seed/support_resources.json`
* Validate entries
* Avoid invalid/duplicate IDs where possible
* Insert data consistent with `SupportResource` model

Other collections (articles, blogPosts, products, faqItems, testimonials, metrics, metricData) can be seeded similarly with dedicated scripts or manual import.

---

## 🔧 Setup & Installation

### 1️⃣ Prerequisites

* Flutter SDK `3.35.0+`
* Dart `3.10.0+`
* Firebase account & project
* Git

---

### 2️⃣ Clone the Repository

```bash
git clone <repository-url>
cd gbv_awareness
```

---

### 3️⃣ Install Dependencies

```bash
flutter pub get
```

---

### 4️⃣ Firebase Setup

1. Go to the **Firebase Console**

2. Create a new project (e.g. `gbv-awareness`)

3. Enable **Cloud Firestore**

4. (Optional) Enable Analytics & Hosting

5. Use FlutterFire CLI to configure:

   ```bash
   flutterfire configure
   ```

   This generates/updates `lib/firebase_options.dart` and platform configs.

6. Create the Firestore collections listed above (`articles`, `blog_posts`, `stats`, `metrics`, `metricData`, `support_resources`, `products`, `faqItems`/`faqs`, `testimonials`, `messages`).

---

### 5️⃣ Add Assets & Seed Data

In `pubspec.yaml`:

```yaml
flutter:
  assets:
    - assets/images/
    - assets/seed/articles.json
    - assets/seed/blogPosts.json
    - assets/seed/statistics.json
    - assets/seed/faqItems.json
    - assets/seed/testimonials.json
    - assets/seed/support_resources.json
    - assets/seed/messages.json
    - assets/seed/products.json
    - assets/seed/metrics.json
    - assets/seed/metricData.json
```

---

### 6️⃣ Run the App

Mobile:

```bash
flutter run
```

Web (Chrome):

```bash
flutter run -d chrome
```

---

## 🔒 Firestore Security Rules (Example)

**⚠️ Adjust these for production — especially write access and admin checks.**

```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {

    // Articles & blogs: public read, admin write
    match /articles/{document} {
      allow read: if true;
      allow write: if request.auth != null &&
                   request.auth.token.admin == true;
    }

    match /blog_posts/{document} {
      allow read: if true;
      allow write: if request.auth != null &&
                   request.auth.token.admin == true;
    }

    // Support resources: public read, restricted write
    match /support_resources/{document} {
      allow read: if true;
      allow write: if request.auth != null &&
                   request.auth.token.admin == true;
    }

    // Dashboard metrics & data: public read, admin write
    match /metrics/{document} {
      allow read: if true;
      allow write: if request.auth != null &&
                   request.auth.token.admin == true;
    }

    match /metricData/{document} {
      allow read: if true;
      allow write: if request.auth != null &&
                   request.auth.token.admin == true;
    }

    // Product, FAQ, Testimonials: public read, admin write
    match /products/{document} {
      allow read: if true;
      allow write: if request.auth != null &&
                   request.auth.token.admin == true;
    }

    match /faqItems/{document} {
      allow read: if true;
      allow write: if request.auth != null &&
                   request.auth.token.admin == true;
    }

    match /testimonials/{document} {
      allow read: if true;
      allow write: if request.auth != null &&
                   request.auth.token.admin == true;
    }

    // Contact messages: anyone can create, authenticated can manage
    match /messages/{document} {
      allow create: if true;
      allow read, update, delete: if request.auth != null;
    }
  }
}
```

---

## 👩‍💻 Development Workflow & Phases

The project followed a **phase-based workflow**:

1. **Phase 0 – Planning**

   * Architecture, Firestore schema, routes, Git workflow
2. **Phase 1 – Setup**

   * Flutter project, dependencies, Firebase configuration, app shell, routing
3. **Phase 2 – Static Layout**

   * Navigation, header/footer, static pages, Quick Exit button (web)
4. **Phase 3 – Information Hub**

   * Articles/blogs, Firestore integration, search/filter
5. **Phase 4 – Dashboard**

   * Metrics models, chart widgets, Firestore streams, interpretive content
6. **Phase 5 – Product Module**

   * Product, FAQ, testimonials, Firestore-backed UI
7. **Phase 6 – Support & Contact**

   * Support resources, categorisation, contact form, Firestore messages
8. **Phase 7 – Polish & Deployment (Next)**

   * Accessibility, cross-device testing, UI polish, final deployment

---

## 🌿 Code Style & Naming

* **Files:** `snake_case.dart` (e.g. `article_list_page.dart`)
* **Classes:** `PascalCase` (e.g. `ArticleDetailPage`)
* **Variables & Methods:** `camelCase` (e.g. `articleList`, `loadMetrics()`)
* **Constants:** `UPPER_SNAKE_CASE` (e.g. `max_ARTICLES`)

Guidelines:

* Follow Dart & Flutter best practices
* Prefer small, focused widgets and functions
* Use meaningful names and avoid “magic numbers”
* Add comments for non-obvious logic

---

## 🤝 Contributing

### Branch Naming

* Features: `feat/<feature-name>`
* Bug fixes: `fix/<bug-description>`
* Docs: `docs/<topic>`
* Hotfixes: `hotfix/<issue>`

### Suggested Workflow

1. Branch from `main` or `dev`:

   ```bash
   git checkout -b feat/new-feature
   ```
2. Implement, test, and ensure style compliance
3. Commit with clear messages
4. Push and open a Pull Request for review

Example used during development:

* Long-running feature branch (e.g. `mkz`)
* Integrate `dev` into feature branch as needed
* Fast-forward `dev` from feature branch:

  ```bash
  git push origin mkz:dev
  ```

---

## 🆘 Safety & Emergency Notice

This app is **not a replacement** for emergency services.

If you or someone you know is in immediate danger:

* Call your **local emergency number**.
* Use the **emergency contacts** provided in the app.
* Reach out to local **GBV helplines or trusted organisations**.

The platform’s goal is to connect people with **information and resources**, not to provide direct crisis intervention.

---

## 📄 License

This project is currently intended for **educational and awareness purposes**.
Add your chosen license here (e.g. **MIT**, **Apache 2.0**, or **proprietary**), and update the repository’s `LICENSE` file accordingly.

---

**Important:** This application deals with sensitive content. Always prioritize user **safety**, **privacy**, and **accuracy** when configuring, extending, or deploying the system.
