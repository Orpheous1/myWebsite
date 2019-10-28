Class randomize                       ;Simple randomize class(Yparxei periptwsh na yparxoun hdh built-in sth glwssa aytes oi synarthseis tou class, den 3erw kala AHK etsi tis orizw apo thn arxh)
{
  Sleep(x, y)                         ;creates a Sleep function
  {
    Random, rand, %x%, %y%            ;Uses the Random function to generate a random number between x and y, assigns it to rand
    Sleep %rand%                      ;Sleep for %rand% ms <--- !!!!
  }
  Ticker(x, y)                        ;Generates a random ticker
  {
    Random, ticker, %x%, %y%          ;goto Comments.randomize.Sleep(., .)
    Return, ticker                    ;Returns the ticker
  }
  Char(L)                                                                          ;creates a random String
  {
    Characters := "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890" ;Legal characters. You can add or remove characters. If you include special characters it might break the PuTTY terminal
    CharStr := ""                                                                  ;Initialize Empty string
    Loop % L                                                                       ;Loop over L, appending a character in each iteration. "%" isn't the modulo operator(opws ma8ame ston prog1 gia c++), % forces expression mode for the next variable. These are AHK language quirks, disregard them
    {
      Random, Rand, 1, StrLen(Characters)                                          ;Uses the Random function to generate a random number between 1 and the length of Characters
      CharStr := CharStr . SubStr(Characters, Rand, 1)                             ;Appends a random Character to the generated String
    }
    Return, CharStr                                                                ;Returns randomly generated String
  }
  Num(x, y)                            ;Completely equivalent to randomize.Ticker, you can use that instead, this is just for readability
  {
    Random, randstrlen, %x%, %y%
    Return, randstrlen
  }
}
Mylabel:
s := randomize.Num(1,5)                ;Randomize seed for eagerness. To simulate a real human higher eagerness will make it work faster and end faster, lower will make it work slower but end slower. Average time spent is linearly proportional to seed s.
While 1                                ;Main infinite* Loop
{
  c = 1                                ;Main Loop is running
  d := randomize.Num(1,15*s)           ;Randomize string length
  b := randomize.Char(d)               ;Initialize variable b to a random String
  len := StrLen(b)
  Send %b%                             ;Sends to the keyboard the random string of characters
  Send {BackSpace %len%}               ;Sends to the keyboard BackSpace n times, n = the length of the above string
  a := randomize.Ticker(1, 100000)     ;Generate the Ticker
  if (a > 99300)                       ;Check if the random ticker exceeds a value to break the loop, 7 out of 1000 iterations it breaks the loop in this implementation due to the next line
  {                                    ;The above random variable X follows a geometric distribution with p=1-({breakpoint of a(99300 in the default implementation)})/({second argument to Ticker(100000 in the default implementation)})
    SendRaw, %a%                       ;Send the ticker(optional)
    Send !{F4} + {Enter}               ;Close PuTTY
    c = 0                              ;Main Loop broke as expected
    break                              ;break the loop
  }
                                             ;The expected value (since X ~ Geo(p)) is 1/p. The expected time before breaking is (1/p)*{average time between iterations}. Default implementation assuming s=1 has an average expected time until break : (1/(1-(99300/100000)))*((10000+5)/2) ms = 0.198511905 hours
  randomize.Sleep(5,10000/s)                 ;Sleep a random amount of time to humanify (This is what you'll be averaging over for the above comment). 
}
if (c = 0)                                   ;If the Main loop broke. This is just a failsafe to check while debugging whether the Main loop didn't break as expected
{
  username = your_username                   ;You have to change these. It would be too time consuming to work on an implementation that doesn't store your password in plain-text. Sorry
  password = your_password                   ;This means if you ever share the script, remember to change these back to anything but your credentials
  folder = public_html
  askhsh = fakeaskhsh.html
  randomize.Sleep(14400000, 32800000)        ;Sleep 4-8 hours, next is the sequence to reopen PuTTY
  Send !{F4}                                 ;Closes existing processes if they exist, otherwise sends shut down signal that just gets overwritten on the confirmation query by Windowsbutton+s
  randomize.Sleep(3000,10000)
  Send #s                                    ;This sends a Windowsbutton+s combination, I don't remember if that opens the search window in Windows Vista/7/8/8.1. If not, look into the "Run" command in the AHK language documentation and edit the code to make it backwards compatible with any Windows OS
  randomize.Sleep(3000,10000)                ;These Sleeps don't need to be random, that's your side, not the server's and it has no way of knowing how fast you do these.
  SendRaw PuTTY
  Send {Enter}                               ;Keep them >3seconds or higher though. It depends on how slow your VM/pc is(the slower the higher)
  randomize.Sleep(3000,10000)                ;These alternating sleeps could be done with a wrapper function if AHK didn't suck. To use a wrapper you'd have to build a library transforming AHK into a functional language which is just not worth the effort
  Send !{Tab}                                ;These alt tabs assume you have no other processes in the background. If you do, either comment the alt tabs(this might break things) or close the processes
  randomize.Sleep(3000,10000)
  Send ^a                                    ;Sends Ctrl-a in case you have another host name saved in PuTTY
  SendRaw %username%@pleiades.math.uoi.gr
  randomize.Sleep(3000,10000)
  Send {Enter}
  randomize.Sleep(3000,10000)
  Send !{Tab}                                ;goto comment of the last alt tab
  randomize.Sleep(3000,10000)
  SendRaw %password%
  Send {Enter}
  randomize.Sleep(3000,10000)
  SendRaw cd %folder% && nano %askhsh%      ;if you changed your folder path you need to change the first part or include the fullpath in the folder variable. The second part will create an html file anyway due to nano. The && ensures that it will only run if the cd %folder% command succeeded.
  Send {Enter}
  randomize.Sleep(3000,10000)
  Send {Enter}                              ;Optional
  Goto MyLabel                              ;Restart the Main Loop. Gia ta atoma ths ADE: Goto is generally bad but IN THIS CASE(!!!) it just makes it simpler without extra nested statements. Avoid using Goto if possible.
}
else
{
  MsgBox, Main Loop broke unexpectedly. Error Code 2200.      ;Debugging stuff. This should never appear. Mandatory xkcd: https://xkcd.com/2200/
}
;ma10989: Den 3erw tis texnikes orologies sta ellhnika etsi ta grapsa ola ta agglika.
;PS: This script is probably an insane overkill. If not, the next version will be.
;BUT(!) the system timed out my IP and reset my UU mins on a simpler implementation. I conjecture that the simplest non-random character implementation that wouldn't
;time you out would be one that spams a single character and then delets it for about an hour, then closes PuTTY, waits 8+ hours then reopens it and reinitializes the algorithm.
;PS2: There is a chance my IP timeout was triggered by the main domain(uoi) or the subdomain(math) for staying online too long. If that were the case I can't explain the UU mins resetting though.
;Working on nano/vi in a terminal shell is a pain in the ass. This script exists so you don't have to(Vi is actually really good though. Nano not so much). You still have to code your assignments.
;My suggestion for big projects(oxi tis askhseis pou kanoume sto ma8hma) is coding in Sublime/VSCode/emacs(if you have the time to learn it) and passing your code to the vps with WinSCP. Ultimately it's a matter of personal preference. I like VSCode.


;How to use:
;This is an AHK script. It automates keystrokes. I won't include a compiled executable because you should read the source and understand how it works. (Programatistiko ma8hma kanoume e3allou. Kai ekatsa evala 1 ekatommyrio epe3hghtika comments, katse toulaxiston na ta diabaseis)
;To run the script download AHK (https://autohotkey.com/download/ahk.zip), then extract the standalone AutoHotKeyU64.exe anywhere you want.
;Edit lines 53 and 54 in the code to include your username and password(ayta poy xrhsimopoieis gia na mpeis sto pleiades.math.uoi.gr mesw PuTTY).
;Open PuTTY, login with your username and password and open any file with nano(doesn't matter which, you will only open a buffer, write and remove some stuff and never save it to a file anyway).
;Close every other window but PuTTY(you should close the text editor you're using to read this later).
;Drag and drop this script(UUgrind.ahk) in the AutoHotKeyU64.exe executable you extracted before(syre me to pontiki). You might hear some Windows sounds, that's because the script is sending keystrokes while your cursor did nto click in an environment that's supposed to receive those keystrokes. That's fine.
;Close the text editor you have open reading this(read the rest of this comment before doing so), click anywhere in the PuTTY terminal you opened before and let the script run. You can't use the computer/instance while the script is running.


;I wrote this script with an intention to run it in a virtual machine equipped with win10 scuffed from almost all Windows services. I don't care if it doesn't work in another environment, but it should in most of the latest Windows versions. If it breaks it's probably line 57.
;You can do this legally for free with VirtualBox and an evaluation copy of Windows 10 from Microsoft. The evaluation period will end after this class ends.


;I'm 99% certain that there is a better implementation that gives the same results. I've thought of automating the keystrokes from within the vps instance uoi provides but I don't know how to do that without being able to install any packages.
;I'm also certain this is also possible solely with pure bash code but it would be insanely difficult to implement. You would have to parse the X11 protocol by hand. Good luck with that.
;If you have any ideas or feature requests email me at johngoudouras@gmail.com
;Don't email me to help you set it up. The how to use section is well written.


;MATLAB/Octave code snippet to plot the cdf(A8roistikh synarthsh katanomhs) of the random variable generated in this script:
;From here on forward remove the ; at the start of each line before entering this in MATLAB/Octave. If you remove them from the end too you'll print some pretty big row matrices but it will still work.
;x = [1:0.01:400];          %1 step works just as fine, it just won't be as accurate if you zoom in enough. If on a slow pc/online IDE set x = [1:400];
;y = 100 * geocdf(x,0.007); %p=0.007
;plot(x,y,'-r')
;title('Chance of stopping over time')
;xlabel({'Number of iterations','Each iteration takes 5 ms to 10 sec w/ average 5.0025 sec'})  %this label will be incorrect if you change the time between iterations in line 49
;ylabel('% Chance of stopping in the first n interations')
;%print -dpng 1.png; %Remove the first % at the start of this line(the one before print, not the one before Remove) if you're using an online IDE/compiler