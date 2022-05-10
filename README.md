# obs-scripts

Utility scripts for OBS Studio.

## chapter.lua

### Install

Download chapter.lua to an apporpriate location and select it from Tool > Scripts section in OBS Studio.

### How it works?

When a scene is switched during the stream, the scene name and elapsed time is stored in YouTube format.
When you finish streaming, a text file is generated to the specified directory.

The output file will look something like this:

```
00:00 Scene A
01:23 Scene B
02:34 Scene C
```