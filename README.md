# Tenant Hub — Flutter Tenant App

A tenant app built for the Flutter take-home assignment. Tenants sign in, see their property and unit, create service requests (maintenance, plumbing, electrical, AC, cleaning) with an optional photo, and track each one through **Pending → Assigned → In Progress → Completed**.

Built with **Clean Architecture** and **Riverpod**, following the conventions of the production app I work on (Ulearna).

📸 Screenshots (English, Arabic/RTL, dark mode): [`docs/screenshots/`](docs/screenshots/)

---

## Getting started

**Requirements:** Flutter 3.29+, and Android Studio or Xcode with an emulator/simulator.

The app has three flavors, so pass one when running:

```bash
flutter run --flavor dev
```

- **Android Studio:** open the project, set **Build flavor** to `dev` in the `main.dart` run configuration, then press ▶ Run.
- **Xcode:** open `ios/Runner.xcworkspace` and pick the `dev` scheme.

**Demo account** (or tap "Use demo account" on the sign-in screen):

| Email | Phone | Password |
|---|---|---|
| `tenant@demo.com` | `0501234567` | `Tenant@123` |

**Run the tests:**

```bash
flutter test
```

### Flavors

| Flavor | App name | Android id | iOS bundle id |
|---|---|---|---|
| `dev` | Tenant Hub Dev | `com.tenantapp.tenant_app.dev` | `com.tenantapp.tenantApp.dev` |
| `stg` | Tenant Hub Stg | `com.tenantapp.tenant_app.stg` | `com.tenantapp.tenantApp.stg` |
| `prod` | Tenant Hub | `com.tenantapp.tenant_app` | `com.tenantapp.tenantApp` |

### Scripts (optional)

```bash
./scripts/generate.sh       # regenerate code after changing a model, API client or form
./scripts/clean_up.sh       # flutter clean + pub get + generate
./scripts/project_setup.sh  # re-apply flavor configuration
```

Generated files are committed, so none of these are needed to run the app.

---

## Features

**Required**

- **Login:** email or phone number + password, with validation. Authentication is mocked, and the session survives app restarts.
- **Home:** tenant name, property and unit; quick access to the 5 service types; the 3 most recent requests.
- **Create request:** service type, description, preferred date, urgent yes/no, optional photo (camera or gallery). After submitting, a confirmation screen shows the request number and the request appears in the list.
- **Requests list:** type, date, status and urgent badge, with status filters, pull-to-refresh, and tap to open details.
- **Request details:** every field, the attached photo (tap to zoom) and a progress timeline.
- **Loading, empty and error states** on every screen.

**Extras**

- **Offline support:** requests are cached locally; when offline, cached data stays visible with a banner. *Profile → Simulate offline mode* lets you try it.
- **Arabic + RTL**, and **light/dark theme**, switchable in Profile.
- **Platform-aware UI:** native iOS date picker, dialogs and swipe-back.
- **Responsive:** bottom navigation on phones, a navigation rail on tablets and in landscape.
- **56 unit and widget tests**, covering notifiers, the repository, the network layer and key widgets.

---

## Architecture

Each feature has three layers, **data → domain → presentation**:

- **Domain:** repository interfaces.
- **Data:** models, remote and local data sources, and repository implementations. Every call returns `Either<Failure, T>`, and errors are mapped to failures in one place (`BaseRepositoryImpl`).
- **Presentation:** Riverpod notifiers with explicit `Loading / Successful / Failure` states, and screens that render each state.

```text
lib/
├── core/        # shared data, domain, widgets, theme, l10n, routing
└── features/
    ├── auth/
    ├── home/
    ├── service_requests/
    └── profile/
```

**Main packages:** Riverpod, go_router, Dio + Retrofit, freezed + json_serializable, reactive_forms (+ generator), Hive, flutter_secure_storage, dartz.

**Mock backend.** There is no real API, but the app still goes through real HTTP calls (Retrofit → Dio). A Dio interceptor answers them locally with realistic responses, delays, error codes and offline failures. To use a real backend, remove that interceptor in `dioProvider`.

**Trade-offs**

- Data models are shared across layers instead of separate domain entities, to keep a small app free of mapping code.
- Status changes come from the server, so new requests stay *Pending* with the mock API; the sample requests show the other statuses.
- Out of scope: Firebase, push notifications, CI.

---

## AI-assisted development

**Tool:** Claude Code (Anthropic), used as a coding assistant.

**How I used it**

I made the decisions and the assistant helped me deliver them faster. I set the architecture and conventions from the production app I work on (Ulearna), chose the stack (Riverpod, go_router, freezed, Retrofit, build flavors) and decided the scope of each change. I then asked the assistant to help with specific tasks:

- Repetitive code: models, notifier states, form inputs, the Retrofit and mock-backend setup
- First drafts of tests and Arabic translations, which I then reviewed
- Checking the app against the assignment brief and suggesting fixes
- Drafting this README

**What I did and reviewed myself**

- **Architecture and conventions:** I brought over the structure, naming, scripts and build flavors from the production app I work on, so the project reads like a real codebase rather than a demo.
- **Technical decisions:**
  - Flavors are required: there's no silent default, so every build states its environment.
  - The original iOS scheme is kept, as in our production project.
  - Generated code is committed, so the project runs right after cloning.
  - Mocking happens at the HTTP level (a Dio interceptor) instead of with fake data sources, so the real Retrofit and Dio path is used everywhere.
  - Freezed, Retrofit, `BaseResponse` and generated forms follow the same patterns as our production app.
- **Hand fixes:**
  - I resolved a widget name clash between `reactive_forms` and the app's own `ReactiveSwitchListTile`.
  - I set up the demo tenant data.
  - I spotted that an old signed-in session kept showing outdated profile data, and traced it to the cached user.
- **Review and prioritisation:**
  - I checked the app against the assignment brief and decided which issues to fix first: the logout and attachment edge cases, the RTL arrow, and the filter after submitting.
  - I chose which design improvements to keep: the quick-services layout, the shrinking FAB and the confirmation screen.
- **Verification:**
  - I reviewed every change before committing it.
  - I checked each flow on the iOS simulator, in English, Arabic and dark mode.
  - I kept the analyzer clean and the test suite passing.

I understand every part of the code and can explain or change any of it.
