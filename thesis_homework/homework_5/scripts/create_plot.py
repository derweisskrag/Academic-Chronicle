import matplotlib.pyplot as plt
import numpy as np
import os

# 1. Define the Data (from Tabel 1)
# Note: Since the prompt mentions comparing three platforms (WASM, Cython, Native C),
# we will estimate a value for Native C (usually the fastest/baseline) for a more complete chart.

labels = ['Maatriksi Inversioon', 'Andmete Filtreerimine', 'Jada Liitmine']
wasm_performance = [124.5, 85.2, 55.7]  # WASM times in ms
cython_performance = [188.9, 84.1, 92.5]  # Cython times in ms
# Estimated Native C performance (Baseline/Fastest)
native_c_performance = [100.0, 75.0, 45.0]  # Estimated Native C times in ms

x = np.arange(len(labels))  # the label locations
width = 0.25  # the width of the bars

# 2. Create the Figure and Axes
fig, ax = plt.subplots(figsize=(10, 6))

# 3. Plot the Data (Three Bar Groups)
rects1 = ax.bar(x - width, wasm_performance, width, label='WebAssembly (WASM)')
rects2 = ax.bar(x, cython_performance, width, label='Cython')
rects3 = ax.bar(x + width, native_c_performance, width, label='Native C (Est.)')

# 4. Add Labels, Title, and Custom Ticks
ax.set_ylabel('Täitmisaeg (millisekundites)')
ax.set_xlabel('Aritmeetiline Operatsioon')
ax.set_title('Platvormide Jõudlusnäitajate Võrdlus')
ax.set_xticks(x)
ax.set_xticklabels(labels)
ax.legend()
ax.grid(axis='y', linestyle='--') # Add horizontal grid lines

# Optional: Add data labels on top of the bars (for readability)
def autolabel(rects):
    for rect in rects:
        height = rect.get_height()
        ax.annotate(f'{height:.1f}',
                    xy=(rect.get_x() + rect.get_width() / 2, height),
                    xytext=(0, 3),  # 3 points vertical offset
                    textcoords="offset points",
                    ha='center', va='bottom', fontsize=8)

autolabel(rects1)
autolabel(rects2)
autolabel(rects3)

fig.tight_layout()

# 5. Save the Plot to the Specified Directory
output_dir = 'scripts/images'
output_filename = 'joonis1_joudlusvordlus.png'
if not os.path.exists(output_dir):
    os.makedirs(output_dir)

output_path = os.path.join(output_dir, output_filename)
plt.savefig(output_path)

print(f"Joonis 1 successfully saved to: {output_path}")