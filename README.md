# Concentration-nation
An exercise in writing a simple concentration game in as many programming languages as I could manage.

When I was in college I wrote a concentration game in Visual Basic 6 for a class assignment (and stored it on a 3 1/2 
inch floppy disk).

Years later, when I had some free time, I tried to recreate the application in **Java**. In my professional career I am most
familiar with **C#** so I did a version in that programming language next. Then **VB.NET**.

I hadn't done any **C++** since college so I tackled that version next. Then I wanted to challenge myself so I created a couple of version in less popular programming languages that I wasn't very familiar with (**F#** and **TCL**). The TCL version was probably the most challenging of all the versions to date.

I decided it was time to re-do the **VB6** version since, by now, the 3 1/2 inch floppy was no good to me. 

Next I did a **Python** version because it seems to be a popular programming language at the moment ([#4 in popularity for the last 2 years](http://spectrum.ieee.org/static/interactive-the-top-programming-languages-2015#index/2015/1/1/1/1/1/50/1/50/1/50/1/30/1/30/1/30/1/20/1/20/1/5/1/5/1/20/1/100/)).

Lastly, I created a [**Javascript/jQuery**](https://dantheman3721.000webhostapp.com/Concentration.html) version so I could have something to put on a web page. It's a stripped down version
compared to most of the rest.

### IMAGE USE

**_NOTE:_** None of the image files used for any of the games have been uploaded with the exception of the Javascript example.
I did leave the **_images_** folders as a place holder. Each game requires at least 8 images. For most of the games I used between 46 and 49 images. I found the images [here](http://www.iconarchive.com/artist/martin-berube.html) and they are free to use. The Javascript example only uses 8 images (a subset of what I used for a couple of the other games). 

I created a Resources.resx for the images in all of the .NET code (C#, VB.NET, C++ and F#) so that, when I compiled the executables, the images were included in the exe and I did not have to include a /images directory with it.

For the Java version I used the ClassLoader to get the image resources.

The TCL and Python versions aren't using images at all. I ran the convertImages.tcl and createBgAndDefault.tcl against the TCL images to create base64 encoded strings and then stored them in files. For Python I ran the img-conversion.py file I wrote to create byte code equivalents of the images that I then stored in files (I couldn't figure out a Resources.resx alternative for either of them and I guess a couple of files that represent the images is better than an entire directory of 46 to 49 images).

For the VB6 version I expanded the form a little and dropped all of the images in an area of the form that I later covered up by making the form smaller.
