// test file
package;

import haxe.Json;
import ini.Ini;

class Test
{
    static function main() {
        var map = Ini.parse('
        ["SECTION"]
        papu="e"
        when="b"
        osad="a"
        ');
        var str = Ini.toString(map);
        trace(map.toString());
        trace('\n'+str);
    }
}