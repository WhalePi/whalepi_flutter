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
devices. The WhalePi recording system is a low-power acoustic, GPS,
depth and temperature recorder that works with a wide range of USB
soundcards, allowing it to record whales, dolphins and porpoises.

The app connects to a nearby WhalePi over Bluetooth Low Energy so you
can check on a deployment without opening the enclosure or carrying a
laptop into the field.

SUMMARY DASHBOARD

See the state of the recorder at a glance:

• Recording status — whether the recorder is currently running
• Audio levels — live input levels from the hydrophone
• GPS — position and fix status
• System temperature — recorder core temperature
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
• Works with standard Bluetooth Low Energy serial (UART) profiles
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
bluetooth,BLE,hydrophone,acoustic,marine,whale,dolphin,bioacoustics,recorder,terminal,UART,logger
```

That is 97 characters. Do not repeat the app name or subtitle words —
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

App Store Connect allows 4000 characters in **App Review Information ->
Notes**. Two versions below.

## Short version (366 chars)

```
WhalePi is a companion app for open-source WhalePi underwater acoustic recorders, connecting over Bluetooth.

No hardware needed to review: on the device list tap the flask icon, then tap "WhalePi Simulator".

No accounts, purchases, user content, tracking, ads or network use. Bluetooth is the only permission.

Recording: [[ LINK ]]
Tested: iPhone 17e, iOS 26.5.2.
```

## Full version (3356 chars, fits the 4000 limit)

Answers all seven of Apple's points. Prefer this one unless something is
forcing a shorter limit: Apple asked for seven specific items, and the
short version above leaves five of them unanswered.

```
WhalePi is a companion app for WhalePi passive acoustic recorders: open-source Raspberry Pi underwater sound recorders used in marine mammal research. It connects over Bluetooth Low Energy to show recorder status and send commands.

1. SCREEN RECORDING
Captured on a physical iPhone, from cold launch: [[ LINK ]]
- Accounts/login/deletion: NONE. No account system exists.
- Purchases/subscriptions: NONE. Free, no IAP.
- User-generated content: NONE. Nothing can be created, posted or shared, so reporting/blocking do not apply.
- Sensitive-data prompts: ONE, the standard Bluetooth prompt, shown in the recording. On iOS the app requests no location, contacts, camera, microphone, or App Tracking Transparency, because it does no tracking or advertising.

2. DEVICES TESTED
[[ CONFIRM/EXTEND ]] Physical: iPhone 17e, iOS 26.5.2. Simulators: iPhone 17 Pro Max and iPad Pro 13-inch (M5), iOS 26. Minimum supported OS is iOS 15.0.

3. FUNCTION AND AUDIENCE
Shows the live state of a WhalePi acoustic recorder and sends it commands: recording status, per-channel audio levels, GPS position and fix, current file name and size, free disk space, database writes, and Pi core temperature.
For marine biologists, bioacousticians, conservation staff and citizen-science volunteers monitoring whales and dolphins.
These recorders sit in sealed waterproof enclosures on boats or remote coasts. Checking one previously meant opening the enclosure and attaching a laptop, risking water ingress and impractical at sea. This app makes that check a phone in a pocket, enclosure sealed.

4. SETUP AND ACCESS
No credentials or sample files are needed; none exist.
1) Launch the app; the device list appears.
2) Tap the flask icon top right. A yellow TEST badge appears and a message confirms test mode.
3) Tap "WhalePi Simulator" in the list.
4) SUMMARY tab shows a live dashboard. TERMINAL tab accepts commands: try status, summary, start, stop, ping. The simulator replies as real hardware does.
Test mode needs no Bluetooth permission and works with Bluetooth switched off.

5. EXTERNAL SERVICES
NONE. No network component whatsoever: no HTTP requests, no sockets, no server, no data provider, no authentication, no payment processor, no analytics or crash reporting, no advertising, no AI service.
The only external communication is a direct Bluetooth link to the user's own hardware over the Nordic UART Service. Built with Flutter using two open-source packages, flutter_blue_plus and permission_handler, neither of which sends data off the device.

6. REGIONAL DIFFERENCES
None. Behaviour is identical in every region: no geo-gating, no region-specific content or pricing, and no server that could vary. English only. Function depends solely on the user's own Bluetooth hardware.

7. REGULATED INDUSTRY / THIRD-PARTY MATERIAL
Not a regulated industry. It is a hardware companion utility for scientific recording equipment, making no medical, financial, legal, gambling or health claims.
No protected third-party material. All artwork and interface elements are original. The app does not bundle or redistribute PAMGuard or any third-party application; it sends text commands to hardware the user owns and displays the replies. WhalePi hardware and software are open source: https://github.com/WhalePi/install_whalepi
No third-party licence or credential is required.
```

Fill in both placeholders before pasting: `[[ LINK ]]` for the screen
recording, and the tested-device list.

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
