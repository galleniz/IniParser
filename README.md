
# INI Lib
A library to parse INI files.

## Install
- `haxelib git ini https://github.com/MrNiz/IniParser`
## Example Usage

- first obtain a INI with data
```ini
["keys"]
up="UP"
down="DOWN"
["volume"]
master=100
```
- Second parse it in haxe.
```haxe
/**
["keys"]
up="UP"
down="DOWN"
["volume"]
master=100
*/
var myIni = sys.io.File.getContent("config.ini").trim();
/*
{keys=> {up= "UP", down="DOWN"},volume=>{master=>100}}
*/
var map:ini.Ini.INI = ini.Ini.parse(myIni);
```
- For last step use in you Game!
```haxe
// Using Flixel example.

import flixel.FlxSprite;
import flixel.FlxState;

class MyState extends FlxState
{
    override function create():Void
    {
        super.create();
        var myIni = sys.io.File.getContent("character.ini").trim();

        var map:ini.Ini.INI = ini.Ini.parse(myIni);
        var damian = map.get("Damian")
        var sprite = new FlxSprite().loadSprite(damian.get("file"));
    }

}
```
