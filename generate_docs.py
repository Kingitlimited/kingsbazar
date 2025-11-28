#!/usr/bin/env python3
import os
import glob

output = []
output.append('=' * 100)
output.append('KINGSBAZAR - COMPLETE LIB FOLDER DOCUMENTATION')
output.append('=' * 100)
output.append('')

dart_files = sorted(glob.glob('lib/**/*.dart', recursive=True))
output.append(f'Total Files: {len(dart_files)}')
output.append('')

for filepath in dart_files:
    try:
        with open(filepath, 'r', encoding='utf-8', errors='ignore') as f:
            content = f.read()
        
        output.append('=' * 100)
        output.append(f'FILE: {filepath}')
        output.append('=' * 100)
        output.append(content)
        output.append('')
        output.append('')
    except Exception as e:
        output.append(f'ERROR reading {filepath}: {str(e)}')
        output.append('')

with open('LIB_DOCUMENTATION.txt', 'w', encoding='utf-8') as f:
    f.write('\n'.join(output))

print(f'[OK] Created LIB_DOCUMENTATION.txt with {len(dart_files)} files')
