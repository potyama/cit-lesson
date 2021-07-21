import serial
import sqlite3
import datetime
import time
class getData(object):

    def __init__(self):
        self.ser = serial.Serial('/dev/ttyACM1', 9600, timeout=1)
        self.val = 0
        self.start = time.perf_counter()
        self.tmp_time = 0
        self.count = 0

    def get_data(self):
        self.ser.write(bytes('a','utf-8'))
        self.val = self.ser.readline().strip()
        self.val = float(self.val)

        return self.val

    def check(self):
        print("check")
        self.check_time = time.perf_counter()
        for i in range(0, 5):
            val = self.get_data()
            print(val, i)

            if  val < 55:
                self.tmp_time += time.perf_counter() - self.check_time
                print("ok")
                return 1

        self.tmp_time += time.perf_counter() - self.check_time
        return 0

    def ser_close(self):
        self.ser.write(bytes('b','utf-8'))
        self.ser.close()

    def timer(self):
        self.end = time.perf_counter()
        print("timer:\n")
        print(round((self.end-self.start)-self.tmp_time, 2))
        self.time = int(round((self.end-self.start)-self.tmp_time, 2))
        print(self.time)
        return self.time



if __name__ == '__main__':
    data = getData()
    get_time = 0
    dt = datetime.datetime.now()
    date = dt.strftime('%Y年%m月%d日 %H:%M:%S')
    print(date)
    while True:
        try:
            val = data.get_data()

            if(val > 55):
                flag = data.check()

                if not flag:
                    get_time = data.timer()
                    data.ser_close()
                    break

            elif val < 0:
                print("forced termination")
                data.ser.close()
                get_time = data.timer()
                break
            else:
                print("val: {}".format(val))
        except ValueError:
            pass
        except KeyboardInterrupt:
            data.ser.close()
            get_time = data.timer()
            break

    conn = sqlite3.connect("time.db")
    cursor = conn.cursor()

    create_table = """CREATE TABLE IF NOT EXISTS timedata (data TEXT, time INTEGER NOT NULL);"""
    conn.execute(create_table)
    conn.commit()

    insert_data = """INSERT INTO timedata VALUES("{0}",{1});""".format(date, get_time)
    cursor.execute(insert_data)

    conn.commit()

    """
    query = "SELECT * FROM timedata"
    cursor.execute(query)
    result = cursor.fetchall()

    for i in result:
        print(i)
    """

    conn.close()
