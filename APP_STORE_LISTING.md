# App Store Connect — listing copy

Draft copy for the WhalePi iOS submission. Edit freely; the character
limits in each heading are Apple's hard caps.

---

## App Name (30 chars max)

```
WhalePi
```

Fallback if `WhalePi` is already taken on the store:

```
WhalePi BLE Terminal
```

## Subtitle (30 chars max)

```
Acoustic recorder companion
```

Alternatives:

- `BLE terminal for WhalePi` (24)
- `Control your acoustic logger` (28)

## Promotional Text (170 chars max, editable without review)

```
Connect to your WhalePi passive acoustic recorder over Bluetooth. Check
recording status, audio levels, GPS and temperature, and start or stop
recording from your phone.
```

## Description (4000 chars max)

```
WhalePi is the companion app for WhalePi passive acoustic recording
devices — Raspberry Pi based hydrophone recorders used to monitor
whales, dolphins and other underwater sound.

Connect to a nearby WhalePi over Bluetooth Low Energy to check on a
deployment without opening the enclosure or carrying a laptop into the
field.

SUMMARY DASHBOARD

See the state of the recorder at a glance:

• Recording status — whether PAMGuard is currently running
• Audio levels — live input levels from the hydrophone
• GPS — position and fix status
• System temperature — Raspberry Pi core temperature
• Database activity — write counts and failure counts

TERMINAL

A full command interface for anyone who wants the raw connection:

• Send commands directly and read the device's replies
• Timestamped, scrollable message history
• HEX mode for byte-level inspection
• Configurable line endings (CR, LF, CR+LF, or none)
• Built-in commands: ping, status, summary, start, stop

DEVICE DISCOVERY

• Scans for nearby Bluetooth Low Energy devices
• Works with the Nordic UART Service, HM-10 modules, and other
  compatible BLE UART profiles
• Live connection status so you know where you stand

DESIGNED FOR FIELDWORK

The interface uses a high-contrast terminal style that stays readable
on deck and in bright sun. Everything runs locally over Bluetooth — no
account, no network connection, and no data leaves your phone.

TRY IT WITHOUT HARDWARE

Tap the flask icon on the device list to enable Test Mode and connect
to the built-in "WhalePi Simulator". It generates realistic status data
so you can explore the full interface before you have a device in hand.

REQUIREMENTS

WhalePi recording hardware is required for real use. Learn more about
building or running a WhalePi at:
https://github.com/WhalePi/install_whalepi
```

## Keywords (100 chars max, comma-separated, no spaces after commas)

```
bluetooth,BLE,hydrophone,acoustic,marine,whale,dolphin,PAMGuard,raspberry,recorder,terminal,UART
```

That is 96 characters. Do not repeat the app name or subtitle words —
Apple already indexes those, so repeating them wastes the budget.

## Support URL (required)

```
https://github.com/WhalePi/install_whalepi
```

## Marketing URL (optional)

Leave blank, or point at a project page if you have one.

## Privacy Policy URL (required)

You need a reachable page. Minimum viable text, hosted anywhere
(GitHub Pages, a repo file rendered on github.com, a personal site):

```
WhalePi Privacy Policy

WhalePi does not collect, store, or transmit any personal data.

The app communicates only with WhalePi recording hardware over a direct
Bluetooth Low Energy connection. It has no account system, no analytics,
no advertising, and no network or server component. Data read from a
connected device stays on your phone and is not saved after the app is
closed.

Bluetooth access is used solely to discover and connect to WhalePi
devices.

Contact: <your email>
Last updated: <date>
```

---

# App Review Notes

Apple asked for seven specific items after the first submission. The block
below answers all of them and is meant to be pasted into **App Review
Information -> Notes** in App Store Connect.

Two things must be filled in before pasting, marked `[[ ]]` in the text:
the screen recording link and the tested-device list. Do not leave the
placeholders in.

```
WhalePi is a companion app for WhalePi passive acoustic recording devices:
open-source Raspberry Pi based underwater sound recorders used in marine
mammal research. The app connects to that hardware over Bluetooth Low
Energy to show recorder status and send commands.

NO HARDWARE IS NEEDED TO REVIEW THIS APP. A full simulator is built in.
See section 4 for the exact steps.

--------------------------------------------------------------------
1. SCREEN RECORDING
--------------------------------------------------------------------

A screen recording captured on a physical iPhone running the current iOS
is provided here: [[ RECORDING LINK ]]

It starts from app launch and shows the typical flow: the device list,
enabling the built-in Test Mode, connecting to the simulated device, the
Summary dashboard, and the Terminal sending commands and receiving
replies.

Regarding the specific flows Apple listed:

- Account registration, login, account deletion: NONE. The app has no
  account system of any kind. There is nothing to register, log into, or
  delete.
- Paid content, purchases, subscriptions: NONE. The app is free, contains
  no in-app purchases, no subscriptions, and no paid tiers.
- User-generated content: NONE. Users cannot create, upload, post, or
  share content. There is no social feature, so reporting and blocking
  mechanisms do not apply.
- Prompts for sensitive data or device capabilities: ONE. On first scan
  iOS shows the standard Bluetooth permission prompt. This appears in the
  recording. The app requests no other permission on iOS: no location, no
  contacts, no camera, no microphone, and no App Tracking Transparency
  prompt, because the app does no tracking and no advertising.

--------------------------------------------------------------------
2. DEVICES AND OPERATING SYSTEMS TESTED
--------------------------------------------------------------------

[[ CONFIRM AND EXTEND THIS LIST BEFORE SUBMITTING ]]

Physical devices:
- iPhone 17e, iOS 26.5.2 (release build installed and run)

Simulators:
- iPhone 17 Pro Max, iOS 26
- iPad Pro 13-inch (M5), iOS 26

Minimum supported OS is iOS 15.0.

--------------------------------------------------------------------
3. FUNCTION, AUDIENCE, AND VALUE
--------------------------------------------------------------------

What it does: displays the live status of a WhalePi acoustic recorder and
lets the user send commands to it over a direct Bluetooth connection.
Status includes whether recording is running, per-channel audio levels,
GPS position and fix, the current recording file name and size, free disk
space, database write counts, and Raspberry Pi core temperature.

Who it is for: marine biologists, bioacousticians, conservation staff, and
citizen-science volunteers who deploy WhalePi hydrophone recorders to
monitor whales, dolphins, and other underwater sound.

The problem it solves: these recorders are deployed in the field, often on
boats or at remote coastal sites, sealed in waterproof enclosures. Before
this app, checking whether a unit was recording correctly meant opening
the enclosure and connecting a laptop, which risks water ingress and is
impractical on a moving boat. The app makes that check a phone in a
pocket, with the enclosure left sealed.

--------------------------------------------------------------------
4. SETUP AND ACCESS TO MAIN FEATURES
--------------------------------------------------------------------

No login credentials exist or are needed. No sample files are needed.

To review every feature without WhalePi hardware:

1. Launch the app. The device list screen appears.
2. Tap the flask icon in the top right of the navigation bar. A yellow
   "TEST" badge appears in the title and a message confirms
   "Test mode enabled - connect to WhalePi Simulator".
3. Tap the "WhalePi Simulator" entry now shown in the device list.
4. The app connects and both tabs become usable:
   - SUMMARY tab: a live dashboard with generated audio levels, GPS
     position, recorder state, temperature, and database activity.
   - TERMINAL tab: type a command and tap SEND. Try: status, summary,
     start, stop, ping. The simulator replies exactly as real hardware
     does.

Test Mode needs no Bluetooth permission and works with Bluetooth switched
off entirely, so it can be reviewed on any device in any state.

--------------------------------------------------------------------
5. EXTERNAL SERVICES, TOOLS, AND PLATFORMS
--------------------------------------------------------------------

NONE. The app has no network component whatsoever.

It makes no HTTP requests, opens no sockets, and contacts no server. There
is no data provider, no authentication service, no payment processor, no
analytics or crash reporting SDK, no advertising SDK, and no AI or machine
learning service.

The only external communication is a direct Bluetooth Low Energy link to
the user's own WhalePi hardware, using the Nordic UART Service profile.

The app is built with Flutter and uses two open-source packages:
- flutter_blue_plus (Bluetooth Low Energy transport)
- permission_handler (runtime permission requests)

Neither transmits data off the device.

--------------------------------------------------------------------
6. REGIONAL DIFFERENCES
--------------------------------------------------------------------

There are none. The app behaves identically in every region and territory.

There is no geo-gating, no region-specific content, no region-specific
pricing, and no server that could vary by region. The interface is English
only. All function depends solely on the presence of the user's own
Bluetooth hardware, which is region independent.

--------------------------------------------------------------------
7. REGULATED INDUSTRY AND THIRD-PARTY MATERIAL
--------------------------------------------------------------------

The app does not operate in a regulated industry. It is a hardware
companion utility for scientific recording equipment. It provides no
medical, financial, legal, gambling, or health service, and it makes no
regulated claims.

It contains no protected third-party material. All artwork and interface
elements are original to this project. The app does not bundle,
redistribute, or embed PAMGuard or any other third-party application; it
sends text commands to hardware the user already owns and operates, and
displays the replies.

WhalePi hardware and its software are open source:
https://github.com/WhalePi/install_whalepi

No licence, credential, or authorisation from a third party is required to
provide the functionality in this app.
```

---

# Producing the screen recording (item 1)

Apple wants this captured on a physical device, so it cannot be recorded
from a simulator. Use the iPhone you already deploy to.

1. On the iPhone, add Screen Recording to Control Centre if it is not
   there: Settings -> Control Centre -> Screen Recording.
2. Force-quit WhalePi first, so the recording genuinely begins with a cold
   launch. Reviewers look for this.
3. Start the screen recording, then launch the app from the home screen.
4. Walk the flow without rushing, roughly 60 to 90 seconds:
   - the device list appearing, and the Bluetooth permission prompt if it
     has not already been granted (delete and reinstall the app first if
     you want the prompt on camera, which is worth doing since Apple
     asked about permission prompts)
   - tap the flask icon, so the TEST badge appears
   - tap "WhalePi Simulator" to connect
   - the SUMMARY dashboard, pausing on the live values, and scrolling
     down to GPS, temperature, and database
   - the TERMINAL tab: send `status`, then `summary`, letting each reply
     finish
   - toggle HEX mode briefly, then back
5. Stop the recording, then upload it somewhere with a stable public link
   and paste that link into the notes at [[ RECORDING LINK ]].

Do not narrate or edit it. A plain, unhurried capture is what they want.

---

# App Privacy questionnaire

For **App Privacy** in App Store Connect, the answer is:

> **Data Not Collected** — select this for every category.

The app has no analytics, no network calls, and no account system, so
nothing is collected or linked to the user. Answer "No" to data
collection at the first question and the rest of the form closes out.

---

# Screenshots

Required: **6.9-inch iPhone** (1320×2868 or 1290×2796). Apple scales
that set down to other iPhone sizes, so one set is enough unless you
want size-specific art.

If you leave the app marked as universal you also need **13-inch iPad**
(2064×2752). Simplest path if you are not targeting iPad: set the app to
iPhone-only in the target's supported destinations, and the iPad
requirement disappears.

Capture these five, with Test Mode on so the screens have live-looking
data:

1. Summary dashboard, recorder running — the strongest first impression
2. Terminal with a `summary` command and its reply visible
3. Device list mid-scan, showing discovered devices
4. Terminal in HEX mode
5. Summary showing GPS and temperature detail

Grab them from a 6.9-inch simulator (iPhone 17 Pro Max) — screenshots
from a smaller device will be rejected for wrong dimensions.
