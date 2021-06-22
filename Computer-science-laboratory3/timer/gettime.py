import serial
import time

ser = serial.Serial('/dev/ttyACM0', 9600, timeout=0.1)
time.sleep(2)
String_data = ser.read()
print(String_data)
int_data = int.from_bytes(String_data , 'big')

ser.close()