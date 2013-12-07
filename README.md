Work attendance generator
==============

Work attendance generator is simple ruby command line tool that can be used to generate work attendance for specified month of the year. Default output is csv file with two columns, first column contains date (dd/mm/yyyy), second column contains presence information.

Sample of output:

    01/12/2013,Víkend
    02/12/2013,P
    03/12/2013,P
    04/12/2013,P
    05/12/2013,P
    ...

Second column can contain these values:

    Víkend - this is default value for days of weekend
    P - presence (you were at work)
    SV - holiday
    D - leave
    CH - illness
    NV - compensatory leave
    V - unpaid leave
    SC - business leave
    A - absence
   
Usage
-----

Work attendance can be generated with this command:

```bash
$ ruby attendance_generator.rb
```

This will produce "P" values for all working days and "Víkend" for all days of weekend for current month. Script can be run with everal options. All options all applied only to working days. Option related to day of weekend is overwritten with value "Víkend".

#### `-p`/`--public` option

Public option can be used to specify days of public holidays, e.g.:
```bash
$ ruby attendance_generator.rb -p 1,2
```
This will set value "SV" for first and second day of the month.

#### `-l`/`--leave` option

Leave option can be used to specify days of leave, e.g.:
```bash
$ ruby attendance_generator.rb -l 1,2
```
This will set value "D" for first and second day of the month.

#### `-i`/`--illness` option

Illness option can be used to specify days of illness, e.g.:
```bash
$ ruby attendance_generator.rb -i 1,2
```
This will set value "CH" for first and second day of the month.

#### `-c`/`--compensatory` option

Compensatory option can be used to specify days of compensatory leave, e.g.:
```bash
$ ruby attendance_generator.rb -c 1,2
```
This will set value "NV" for first and second day of the month.

#### `-u`/`--unpaid` option

Unpaid option can be used to specify days of unpaid leave, e.g.:
```bash
$ ruby attendance_generator.rb -u 1,2
```
This will set value "V" for first and second day of the month.

#### `-b`/`--business` option

Business option can be used to specify days of business leave, e.g.:
```bash
$ ruby attendance_generator.rb -b 1,2
```
This will set value "SC" for first and second day of the month.

#### `-a`/`--absence` option

Absence option can be used to specify days of absence, e.g.:
```bash
$ ruby attendance_generator.rb -a 1,2
```
This will set value "A" for first and second day of the month.

#### `-m`/`--month` option

Month option can be used to specify month, which this work attendance will be generated for, e.g.:
```bash
$ ruby attendance_generator.rb -m 1
```
This will generate work attendance for January.

#### `-e`/`--excel` option

To be implemented.

#### `-h`/`--help` option

Help option will show help.










