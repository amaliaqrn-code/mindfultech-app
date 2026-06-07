import os
import re

def fix_file(filepath):
    with open(filepath, 'r', encoding='utf-8') as f:
        content = f.read()
    
    original = content
    
    # Fix homepage imports: 'bloc/homepage_cubit.dart' -> '../bloc/homepage_cubit.dart'
    content = content.replace("import 'bloc/homepage_cubit.dart'", "import '../bloc/homepage_cubit.dart'")
    content = content.replace("import 'bloc/homepage_state.dart'", "import '../bloc/homepage_state.dart'")
    
    # Fix timer imports
    content = content.replace("import '../cubit/timer_cubit.dart'", "import '../bloc/timer_cubit.dart'")
    content = content.replace("import '../cubit/timer_state.dart'", "import '../bloc/timer_state.dart'")
    
    # Fix journey imports
    content = content.replace("presentation/journey/bloc/journey_cubit.dart", "presentation/journey/bloc/journey_cubit.dart")
    content = content.replace("presentation/journey/bloc/journey_state.dart", "presentation/journey/bloc/journey_state.dart")
    
    if content != original:
        with open(filepath, 'w', encoding='utf-8') as f:
            f.write(content)
        print(f"Fixed: {filepath}")

# Fix homepage_page.dart
fix_file('/c/mindfultech_app/lib/presentation/homepage/pages/homepage_page.dart')

# Fix timer_page.dart  
fix_file('/c/mindfultech_app/lib/presentation/timer/pages/timer_page.dart')

# Fix journey_page.dart
fix_file('/c/mindfultech_app/lib/presentation/journey/pages/journey_page.dart')

print("Done fixing imports")
