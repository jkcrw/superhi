; Connect to last Bluetooth device connected
; https://www.reddit.com/r/AutoHotkey/comments/vrlsx8/is_it_possible_for_autohotkey_to_connect_to_a/
; Jak Crow 2022

#NoEnv
SetBatchLines -1
ListLines Off
#SingleInstance force
SetTitleMatchMode RegEx
#InstallKeybdHook
#InstallMouseHook
#Persistent
CoordMode, Mouse, Screen


deviceName := "Airpods Pro"

MsgBox, 0x30, , % "Attempting connection to BT device: " deviceName, 1.5

DllCall("LoadLibrary", "str", "Bthprops.cpl", "ptr")
toggle := toggleOn := 1
VarSetCapacity(BLUETOOTH_DEVICE_SEARCH_PARAMS, 24+A_PtrSize*2, 0)
NumPut(24+A_PtrSize*2, BLUETOOTH_DEVICE_SEARCH_PARAMS, 0, "uint")
NumPut(1, BLUETOOTH_DEVICE_SEARCH_PARAMS, 4, "uint")   ; fReturnAuthenticated
VarSetCapacity(BLUETOOTH_DEVICE_INFO, 560, 0)
NumPut(560, BLUETOOTH_DEVICE_INFO, 0, "uint")
loop
{
    If (A_Index = 1)
    {
        foundDevice := DllCall("Bthprops.cpl\BluetoothFindFirstDevice", "ptr", &BLUETOOTH_DEVICE_SEARCH_PARAMS, "ptr", &BLUETOOTH_DEVICE_INFO, "ptr")
        if !foundDevice
        {
            msgbox No bluetooth devices
            return
        }
    }
    else
    {
        if !DllCall("Bthprops.cpl\BluetoothFindNextDevice", "ptr", foundDevice, "ptr", &BLUETOOTH_DEVICE_INFO)
        {
            msgbox Bluetooth device not found
            break
        }
    }
    if (StrGet(&BLUETOOTH_DEVICE_INFO+64) = deviceName)
    {
        VarSetCapacity(Handsfree, 16)
        DllCall("ole32\CLSIDFromString", "wstr", "{0000111e-0000-1000-8000-00805f9b34fb}", "ptr", &Handsfree)   ; https://www.bluetooth.com/specifications/assigned-numbers/service-discovery/
        VarSetCapacity(AudioSink, 16)
        DllCall("ole32\CLSIDFromString", "wstr", "{0000110b-0000-1000-8000-00805f9b34fb}", "ptr", &AudioSink)
        loop
        {
            hr := DllCall("Bthprops.cpl\BluetoothSetServiceState", "ptr", 0, "ptr", &BLUETOOTH_DEVICE_INFO, "ptr", &Handsfree, "int", toggle)   ; voice
            if (hr = 0)
            {
                if (toggle = toggleOn)
                    break
                toggle := !toggle
            }
            if (hr = 87)
                toggle := !toggle
        }
        loop
        {
            hr := DllCall("Bthprops.cpl\BluetoothSetServiceState", "ptr", 0, "ptr", &BLUETOOTH_DEVICE_INFO, "ptr", &AudioSink, "int", toggle)   ; music
            if (hr = 0)
            {
                if (toggle = toggleOn)
                    break 2
                toggle := !toggle
            }
            if (hr = 87)
                toggle := !toggle
        }
    }
}
DllCall("Bthprops.cpl\BluetoothFindDeviceClose", "ptr", foundDevice)
MsgBox, 0x30, , % "BT Device Connected: " deviceName, 1.5
Return
