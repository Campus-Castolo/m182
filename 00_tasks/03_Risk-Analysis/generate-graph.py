import matplotlib.pyplot as plt
from mpl_toolkits.mplot3d import Axes3D

# ============================
# Risk Data
# ============================
impact =      [5, 3, 4, 5, 5, 4, 4, 3, 3]
severity =    [4, 4, 3, 5, 4, 4, 4, 3, 3]
likelihood =  [5, 4, 4, 4, 3, 3, 4, 3, 4]

labels = list(range(1, 10))  # IDs 1–9

# Calculate Risk Score (simple: Impact × Severity × Likelihood)
risk_scores = [i * s * l for i, s, l in zip(impact, severity, likelihood)]

# ============================
# 3D Plot
# ============================
fig = plt.figure(figsize=(10, 7))
ax = fig.add_subplot(111, projection='3d')

scatter = ax.scatter(
    impact,
    severity,
    likelihood,
    s=100,
    c=risk_scores,
    cmap='viridis'
)

# Add labels to each point
for idx in range(len(labels)):
    ax.text(impact[idx], severity[idx], likelihood[idx], str(labels[idx]), size=10)

# Labels & Title
ax.set_xlabel('Impact (1-5)')
ax.set_ylabel('Severity (1-5)')
ax.set_zlabel('Likelihood (1-5)')
plt.title('3D Risk Matrix Visualization')

# Colorbar showing risk scores
plt.colorbar(scatter, label='Risk Score')

# Save and show
plt.tight_layout()
plt.show()
