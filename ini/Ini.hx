package ini;
using StringTools;

/**
* INI CLASS.
**/

typedef INI = Map<String,Map<String,Dynamic>>;
/**
* A simple parser of INIs for Haxe
* @author MrNiz
**/
class Ini {
    /**
    * You put something in the input (Has Ini file)
    ```ini
    ["SECTION"]
    papu="e"
    when="b"
    dare="a"
    ```
    * output:
    ```
    {SECTION => {when => b,papu => e,osad => a}}
    ```
    * auto detects Booleans and Numbers, in the case of Strings, they are only put without any change.
    *
    * @param rawIni is a INI to parse.
    * @returns `INI/Map`
    **/
    static inline public function parse(rawIni:String):INI {
        var map:INI = new INI();
        rawIni = rawIni.trim().replace("\r","");
        var lines = rawIni.split("\n");
        var curLine:Int = 0;
        var section = "default";
        for (line in lines) {
            curLine += 1;
            var trimmedLine = line.trim();
            if (trimmedLine.startsWith("[") && trimmedLine.endsWith("]")) {
                section = trimmedLine.substring(1, trimmedLine.length - 1).replace('"',"");
                if (section == "") {
                    error(curLine, trimmedLine.length - 1, trimmedLine, "Having an invalid section name.", trimmedLine.length);
                } else if (section.indexOf(" ") >= 0) {
                    error(curLine, section.indexOf(" "), trimmedLine, "Can not have spaces in the Ini file.", section.length - 1);
                }
            } else if (trimmedLine != "") {
                var index = trimmedLine.indexOf("=");
                if (index < 0) {
                    error(curLine, 0, trimmedLine, "Having an invalid character.", trimmedLine.length);
                } else {
                    var name = trimmedLine.substring(0, index).trim();
                    var value = trimmedLine.substring(index + 1).trim().replace('"',"");
                    var mapSec:Map<String,Dynamic> = map.exists(section) ? map.get(section) : new Map();
                    switch(value) {
                        case "false","true":
                            mapSec.set(name, value == "true");
                        default:
                            var hasNum:Float = Std.parseFloat(value);
                            if (Math.isNaN(hasNum)) {
                                mapSec.set(name, value);
                            } else {
                                mapSec.set(name, hasNum);
                            }
                    }
                    map.set(section, mapSec);
                }
            }
        }
        return map;
    }
    /**
    * You put something in the input (Has INI Map)
    ```
    {SECTION => {when => b,papu => e,osad => a}}
    ```
   
    output:
    ```ini
    ["SECTION"]
    papu="e"
    when="b"
    dare="a"
    ```
    * @param input has a `INI/Map`.
    * @return a `String` with the format of Ini.
    **/
    static inline public function toString(input:INI):String {
        var output:String = "";
        for (key in input.keys()) {
            output += '["$key"]\n';
            for (innerKey in input.get(key).keys()) {
                var value = input.get(key).get(innerKey);
                output += '$innerKey="$value"\n';
            }
        }
        return output;
    }

    static function error(inLine:Int,inChar:Int, input:String, error, erLen = 1) {
        var inp =  repeat(input.length - erLen, " ") + repeat(erLen, "v");
        throw '\nAn error occurred parsing in the line ${inLine} at char ${inChar}\n${error}\n${inp}\n${input}\n\nIni Parser.';
    }
   static function repeat(rp:Int, wit) {
        var result = "";
        for (i in 0...rp)
            result +=wit;
        return result;
    }
}