import RPi.GPIO as GPIO  
import time  
# blinking function  
def buzz(pin):  
    print("Buzzing pin {}".format(pin))
    GPIO.output(pin,GPIO.HIGH)
    time.sleep(1)
    GPIO.output(pin,GPIO.LOW)
    time.sleep(1)
    return
# to use Raspberry Pi board pin numbers
GPIO.setmode(GPIO.BOARD)

def setup(pin):
    print("Setting up pin {}".format(pin))
    # set up GPIO output channel
    GPIO.setup(pin, GPIO.OUT)

for i in range(0,27):
    print("PIN {}".format(i))
    try:
        setup(i)
    except:
        print("Pin {} is invalid".format(i))
        continue
    buzz(i)
#i = 26
#print("PIN {}".format(i))
#try:
#    setup(i)
#except:
#    print("Pin {} is invalid".format(i))
#buzz(i)
#


GPIO.cleanup()
