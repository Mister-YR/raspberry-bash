#!/bin/bash

# Define the two floating-point variables
float_var1=3.5
float_var2=2.0

# Check if float_var1 is greater than float_var2
if (( $(echo "$float_var1 > $float_var2" | bc -l) )); then
    echo "float_var1 is greater than float_var2. Shutting down..."
    sudo shutdown -h now
else
    echo "float_var1 is not greater than float_var2. No action taken."
fi