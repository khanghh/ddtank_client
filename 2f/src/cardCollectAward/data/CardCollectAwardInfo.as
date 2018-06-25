package cardCollectAward.data{   import road7th.data.DictionaryData;      public class CardCollectAwardInfo   {                   private var _title:String;            private var _desc:String;            private var _minLv:int;            private var _quertions:String;            private var _beginTime:Date;            private var _endTime:Date;            private var _qq:String;            private var _phone:String;            private var _awardData:DictionaryData;            public function CardCollectAwardInfo() { super(); }
            public function get awardData() : DictionaryData { return null; }
            public function get phone() : String { return null; }
            public function set phone(value:String) : void { }
            public function get qq() : String { return null; }
            public function set qq(value:String) : void { }
            public function get endTime() : Date { return null; }
            public function set endTime(value:Date) : void { }
            public function get beginTime() : Date { return null; }
            public function set beginTime(value:Date) : void { }
            public function get quertions() : String { return null; }
            public function set quertions(value:String) : void { }
            public function getQuertionByIndex(index:int) : AwardItem { return null; }
            public function get minLv() : int { return 0; }
            public function set minLv(value:int) : void { }
            public function get desc() : String { return null; }
            public function set desc(value:String) : void { }
            public function get title() : String { return null; }
            public function set title(value:String) : void { }
   }}