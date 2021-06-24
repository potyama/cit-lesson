import serial
import time
class getData(object):

    def __init__(self):
        self.ser = serial.Serial('/dev/ttyACM0', 9600, timeout=1)
        self.val = 0
        self.start = time.perf_counter()


    def get_data(self):
        self.val = self.ser.readline().strip()
        self.val = float(self.val)

        return self.val

    def ser_close(self):
        self.ser_close()

    def timer(self):
        self.end = time.perf_counter()
        print("timer:\n")
        print(self.end-self.start)

if __name__ == '__main__':
    data = getData()
    while True:
        try:
            val = data.get_data()
            if(val < 200):
                data.ser.close()
                data.timer()
                break
            else:
                print("val: {}".format(val))
        except ValueError:
            pass
        except KeyboardInterrupt:
            data.ser.close()
            data.timer()
            break