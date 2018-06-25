package questionAward.data{   public class QuestionAwardInfo   {                   private var _title:String;            private var _dataBaseList:Vector.<QuestionDataBaseInfo>;            private var _minLv:int;            private var _beginTime:Date;            private var _endTime:Date;            public function QuestionAwardInfo() { super(); }
            public function get endTime() : Date { return null; }
            public function set endTime(value:Date) : void { }
            public function get beginTime() : Date { return null; }
            public function set beginTime(value:Date) : void { }
            public function get minLv() : int { return 0; }
            public function set minLv(value:int) : void { }
            public function get title() : String { return null; }
            public function set title(value:String) : void { }
            public function addDataBaseInfo(data:String) : void { }
            public function createQuestionIterator() : QuestionIterator { return null; }
   }}