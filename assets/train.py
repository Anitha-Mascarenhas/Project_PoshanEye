import pandas as pd
from sklearn.model_selection import train_test_split
from sklearn.tree import DecisionTreeClassifier
import joblib

# 🔹 Load dataset (CSV instead of Excel)
data = pd.read_csv("data.csv")

# 🔹 Clean column names
data.columns = data.columns.str.strip().str.lower()

# 🔹 Create labels using BMI
def classify(row):
    try:
        height_m = row['height'] / 100  # cm → meters
        bmi = row['weight'] / (height_m ** 2)

        if bmi < 14:
            return "Severe"
        elif bmi < 16:
            return "Moderate"
        else:
            return "Healthy"
    except:
        return "Unknown"

data['label'] = data.apply(classify, axis=1)

# Remove invalid rows
data = data[data['label'] != "Unknown"]

# 🔹 Features & labels
X = data[['weight', 'height', 'age']]
y = data['label']

# 🔹 Train-test split
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2)

# 🔹 Train model
model = DecisionTreeClassifier()
model.fit(X_train, y_train)

print("Model trained successfully!")

# 🔹 Accuracy
accuracy = model.score(X_test, y_test)
print("Accuracy:", accuracy)

# 🔹 Save model
joblib.dump(model, "model.pkl")

# 🔹 Save labeled dataset
data.to_csv("labeled_data.csv", index=False)

print("Model saved as model.pkl")
print("Labeled dataset saved as labeled_data.csv")