# Multi-Stage Fast Charging for a Lithium-Ion Battery Pack

## What this project is about

This project looks at how to charge a lithium-ion battery pack faster and safer.
It compares a normal charging method (CC-CV) with a smarter method called
Multi-Stage Constant Current (MCC). It also tests two ways of cooling the
battery while it charges: air cooling and liquid cooling.

Everything is built and tested using MATLAB, Simulink, and Simscape.

## Why this matters

Charging a battery too fast can make it too hot or push the voltage too high,
which can damage the battery or make it unsafe. This project tries to charge
the battery as fast as possible while staying inside safe limits:

- Voltage never goes above **4.20 V**
- Temperature never goes above **60°C**

## The battery pack

- 4 cells connected in series (one after another)
- Battery type: NMC lithium-ion, 21700 size
- Each cell can hold about 4.8 Ah of charge
- The battery model tracks voltage, current, state of charge (SOC), and
  temperature at the same time

## The two charging methods

### 1. CC-CV (the normal method)
Charges at one constant current, then slowly reduces the current once the
voltage gets close to the limit. This is the standard method used in most
chargers today.

### 2. MCC (the new method, this project's main idea)
Charges in steps. It starts with a high current, and every time the voltage
gets close to the limit, it drops down to a lower current and keeps going.
This lets the battery keep charging faster for longer before it has to slow
down.

**Result:** MCC reached 80% charge about 12.5 minutes faster than CC-CV.

## The two cooling methods

While the battery charges, it heats up. This project tests two ways to cool
it down:

### 1. Air cooling
Uses natural airflow around the battery cells to remove heat.
- Heat transfer coefficient (h): **60 W/(m²·K)**
- Thermal resistance (R): **~3.51 K/W**

### 2. Liquid cooling
Uses a liquid coolant that absorbs heat more effectively than air.
- Heat transfer coefficient (h): **1000 W/(m²·K)**
- Thermal resistance (R): **~0.21 K/W**

**Result:** Liquid cooling kept the battery about 5°C cooler at its hottest
point compared to air cooling.

## How the charging is controlled

The charging logic is built using a state machine (Stateflow) with these
steps:

1. Start charging at the highest current
2. When the voltage hits the limit, wait 20 seconds to make sure it's real
3. Drop to the next lower current and repeat
4. In the final stage, the current is adjusted in small steps to keep the
   voltage right at the safety limit without going over
5. Stop charging once the current is very low or the battery is full enough

## How the cooling is controlled

The cooling system turns on and off automatically based on temperature:

- Turns **ON** when the battery reaches 35°C
- Turns **OFF** once the battery cools down to 30°C

This on/off gap prevents the cooling system from switching too rapidly.

## What was tested

- Charging speed: MCC vs CC-CV
- Battery temperature with no cooling
- Battery temperature with air cooling
- Battery temperature with liquid cooling

## Main results

| Test | Result |
|---|---|
| Time to reach 80% charge (CC-CV) | ~78.9 minutes |
| Time to reach 80% charge (MCC) | ~66.5 minutes |
| Time saved with MCC | ~12.5 minutes |
| Peak temperature (air cooling) | 40.2°C |
| Peak temperature (liquid cooling) | 35.0°C |
| Temperature saved with liquid cooling | ~5°C |

## Tools used

- MATLAB
- Simulink
- Simscape (for the battery and cooling system physics)
- Stateflow (for the charging and cooling control logic)

## Final takeaway

The MCC charging method charges the battery faster than the standard CC-CV
method, without breaking any safety limits. Adding liquid cooling on top of
this keeps the battery noticeably cooler than air cooling, giving extra
safety margin during fast charging.
