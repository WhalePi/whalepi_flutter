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

Paste into **App Review Information → Notes** in App Store Connect.
This is the field that most affects whether a hardware companion app
clears review on the first pass.

```
WhalePi is a companion app for WhalePi passive acoustic recording
devices — open-source Raspberry Pi based underwater sound recorders used
in marine mammal research. The app connects to this hardware over
Bluetooth Low Energy to display recorder status and send commands.

NO HARDWARE IS NEEDED TO REVIEW THIS APP.

A full simulator is built into the app:

1. Launch the app. The device list screen appears.
2. Tap the flask icon in the top-right of the navigation bar.
   A "TEST" badge appears in the title and a confirmation message reads
   "Test mode enabled - connect to WhalePi Simulator".
3. Tap the "WhalePi Simulator" entry that appears in the device list.
4. The app connects to the simulator and both tabs become usable:
   - The Summary tab shows a live dashboard with generated audio levels,
     GPS position, recorder state and system temperature.
   - The Terminal tab accepts commands. Try: status, summary, start, stop.
     The simulator replies exactly as real hardware does.

Test mode requires no Bluetooth permission and works with Bluetooth
turned off, so it can be reviewed on any device including one with
Bluetooth disabled.

BLUETOOTH USAGE

The app requests Bluetooth permission to scan for and connect to nearby
WhalePi devices. This is the app's core function. It does not use
Bluetooth for tracking, beacons, proximity marketing, or any purpose
other than communicating with the user's own recording hardware.

DATA AND ACCOUNTS

There is no account or login. The app has no network component, no
analytics, and no server. Nothing is collected or transmitted.

Project background: https://github.com/WhalePi/install_whalepi
```

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
