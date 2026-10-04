# Tenant Hub — Flutter Tenant App

A small tenant application built for the Flutter take-home assignment. Tenants can sign in, see their property and unit, open service requests (maintenance, plumbing, electrical, AC, cleaning) with an optional photo, and track each request through **Pending → Assigned → In Progress → Completed**.

The project follows **Clean Architecture** with **Riverpod** for state management. The folder structure, naming, widgets, theming, localization and error-handling conventions mirror a production codebase I work on (Ulearna), with Riverpod taking the place of Bloc + GetIt.

> 📸 **Screenshots / screen recording:** _add them to `docs/screenshots/` and link here._

---

## Quick start

**Requirements:** Flutter **3.32+** (Dart 3.8), Xcode (for iOS), Android Studio / SDK (for Android).

```bash
git clone <repo-url> tenant_app && cd tenant_app
./scripts/project_setup.sh     # creates ios/ & android/, applies platform config, generates code
flutter run                    # pick an iOS simulator or Android emulator
```

`project_setup.sh` runs `flutter create` for the platform folders, adds the iOS camera/photo permission strings and Arabic localization, adds the Android `INTERNET` permission and `minSdk 24`, and then runs code generation.

**Demo account** (also shown on the sign-in screen with a one-tap "Use demo account"):

| Email | Phone | Password |
|---|---|---|
| `tenant@demo.com` | `0501234567` (or `+971 50 123 4567`) | `Tenant@123` |

### Code generation

Generated files (`*.g.dart`, `*.freezed.dart`, `*.gr.dart`, `*.gform.dart`, `lib/gen/`) are not committed. Regenerate after changing models, routes, forms or translations:

```bash
./scripts/generate.sh
# = flutter pub get && dart run intl_utils:generate && dart run build_runner build --delete-conflicting-outputs
```

### Tests

```bash
flutter test
```

---

## Features

| Requirement | Implementation |
|---|---|
| **Login** (email or phone + password, validation, mocked auth) | Reactive form with `RequiredValidator`, custom `EmailOrPhoneValidator` and min-length. The mock API accepts the demo account by email or phone (local or international format). The token is kept in Keychain/Keystore (`flutter_secure_storage`) and the profile in shared preferences, so the session survives restarts. |
| **Tenant Home** | Greeting card (name, property, unit), quick-access grid for the 5 service types (each pre-selects the type on the form), and recent requests (latest 3, "View all" switches to the Requests tab). |
| **Create Service Request** | Service type chips, description (10–500 chars), preferred date (native iOS wheel / Material calendar, today → +90 days), urgent switch, optional photo (camera or gallery). On success, the request appears in the list and the app lands on the Requests tab. |
| **Service Requests list** | Type, request date, status label, urgent badge, description preview; status filter chips; pull-to-refresh; tap → details. |
| **Request Details** | Type, description, preferred date, status, created date, urgent flag, attached photo (tap for zoomable full screen) and a vertical progress timeline. |
| **Loading / empty / error states** | Shimmer skeletons and adaptive spinners; empty states with call-to-action; a shared `ErrorView` with retry; snackbars for action errors via the `ScreenUtils` mixin; blocking `ScreenLoader` during submits. |

### Bonus points covered

- **Offline handling + local caching.** Request lists are cached in **Hive**. Lists load cache first, then network. When offline, cached data stays on screen with a banner, and details fall back to the cached copy. The connectivity check uses `internet_connection_checker_plus`. In debug builds, *Profile → Developer options → Simulate offline mode* forces every API call to fail, so this can be demoed.
- **Platform-aware UI.**
  - Adaptive page transitions (Cupertino swipe-back on iOS)
  - Adaptive date picker, dialogs, switches, spinners and pull-to-refresh
- **Responsive layout.**
  - Bottom navigation on phones, navigation rail on tablets and landscape
  - Content width capped on large screens; the quick-services grid adapts its columns
  - `.spMin` typography keeps text from ballooning on tablets
  - Text scale is clamped at 1.3×
- **Localization: English and Arabic, with full RTL support.**
  - Directional paddings, alignment and icons
  - Language and theme (light/dark/system) can be switched in Profile and are persisted
- **Unit and widget tests.**
  - Validators
  - Sign-in, list and create notifiers (including cache/offline paths)
  - Repository (exception → failure mapping, attachment flow)
  - Sign-in screen validation and the request card
- **Reusable components:** see `lib/core/presentation/widgets/`.
- **Git history:** small, scoped commits.

---

## Architecture

```text
lib/
├── main.dart                   # bootstrap: configureInjection() → ProviderScope(overrides)
├── injection.dart              # pre-resolved async deps (SharedPreferences, Hive box, docs dir)
├── injectable_module.dart      # third-party providers (secure storage, image picker, logger, …)
├── src/app.dart                # ScreenUtilInit, MaterialApp.router, theme, l10n, ReactiveFormConfig, auth listener
├── core/
│   ├── data/                   # BaseRepositoryImpl, exceptions, constants, NetworkInfo, MockApiClient, LanguageEnum
│   ├── domain/                 # Failure types, ServerErrorCode, BaseRepository, NetworkInfo interface
│   ├── presentation/
│   │   ├── providers/          # app-wide state: auth session, app settings (language/theme)
│   │   ├── routes/             # AppRouter (auto_route) + AuthGuard
│   │   └── widgets/            # Base* buttons, fields, date picker, sheets, dialogs, ErrorView, spacers, mixins…
│   ├── theme/                  # AppColors (ColorScheme), AppStyles (TextTheme), AppDimens, AppRadius, AppTheme
│   └── utils/                  # BuildContext/num/DateTime extensions, form validators, media picker
└── features/
    ├── auth/                   # data (local/remote sources, models, repo impl) · domain · presentation
    ├── service_requests/       # data (Hive cache + mock API) · domain · presentation (3 notifiers, 3 screens)
    ├── home/                   # dashboard tab shell + home tab
    └── profile/                # profile, settings, logout
```

Each feature is split into **data → domain → presentation**.

- **Domain:** the abstract `XRepository`.
- **Data:** `XRemoteDataSource` / `XLocalDataSource` interfaces with `Impl`s, and `XRepositoryImpl extends BaseRepositoryImpl`. Repositories only describe the happy path inside `request()` / `localRequest()`. All try/catch logic and the mapping from exception to `Failure` is centralized there, so every repository returns `Either<Failure, T>` (`dartz`).
- **Presentation:** each Riverpod `Notifier` folds that `Either` into one of its explicit states, `Initial` / `Loading` / `Successful` / `Failure` (a `sealed` class in a `part` file). Screens switch over that state exhaustively.

### Bloc + GetIt → Riverpod mapping

| Bloc / GetIt convention | This project |
|---|---|
| `presentation/blocs/x/x_bloc.dart` + `x_event.dart` + `x_state.dart` | `presentation/providers/x/x_notifier.dart` + `x_state.dart` (`part of`); events become methods |
| `@injectable` screen-scoped bloc | `NotifierProvider.autoDispose` |
| `@factoryParam` + instance-name caching | `NotifierProvider.autoDispose.family` (one instance per id, auto-disposed) |
| `@Singleton()` `AuthBloc` | `authProvider` (`core/presentation/providers/auth`) |
| `@LazySingleton(as: XRepository)` | `final xRepositoryProvider = Provider<XRepository>(…)` declared next to `XRepositoryImpl` |
| `@module` / `@preResolve` | `injectable_module.dart` providers / `configureInjection()` + `ProviderScope.overrides` |
| `BlocListener` / `BlocBuilder(bloc: getIt<…>())` | `ref.listen` / `ref.watch` |
| `MultiBlocProvider(lazy: false)` | shared `NotifierProvider` + an eager fetch in the dashboard |

Riverpod also replaces GetIt as the DI container, so tests just override providers (`ProviderContainer(overrides: […])`) with Mocktail mocks.

### Mock backend

There is no real API. `MockApiClient` plays the role of the Dio/Retrofit client: it adds latency, checks connectivity, and throws `ServerException` (like `DioException`). The service-requests mock server persists its "database" in shared preferences and seeds a few realistic requests on first launch. Switching to a real backend means replacing only the `*RemoteDataSourceImpl` classes with Retrofit `@RestApi` clients.

### Key packages

`flutter_riverpod`, `auto_route`, `freezed` + `json_serializable`, `dartz`, `reactive_forms` (+ generator), `hive`, `shared_preferences`, `flutter_secure_storage`, `image_picker`, `internet_connection_checker_plus`, `flutter_screenutil`, `intl_utils`, `shimmer`, `mocktail`.

---

## Notes and trade-offs

- **Photos** are copied from the picker's temp folder into the app documents folder. Only the **file name** is persisted, and the absolute path is resolved at read time, because iOS changes the app container path between installs and updates.
- **Status progression** is server-driven. With the mock API, new requests stay *Pending*; the seeded requests demonstrate the other states and the timeline.
- **Models double as entities.** As in the reference codebase, data models (freezed) are used across layers instead of separate domain entities, which keeps a small app free of mapping boilerplate.
- **Not included (out of scope):** flavors, Firebase/Crashlytics, push notifications, and CI.

---

## AI-assisted development

> _Complete this section honestly before submitting — it's required by the assignment._

- **Tools used:** _e.g. Claude (Anthropic), GitHub Copilot, …_
- **What they were used for:** _e.g. scaffolding the project structure from my existing house style, generating boilerplate (models, states, widgets), translations, tests and this README._
- **What I reviewed / changed manually:** _e.g. verified the build and ran the app on iOS & Android, fixed X, adjusted UI Y, reviewed architecture decisions, rewrote Z…_
