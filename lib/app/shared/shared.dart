// Shared barrel file - exports all shared components

// =============================================================================
// LOGIC - Business Logic and State Management
// =============================================================================

// Language Bloc
export 'logic/language_bloc/language_bloc.dart';

// Theme Bloc
export 'logic/theme/theme_bloc.dart';

// Sidebar Bloc
export 'logic/sidebar/sidebar_bloc.dart';

// Navigation Bloc
export 'logic/navigation/navigation_bloc.dart';

// =============================================================================
// PRESENTATION - UI Components and Utilities
// =============================================================================

// Layout Widgets
export 'presentation/widgets/layout/app_layout.dart';
export 'presentation/widgets/layout/home_nav_bar.dart';
export 'presentation/widgets/layout/home_mobile_nav.dart';
export 'presentation/widgets/layout/main_content.dart';
export 'presentation/widgets/layout/side_bar.dart';
export 'presentation/widgets/layout/side_bar_item.dart';

// UI Widgets
export 'presentation/widgets/app_container.dart';
export 'presentation/widgets/app_dropdown_button.dart';
export 'presentation/widgets/app_search_bar.dart';
export 'presentation/widgets/chip.dart';
export 'presentation/widgets/code_highlight.dart';
export 'presentation/widgets/code_preview.dart';
export 'presentation/widgets/code_highlighter2.dart';
export 'presentation/widgets/component_footer.dart';
export 'presentation/widgets/device_frame.dart';
export 'presentation/widgets/device_section_frame.dart';
export 'presentation/widgets/icon.dart';
export 'presentation/widgets/language_button.dart';

// Utilities
export 'presentation/utils/colors.dart';
export 'presentation/utils/icons.dart';
export 'presentation/utils/images.dart';
export 'presentation/utils/lang_util.dart';
export 'presentation/utils/sizing.dart';
export 'presentation/utils/theme.dart';
export 'presentation/utils/util.dart';

// Models
export 'presentation/models/nav_link.dart';

// Helpers
export 'presentation/helpers/observers/bloc_observer.dart';
export 'presentation/helpers/observers/nav_observer.dart';
export 'presentation/helpers/platform/platform.dart';
export 'presentation/helpers/platform/platform_enum.dart';

// =============================================================================
// DATA - Data Models and Enums
// =============================================================================

// Enums
export 'data/enums/component_category_enum.dart';
export 'data/enums/device_type.dart';
export 'data/enums/sub_component_category_enum.dart';
export 'data/enums/supported_platform.dart';
export 'data/enums/theme.dart';

// Models
export 'data/models/code_component.dart';
export 'data/models/component.dart';
