# 🎮 2D Pixel Art Platformer (Godot 4)

## 📌 Project Overview
This is a high-quality **2D Pixel Art Platformer** developed using the **Godot 4 Engine**.  
The project demonstrates a **scalable game architecture** by separating level data from game logic, allowing for an infinite number of levels to be added with **zero changes** to the core engine code.

---

## 🚀 Key Features

### 🔄 Dynamic Level Loading
- Automatically loads and instantiates `.tscn` level files from a directory  
- Handles cleanup of previous levels efficiently  

### 🔗 Programmatic Signal Connection
- Collectibles (Apples), hazards (Enemies), and level exits are connected at runtime  
- Keeps UI and game state fully synchronized  

### 🎨 Smooth UX Transitions
- Uses Godot's **Tween system**  
- Provides polished fade-in / fade-out transitions between levels  

### 🛡️ Safe Resource Management
- Built-in error handling using `ResourceLoader`  
- Prevents crashes if assets or levels are missing  

### 🏆 Score & Progression System
- Persistent score tracking across levels  
- Automatically ends the game after completing the final level  

---

## 🛠️ Technical Stack

- **Engine:** Godot 4.x  
- **Language:** GDScript  
- **Techniques:**
  - Signals & Slots  
  - Tweens  
  - Scene Instantiation  
  - Resource Management  

---

## ▶️ How to Play

1. Clone the repository:
   ```bash
   git clone (https://github.com/youssefsaber592-netizen/Game-2D.git)
