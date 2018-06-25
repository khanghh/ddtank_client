package mark.data{   import flash.events.EventDispatcher;   import road7th.data.DictionaryData;      public class MarkSchemeModel extends EventDispatcher   {                   private var _curScheme:int;            private var _schemCount:int;            private var _schemeData:DictionaryData;            public function MarkSchemeModel() { super(); }
            public function set schemCount(value:int) : void { }
            public function updateScheme(schemeID:int, info:MarkSchemeInfo) : void { }
            public function getSchemeInfo(schemeID:int) : MarkSchemeInfo { return null; }
            public function get getAllSchemeData() : String { return null; }
            public function get schemCount() : int { return 0; }
            public function get curScheme() : int { return 0; }
            public function clearScheme() : void { }
            public function set curScheme(value:int) : void { }
   }}