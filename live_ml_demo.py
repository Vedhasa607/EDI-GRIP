
import serial
import time
import pandas as pd
from sklearn.tree import DecisionTreeClassifier

PORT = "COM15"
BAUD = 115200
WINDOW_SIZE = 10

print("Loading ML training data...")

df = pd.read_csv("imu_features.csv")

X = df[["az_range"]]
y = df["label"]

model = DecisionTreeClassifier(
    max_depth=4,
    min_samples_leaf=3,
    random_state=42
)

model.fit(X, y)

print("ML model trained.")
print("Connecting to ESP32 on", PORT)

ser = serial.Serial(PORT, BAUD, timeout=2)

# ESP32 resets when serial connection opens
time.sleep(2)

print("\nSMART GLOVE - LIVE ML DEMO")
print("==========================")
print("Keep the sensor still initially.")
print("Press Ctrl+C to stop.\n")

samples = []

try:
    while True:

        line = ser.readline().decode(
            "utf-8",
            errors="ignore"
        ).strip()

        if not line:
            continue

        # Ignore CSV header
        if line.startswith("ax"):
            continue

        values = line.split(",")

        # Expect 7 values: ax, ay, az, gx, gy, gz, fsr
        if len(values) != 7:
            print("Skipping invalid data:", line)
            continue

        try:
            ax, ay, az, gx, gy, gz = map(float, values[:6])
            fsr = int(values[6])
        except ValueError:
            print("Skipping unreadable data:", line)
            continue

        samples.append({
            "ax": ax,
            "ay": ay,
            "az": az,
            "gx": gx,
            "gy": gy,
            "gz": gz
        })

        if len(samples) >= WINDOW_SIZE:

            window = pd.DataFrame(samples[-WINDOW_SIZE:])

            az_range = (
                window["az"].max()
                - window["az"].min()
            )

            prediction = model.predict(
                pd.DataFrame({"az_range": [az_range]})
            )[0]

            contact = fsr > 300

            if contact and str(prediction).upper() == "UNSTEADY":
                status = "UNSTEADY + CONTACT"
            elif contact:
                status = "STEADY + CONTACT"
            elif str(prediction).upper() == "UNSTEADY":
                status = "MOVING - NO CONTACT"
            else:
                status = "NO CONTACT"

            print(
                f"az_range: {az_range:.4f}"
                f" | FSR: {fsr}"
                f" | ML: {prediction}"
                f" | STATUS: {status}"
            )

            samples = []

except KeyboardInterrupt:
    print("\nDemo stopped.")

finally:
    ser.close()
