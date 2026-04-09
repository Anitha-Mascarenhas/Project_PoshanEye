import pandas as pd
import tensorflow as tf
from sklearn.model_selection import train_test_split
from sklearn.preprocessing import LabelEncoder

# Load dataset
data = pd.read_csv("data.csv")
data.columns = data.columns.str.strip().str.lower()

# Create labels using BMI
def classify(row):
    height_m = row['height'] / 100
    bmi = row['weight'] / (height_m ** 2)

    if bmi < 14:
        return "Severe"
    elif bmi < 16:
        return "Moderate"
    else:
        return "Healthy"

data['label'] = data.apply(classify, axis=1)

# Encode labels (text → numbers)
encoder = LabelEncoder()
data['label'] = encoder.fit_transform(data['label'])

# Features
X = data[['weight', 'height', 'age']].values
y = data['label'].values

# Split
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2)

# Build model
model = tf.keras.Sequential([
    tf.keras.layers.Dense(16, activation='relu', input_shape=(3,)),
    tf.keras.layers.Dense(8, activation='relu'),
    tf.keras.layers.Dense(3, activation='softmax')
])

# Compile
model.compile(
    optimizer='adam',
    loss='sparse_categorical_crossentropy',
    metrics=['accuracy']
)

# Train
model.fit(X_train, y_train, epochs=20)

# Evaluate
loss, acc = model.evaluate(X_test, y_test)
print("Accuracy:", acc)

# Save model
model.save("model_tf.keras")

print("TensorFlow model saved!")