---
title: 'Review: ALIX.2D13 router with pfsense'
author: george
layout: post
permalink: /review-alix-2d13-router-with-pfsense/
categories:
  - reviews
tags:
  - alix
  - free software
  - freebsd
  - home router
  - open source
  - pfsense
  - router
---
I recently got my hands on an ALIX.2D13 router board. No more crappy ISP routers for me!

I specifically got an [unassembled kit](http://store.netgate.com/ALIX2D3-2D13-Kit-Black-Unassembled-P172C82.aspx) along with a [miniPCI wireless card kit](http://store.netgate.com/KIT-ALIX-5004MP-DUAL-P190C34.aspx). Almost everything I needed came in the unassembled kit. The only extra items I had to find were some ethernet cables, a console (null modem) cable, and a very cheap [adapter](http://www.amazon.com/Bluecell-American-European-Outlet-Adapter/dp/B008M4LQM2/ref=sr_1_1?ie=UTF8&qid=1378187269&sr=8-1&keywords=american+european+adapter) to convert the pins on the power supply from American to European. Luckily, the power supply that netgate sent me works with 100V-240V input, which means I can use it here, with our European 220V power. Neat!

The most important extra item you will definitely need, if you buy an unassembled kit, is a CF card reader. You need the CF card reader so that you can write the OS image on the blank CF card you will receive with the kit.

[![The powered by FreeBSD sticker was not included.](/wp-content/uploads/2013/09/fyeahbsd-225x300.png)](/wp-content/uploads/2013/09/fyeahbsd.png)

Assembling the physical parts was, as expected, fairly simple. There were no instructions but, as with most electronic equipment, there is only one (usually obviously) correct way to put it together; which means that if it fits, you are doing it right.

There was one odd thing I noticed before starting the assembly. Once you screw the board on the case, it is impossible to remove (or insert) the CF card. If you decide to remove the CF card from an assembled ALIX kit, you need to open the case by removing four screws and then, by removing another four screws, detach the entire board from the case. This could have been solved by cutting out a slot in the case to allow for removal of the CF card. I'm not sure why it hasn't been done. Practically, I don't expect this to be a problem as I don't plan on removing the CF card anytime soon. It's a router. It should reside in some dark corner of my house, routing my internets. I shouldn't need to be tinkering with it after it is set up and "in production". But still, it would have been better if this wasn't an issue.

[![alix overview](/wp-content/uploads/2013/09/alix_overview-300x225.png)](/wp-content/uploads/2013/09/alix_overview.png)
[![cf blocked](/wp-content/uploads/2013/09/cf_blocked-300x225.png)](/wp-content/uploads/2013/09/cf_blocked.png)

Due to the aforementioned issue, I decided to set up pfsense before placing the board inside the case. Just in case&#8230;

Which brings us to pfsense.

There are a few different versions of pfsense which you can download and install. For my purposes, I needed the embedded 4GB version which works best with systems like the ALIX board. Details [here](http://pfsense.org/index.php@option=com_content&task=view&id=43&Itemid=44.html). I downloaded the image, and followed the [pfsense installation guide](http://doc.pfsense.org/index.php/InstallationGuide) to write it to the CF card and boot for the first time. Since the ALIX.2D13 doesn&#8217;t have a graphics output, I had to use my console cable to communicate with the device and do the initial setup. That was as easy as saying:

{% highlight shell %}
$ sudo screen /dev/ttyS0
{% endhighlight %}

And boom! We have a terminal. Pfsense just asks you stuff and you say "yes" or "no" and pfsense takes care of the rest. Soon enough pfsense is on your network with its fancy web interface. Easy stuff. No problem. But alas! here comes the tricky part. And it has nothing to do with pfsense.

In my part of the world (Greece), ISPs give you DSL connections with PPPoE. A DSL connection means that you need a DSL modem to take the signal traveling on the old phone network and make it into something digital. "And what's so tricky about that?" you might ask. "Can't you just get a DSL modem?". Well, I'm glad you asked. Let me tell you. No, you can't really just get a DSL modem. You can get a DSL *modem/router*. But I'm unaware of anyone, at least locally, selling DSL *modems*. The trouble with modem/routers is that they want to do everything and I just want them to do the *modem* part. I don't want them to do routing, dhcp, NAT, wireless and the kitchen sink. Most of all, I don't want them to establish the PPPoE connection. I want *my router* to do all those things. How do we achieve this?

I'm still unclear as to how exactly this works but, apparently, what I need is something referred to as "bridged PPPoE" or "br1483". It seems to me that br1483 refers to [RFC1483](https://www.rfc-editor.org/rfc/rfc1483.txt), but after briefly skimming through RFC1483 I still don't understand exactly what it's about. Bellow are the settings I used on my ADSL modem/router:

[![adsl modem/router](/wp-content/uploads/2013/09/adsl-300x165.png)](/wp-content/uploads/2013/09/adsl.png)  
This is from the web interface of a netis DL-4302 DSL modem/router


Finally, after tinkering all day with 3 different modem/routers, the settings above worked. Ι went into pfsense, configured my WAN interface to connect to PPPoE and I was online.  
[![interface details](/wp-content/uploads/2013/09/interface_details-300x291.png)](/wp-content/uploads/2013/09/interface_details.png)
[![nterfaces](/wp-content/uploads/2013/09/interfaces-300x110.png)](/wp-content/uploads/2013/09/interfaces.png)


I've been online with pfsense for only a few days now. I've set up all the very basic configurations such as choosing IP networks for my interfaces, making DHCP static mappings for my own computers and the printer, forwarding certain ports, testing bandwidth with iperf etc. So far everything has been working great. But these are only the basics. Pfsense offers a lot more functionality and I'm curious to see how much I can get out of the ALIX board before it starts being unreliable. In any case though, I'm just happy that I finally own my network.

