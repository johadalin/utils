############################
# Imports

import RPi.GPIO as GPIO
from time import sleep
import sys

#############################
# Config

# Define ON and OFF
ON = True
OFF = False

#################
# Loop variables
#################
# How many steps form the loop 
STEP_COUNT = 8
# How many seconds each step should be
STEP_LENGTH = 0.5


#################
# Pin setup
#################
# to use Raspberry Pi board pin numbers
GPIO.setmode(GPIO.BOARD)


## TODO should probably make these a PIN class/object, with pin number, pattern
## and some setup(), update(), step() methods, and current_step variable

# Define a PIN class
class PIN:
    # Cos i'm a doofus and am mixing my transistors, some like high, some like low :(
    # Set invert=True if this pin is one of the wacky ones

    def __init__(self, pin_number, pattern, invert=False):
        self.pin_number = pin_number
        self.pattern = pattern
        self.inverted = invert
        # Set out GPIO pin up as an OUTPUT
        self.setup()


    # Sets up self.pin_number as a GPIO OUT pin
    def setup(self):
        print("Setting up pin {}".format(self.pin_number))
        # set up GPIO output channel
        GPIO.setup(self.pin_number, GPIO.OUT, initial=self.inverted)
        # If we're an inverted pin, we'll need to flip the pattern
        if self.inverted:
            self.pattern = [not i for i in self.pattern]

    # Sets the pin HIGH or LOW based on the step number
    def update(self, step_number):
        GPIO.output(self.pin_number, self.pattern[step_number])        


########################
######################
#######################

# Buzz patterns
## TODO these could just be built from the binary representation of the pattern?
# i.e. pattern 10 would be 00001010, or OFF, OFF, OFF, OFF, ON, OFF, ON, OFF.
# This could be used for setting pin object patterns e.g. PIN1.pattern(128)
PAT1 = [ON, OFF, ON, OFF, ON, OFF, ON, OFF]
PAT2 = [ON, ON, OFF, OFF, ON, ON, OFF, OFF]
PAT3 = [OFF, ON, OFF, ON, OFF, ON, OFF, ON]
PAT4 = [OFF, OFF, ON, ON, OFF, OFF, ON, ON]


############################
# Functions

# Performs cleanup on ending the program
def tear_down():
    GPIO.cleanup()
    print("Exiting loop")

############################
# Loop

def buzz_loop(step_count, pins):
    current_step = 0
    while True:
        for step in range(step_count):
            for pin in pins:
                pin.update(step)
            sleep(STEP_LENGTH)


############################
# Main entry point!!
try:
    print "setting up Pins"
    pins = [PIN(21, PAT1, False),
            PIN(23, PAT2, True),
            PIN(24, PAT3, False),
            PIN(26, PAT4, True)]

    sleep(1)

    print "Initialise Buzzloop"
    buzz_loop(STEP_COUNT, pins)


except KeyboardInterrupt:
    print "Cleaning up pins"
    tear_down()
    sys.exit()  
