![Banner](https://github.com/user-attachments/assets/d7a5cb80-2d45-495d-9f17-c9ec1eae461c)

# Autocut charging MYTH <br />
## By: Kanagawa Yamada

# ONLY SUPPORTS DEVICES THAT SUPPORT BYPASS CHARGING

Wanna learn how to modify and compile this?

1. Download the source (Inside the source folder, there is acut64.s)
2. Modify the code (It's assembly)
3. Compile the code on termux

### How to setup and compile on termux?

1. Setup storage
```
termux-setup-storage
```

2. Install clang & make
```
pkg install clang make
```

3. Compile the code 
```
clang acut64.s -o acut64
```

4. Verify the code
```
ldd (compiled code)
```
It should be like this
![photo_2025-01-09_22-51-23](https://github.com/user-attachments/assets/cdceff77-2f35-411d-a384-da62a736996d)

5. Just make your own version

Q: What's the different between normal autocut and this one? <br />
YMD: This use bypass charging feature
