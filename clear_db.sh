#!/bin/bash

i=0

while [ $i -lt 4 ]; do
rake db:rollback
let i=i+1
done

rake db:migrate
