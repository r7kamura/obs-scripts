# obs-scripts

[![lint](https://github.com/r7kamura/obs-scripts/actions/workflows/lint.yml/badge.svg)](https://github.com/r7kamura/obs-scripts/actions/workflows/lint.yml)

Utility scripts for OBS Studio.

## chapter.lua

Generate YouTube chapter file according to the switched scenes.

### Install

Download [chapter.lua](https://raw.githubusercontent.com/r7kamura/obs-scripts/main/chapter.lua) and select it from Tool > Scripts section in OBS Studio.

![](images/obs-settings.png)

### How it works?

When a scene is switched during the streaming or recording, the scene name and elapsed time is stored in YouTube format.
When you finish streaming or recording, a text file is generated in the specified directory.

The output file will look something like this:

```
00:00:00 Scene A
01:00:00 Scene B
02:00:00 Scene C
03:40:50 Scene A
```
