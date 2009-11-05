#!/bin/bash

ssh -2 -N -f -L 5110:mail.qubeconnect.com:110 ditesh@mail.qubeconnect.com
ssh -2 -N -f -L 5025:mail.qubeconnect.com:25 ditesh@mail.qubeconnect.com
