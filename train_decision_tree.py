# Preliminary IMU ML model for mid-semester review
# Input: imu_features.csv
# Output: Decision Tree classification results

import pandas as pd
from sklearn.tree import DecisionTreeClassifier, export_text
from sklearn.metrics import accuracy_score, confusion_matrix, classification_report

df = pd.read_csv("imu_features.csv")
features = [c for c in df.columns if c != "label"]

train_parts = []
test_parts = []
for label in ["STEADY", "UNSTEADY"]:
    sub = df[df.label == label].reset_index(drop=True)
    cut = int(len(sub) * 0.70)
    train_parts.append(sub.iloc[:cut])
    test_parts.append(sub.iloc[cut:])

train = pd.concat(train_parts).sample(frac=1, random_state=42)
test = pd.concat(test_parts).sample(frac=1, random_state=42)

model = DecisionTreeClassifier(max_depth=4, min_samples_leaf=3, random_state=42)
model.fit(train[features], train["label"])

pred = model.predict(test[features])

print("Accuracy:", accuracy_score(test["label"], pred))
print("\nConfusion matrix:")
print(confusion_matrix(test["label"], pred, labels=["STEADY","UNSTEADY"]))

print("\nClassification report:")
print(classification_report(test["label"], pred))

print("\nDecision tree:")
print(export_text(model, feature_names=features, max_depth=4))
