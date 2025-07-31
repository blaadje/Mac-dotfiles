#Requires AutoHotkey v2.0

arrowMap := Map(
    "n", "Left",    ; n = gauche
    "e", "Down",    ; e = bas
    "i", "Up",      ; i = haut
    "o", "Right"    ; o = droite
)

numberMap := Map(
    "q", "1",
    "w", "2", 
    "f", "3",
    "p", "4",
    "g", "5",
    "j", "6",
    "l", "7",
    "u", "8",
    "y", "9",
    ";", "0"
)

for key, arrow in arrowMap {
    HotIf (*) => GetKeyState("RAlt", "P")
    Hotkey "*" key, MakeHandler(arrow)
}

for key, num in numberMap {
    HotIf (*) => GetKeyState("RAlt", "P")
    Hotkey "*" key, MakeNumberHandler(num)
}
HotIf  ; réinitialise la condition

MakeHandler(arrowKey) {
    return (*) => HandleArrow(arrowKey)
}

MakeNumberHandler(num) {
    return (*) => Send(num)
}

HandleArrow(arrowKey) {
    shift := GetKeyState("Shift", "P")
    lalt := GetKeyState("LAlt", "P")

    if lalt {
        modifiers := shift ? "+!" : "!"
    } else {
        modifiers := shift ? "+" : ""
    }

    Send(modifiers "{" arrowKey "}")
}