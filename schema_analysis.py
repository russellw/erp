#!/usr/bin/env python3
"""
Schema Analysis Tool for Forward Reference Issues
Analyzes the ERP schema.sql file to identify forward reference problems.
"""

import re
from collections import defaultdict, OrderedDict

def analyze_schema(file_path):
    """Analyze the schema file for forward reference issues."""
    
    with open(file_path, 'r') as f:
        content = f.read()
    
    # Extract all CREATE TABLE statements with their line numbers
    tables = []
    table_pattern = r'^CREATE TABLE (\w+) \('
    
    lines = content.split('\n')
    for i, line in enumerate(lines, 1):
        match = re.match(table_pattern, line)
        if match:
            table_name = match.group(1)
            tables.append((i, table_name))
    
    # Create a mapping of table names to their line numbers
    table_positions = {name: line_num for line_num, name in tables}
    
    # Extract all foreign key references
    references = []
    ref_pattern = r'(\w+)\s+UUID\s+REFERENCES\s+(\w+)\((\w+)\)'
    
    current_table = None
    for i, line in enumerate(lines, 1):
        # Track which table we're currently in
        table_match = re.match(table_pattern, line)
        if table_match:
            current_table = table_match.group(1)
            continue
        
        # Find references in this line
        ref_matches = re.findall(ref_pattern, line)
        for match in ref_matches:
            column_name, referenced_table, referenced_column = match
            if current_table:
                references.append({
                    'line': i,
                    'from_table': current_table,
                    'from_column': column_name,
                    'to_table': referenced_table,
                    'to_column': referenced_column
                })
    
    # Build dependency graph
    dependencies = defaultdict(set)
    for ref in references:
        dependencies[ref['from_table']].add(ref['to_table'])
    
    # Identify forward references
    forward_references = []
    for ref in references:
        from_table = ref['from_table']
        to_table = ref['to_table']
        
        if to_table in table_positions and from_table in table_positions:
            from_line = table_positions[from_table]
            to_line = table_positions[to_table]
            
            if from_line < to_line:
                forward_references.append({
                    'from_table': from_table,
                    'from_line': from_line,
                    'to_table': to_table,
                    'to_line': to_line,
                    'reference_line': ref['line'],
                    'column': ref['from_column']
                })
    
    return {
        'tables': tables,
        'table_positions': table_positions,
        'references': references,
        'dependencies': dict(dependencies),
        'forward_references': forward_references
    }

def topological_sort(dependencies):
    """Perform topological sort to find proper table ordering."""
    # Create a graph with all tables
    all_tables = set()
    for table, deps in dependencies.items():
        all_tables.add(table)
        all_tables.update(deps)
    
    # Initialize in-degree count
    in_degree = {table: 0 for table in all_tables}
    
    # Calculate in-degrees
    for table, deps in dependencies.items():
        for dep in deps:
            if dep in in_degree:
                in_degree[table] += 1
    
    # Queue for tables with no dependencies
    queue = [table for table, degree in in_degree.items() if degree == 0]
    result = []
    
    while queue:
        current = queue.pop(0)
        result.append(current)
        
        # Update in-degrees for dependent tables
        for table, deps in dependencies.items():
            if current in deps:
                in_degree[table] -= 1
                if in_degree[table] == 0:
                    queue.append(table)
    
    return result

def main():
    analysis = analyze_schema('/mnt/c/erp/schema.sql')
    
    print("=== ERP Schema Forward Reference Analysis ===\n")
    
    print(f"Total tables found: {len(analysis['tables'])}")
    print(f"Total foreign key references: {len(analysis['references'])}")
    print(f"Forward references found: {len(analysis['forward_references'])}\n")
    
    if analysis['forward_references']:
        print("=== FORWARD REFERENCE ISSUES ===\n")
        
        # Sort by from_line for easier reading
        sorted_forward_refs = sorted(analysis['forward_references'], key=lambda x: x['from_line'])
        
        for i, fref in enumerate(sorted_forward_refs, 1):
            print(f"{i}. Table '{fref['from_table']}' (line {fref['from_line']}) references")
            print(f"   '{fref['to_table']}' (line {fref['to_line']}) - Forward reference!")
            print(f"   Column: {fref['column']} at line {fref['reference_line']}")
            print(f"   Gap: {fref['to_line'] - fref['from_line']} lines\n")
        
        print("=== MOST CRITICAL FORWARD REFERENCES ===\n")
        
        # Group by referenced table to see which tables are most problematic
        ref_counts = defaultdict(list)
        for fref in analysis['forward_references']:
            ref_counts[fref['to_table']].append(fref)
        
        # Sort by number of forward references to this table
        sorted_refs = sorted(ref_counts.items(), key=lambda x: len(x[1]), reverse=True)
        
        for table, refs in sorted_refs[:10]:  # Top 10 most referenced
            print(f"Table '{table}' is forward-referenced by {len(refs)} tables:")
            for ref in refs:
                print(f"  - {ref['from_table']} (line {ref['from_line']})")
            print()
    
    print("=== DEPENDENCY ANALYSIS ===\n")
    
    # Show tables with most dependencies
    dep_counts = [(table, len(deps)) for table, deps in analysis['dependencies'].items()]
    dep_counts.sort(key=lambda x: x[1], reverse=True)
    
    print("Tables with most dependencies:")
    for table, count in dep_counts[:10]:
        print(f"  {table}: {count} dependencies")
        deps = analysis['dependencies'][table]
        print(f"    Depends on: {', '.join(sorted(deps))}")
        print()
    
    print("=== SUGGESTED TABLE ORDERING ===\n")
    
    try:
        proper_order = topological_sort(analysis['dependencies'])
        print("Suggested table creation order (topologically sorted):")
        for i, table in enumerate(proper_order, 1):
            current_pos = analysis['table_positions'].get(table, 'Unknown')
            print(f"{i:3d}. {table:<30} (currently at line {current_pos})")
        
        print(f"\nTotal tables in suggested order: {len(proper_order)}")
        
        # Show tables that would need to be moved
        print("\n=== TABLES THAT NEED TO BE MOVED ===\n")
        
        current_order = [table for line, table in sorted(analysis['tables'])]
        
        moves_needed = []
        for i, table in enumerate(proper_order):
            try:
                current_index = current_order.index(table)
                if current_index != i:
                    moves_needed.append({
                        'table': table,
                        'current_position': current_index + 1,
                        'suggested_position': i + 1,
                        'current_line': analysis['table_positions'][table]
                    })
            except ValueError:
                pass
        
        if moves_needed:
            print("Tables that need to be repositioned:")
            for move in moves_needed:
                direction = "earlier" if move['suggested_position'] < move['current_position'] else "later"
                print(f"  {move['table']:<30} move {direction}")
                print(f"    Current: position {move['current_position']} (line {move['current_line']})")
                print(f"    Suggested: position {move['suggested_position']}")
                print()
        else:
            print("No tables need to be moved - ordering is already correct!")
            
    except Exception as e:
        print(f"Error in topological sort: {e}")
        print("This might indicate a circular dependency!")

if __name__ == "__main__":
    main()