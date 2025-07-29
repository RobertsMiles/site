<title>Miles' Site</title>

[Home](./index.html) [Guides](./guides.html) [Music](./music.html)

---

# My Guides

This is where I will post my guides and whatever else I feel like talking about. Everything is proudly written by me—no LLMs necessary! (yes, that is my own em-dash)

If you find any inaccuracies, please let me know!

---

## Reject Spotify: A Guide to Self-Hosted Music<br><sup><sup>Posted: 28 July 2025</sup></sup><br><sup><sup>Updated: 28 July 2025</sup></sup>

This guide will teach you how to use how to use a few simple command line utilities to amass your very own offline music collection!

<details>

<summary>Read More</summary>

### Overview

We will be using `yt-dlp` and `beet` to download and organize our music. We can either play the collection directly off of our personal computer, or set up a streaming service on our home server! While this guide is primarily written for Linux users, things shouldn't be too different for Windows/Mac users (other than the installation experience).

### Why do this?

#### Ownership

The main reason we might want to do this is for control. With music streaming, you do not own anything! These streaming services have every right to remove music on a whim, for any reason (often as mundane as licensing issues!).

#### Ethics

You might also find yourself disgruntled with Spotify, after their recent debacle with [investing in AI war technologies](https://www.cnbc.com/2025/06/17/spotifys-daniel-ek-leads-investment-in-defense-startup-helsing.html). This has led several notable artists to [leave the platform completely](https://www.theguardian.com/music/2025/jul/26/king-gizzard-and-the-lizard-wizard-join-spotify-exodus-over-arms-industry-link-ntwnfb).

It is also worth noting that [artists do not make much revenue from music streaming](https://www.latimes.com/entertainment-arts/music/story/2021-04-19/spotify-artists-royalty-rate-apple-music), especially smaller artists!

#### Finances

To be clear, I do not condone piracy! After all, the example in this tutorial will be using royalty-free music. And besides, think of the streaming companies' shareholders!

With that being said, this is the exact same process with all music, regardless of copyrights/royalties (don't do it though, I will give you a slap on the wrist!).

If you still *were* to do this, you might argue that [culture should not be behind a paywall](https://www.pcgamer.com/gaming-industry/ultrakill-dev-says-its-fine-to-pirate-his-game-if-you-dont-have-money-to-spare-culture-shouldnt-exist-only-for-those-who-can-afford-it/). It could also serve as a way to demo music before you purchase your own copy (such as CDs or Vinyl).

### Obtaining the Music

#### Physical Media

If you already own physical media of any kind, you are in luck!

If you have CDs, use a computer's CD player to rip the individual files. I would recommend ripping them in the FLAC format, which makes an exact (lossless) copy of the CD, as opposed to lossy formats like MP3 or OPUS. If you do not have much space or are alright with potential losses in quality, then lossy formats will save you a lot of space. If you want a lossy format, [OPUS at 128 KB/s is basically indistinguishable to the human ear](https://wiki.xiph.org/Opus_Recommended_Settings).

Analog media (like vinyl or cassette tapes) are a bit more involved. You will need to play them through their respective devices, but with the output being routed either into your computer's line-in or microphone port (I would only use the microphone port if you do not have a line-in, or do not have an amp/pre-amp). Then, you would use a program such as [audacity](https://github.com/audacity/audacity) to record this playback and save it to a file (again, I would recommend FLAC if you have the space and OPUS at 128 KB/s if you don't). Read [here](https://manual.audacityteam.org/man/sample_workflow_for_tape_digitization.html) for ripping tapes with Audacity and [here](https://manual.audacityteam.org/man/sample_workflow_for_lp_digitization.html) for ripping vinyl with Audacity. For these rips to work with the rest of the tutorial, make sure to split the recordings into individual tracks with their appropriate names.

#### Downloaded Media

If you would like to purchase digital music from artists on the internet, you should check out [Bandcamp](https://bandcamp.com/)!

Otherwise, for music not already in physical possession, we will be using [yt-dlp](https://github.com/yt-dlp/yt-dlp). It is available in most package managers under the name `yt-dlp` (though **be mindful** that outdated versions often **do not work right** when trying to download from Youtube!). You can check if your version is recent by typing the command `yt-dlp --version`, which in my case returned `2025.06.30`. It should also be noted that ffmpeg must be installed for things to work properly. For more detailed installation instructions, see [here](https://liassica.codeberg.page/posts/0001-yt-dlp/).

Now, on Youtube, find the album you would like (in this case we will use [Kevin MacLeod's Polka! Polka! Polka!](https://www.youtube.com/watch?v=eJ6QlglqkYA&list=OLAK5uy_mdJyQFdloubaXxKxDzgmW5455z_lfCgtQ)). Go into the directory you would like this saved, and simply type `yt-dlp -x https://www.youtube.com/watch?v=eJ6QlglqkYA&list=OLAK5uy_mdJyQFdloubaXxKxDzgmW5455z_lfCgtQ` (the `-x` tells the downloader to only save the audio, not the video as well).

Now, if all went well, the tracks are now saved on your computer:

    user@latitude ~/temp> ls
    'Double Polka [eJ6QlglqkYA].opus'
    'Dvorak Polka [GF9CSn3gMnE].opus'
    'Four Beers'\'' Polka [qvhQzHEABGI].opus'
    'Glee Club Polka [oSbS4_J5ujg].opus'
    'Manic Polka [A-bWfr20PRo].opus'
    'No Spam Polka [J52o2NPuI-E].opus'
    'Pixel Peeker Polka - faster [JbspWYbuxgE].opus'
    'Pixel Peeker Polka - slower [mNIxHMYRPRw].opus'
    'Snare Bounce Polka [0uXtpW9wg4A].opus'
    'Spazzmatica Polka [vx2tQgtT1Tc].opus'
    'Super Polka [u1TfN3H2VCA].opus'
    user@latitude ~/temp> 

### Organizing the Music

#### Installing Beets

We may now have the music, but this can quickly become an unorganized mess! Not to mention that when opened in a media player, there is no track ordering, album cover, and other crucial metadata (with the exception of some CD rips)! Luckily, [beets](https://beets.readthedocs.io/) will alleviate all of these problems! It is available with many package managers, with specific installation instructions on their website.

#### Configuring Beets

To configure beets, type `beet config -e`. This is what my config currently looks like:

    directory: /mnt/audio/music
    library: /mnt/audio/music/musiclibrary.db
    import:
        move: yes
        write: yes
    plugins:
        chroma
        fromfilename
        fetchart
        lyrics
    chroma:
        auto: yes
    fetchart:
        auto: yes
    lyrics:
        auto: no
        translate:
	    api_key:
            from_languages: []
            to_language:
        dist_thresh: 0.11
        fallback: null
        force: no
        google_API_key: null
        google_engine_ID: 009217259823014548361:lndtuqkycfu
        print: no
        sources: [lrclib, google, genius, tekstowo]
        synced: no

You should really read the [documentation](https://beets.readthedocs.io/en/stable/guides/main.html) before using this program, but essentially, whenever I import music from any path on my system, this config will have the properly formatted music placed in `/mnt/audio/music`, with the unformatted music being deleted.

#### Installing Chroma

Before we continue, one crucial plugin (also the hardest part) must be installed separately: [chroma](https://beets.readthedocs.io/en/stable/plugins/chroma.html). Chroma will 'listen' to each song and see if it sounds similar to any known songs (called fingerprinting). This is useful when the music being imported is poorly named/tagged, which can often happen with Youtube downloads.

In addition to the chromaprint package you will also need to install an audio decoder. On my Fedora 42 system, I installed the `chromaprint-tools` package and already had ffmpeg installed. Assuming you are using my config, chroma will automatically run when you import new media.

#### Importing Our Music

when running `beet import .` in our download directory, we get the following output:

    user@latitude ~/temp> beet import .

    /home/user/temp (11 items)

      Match (75.4%):
      Kevin MacLeod - Polka! Polka! Polka!
      ≠ album, artist, tracks
      MusicBrainz, Digital Media, 2014, XW, None, None, None
      https://musicbrainz.org/release/4efbe3b0-3eb4-4c0f-93d0-a867ec5b396d
      ≠ Artist:  -> Kevin MacLeod
         ≠ (#0) Double Polka [eJ6QlglqkYA] (3:42) -> (#1) Double Polka (3:42)
         ≠ (#0) Dvorak Polka [GF9CSn3gMnE] (1:45) -> (#2) Dvorak Polka (1:45)
         ≠ (#0) Four Beers' Polka [qvhQzHEABGI] (2:27) -> (#3) Four Beers’ Polka (2:27)
         ≠ (#0) Glee Club Polka [oSbS4_J5ujg] (3:26) -> (#4) Glee Club Polka (3:26)
         ≠ (#0) Manic Polka [A-bWfr20PRo] (3:18) -> (#5) Manic Polka (3:18)
         ≠ (#0) No Spam Polka [J52o2NPuI-E] (3:22) -> (#6) No Spam Polka (3:22)
         ≠ (#0) Pixel Peeker Polka - faster [JbspWYbuxgE] (3:22) -> (#7) Pixel Peeker Polka (faster) (3:22)
         ≠ (#0) Pixel Peeker Polka - slower [mNIxHMYRPRw] (3:48) -> (#8) Pixel Peeker Polka (slower) (3:48)
         ≠ (#0) Snare Bounce Polka [0uXtpW9wg4A] (2:40) -> (#9) Snare Bounce Polka (2:40)
         ≠ (#0) Spazzmatica Polka [vx2tQgtT1Tc] (1:36) -> (#10) Spazzmatica Polka (1:36)
         ≠ (#0) Super Polka [u1TfN3H2VCA] (0:49) -> (#11) Super Polka (0:49)
    ➜ [A]pply, More candidates, Skip, Use as-is, as Tracks, Group albums,
    Enter search, enter Id, aBort? 

Since everything looks correct, we will enter `A` as our response. Now we can see that all of the music is in the specified library directory, organized as ARTIST/ALBUM with consistent naming, metadata, and an album cover!

    user@latitude /m/a/m/Kevin MacLeod> pwd
    /mnt/audio/music/Kevin MacLeod
    user@latitude /m/a/m/Kevin MacLeod> ls Polka!\ Polka!\ Polka!/
    '01 Double Polka.opus'       '07 Pixel Peeker Polka (faster).opus'
    '02 Dvorak Polka.opus'       '08 Pixel Peeker Polka (slower).opus'
    '03 Four Beers’ Polka.opus'  '09 Snare Bounce Polka.opus'
    '04 Glee Club Polka.opus'    '10 Spazzmatica Polka.opus'
    '05 Manic Polka.opus'        '11 Super Polka.opus'
    '06 No Spam Polka.opus'       cover.jpg
    user@latitude /m/a/m/Kevin MacLeod> 

### Enjoying the Music!

* album-oriented music players

### Optional: Streaming the Music

* navidrome

</details>

---
