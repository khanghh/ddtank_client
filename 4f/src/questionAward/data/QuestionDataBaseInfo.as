package questionAward.data{   public class QuestionDataBaseInfo   {                   private var _qid:int;            private var _title:String;            private var _type:int;            private var _isMultiSelect:Boolean;            private var _content:Vector.<String>;            public function QuestionDataBaseInfo() { super(); }
            public function addContent(data:String) : void { }
            public function getContent() : Vector.<String> { return null; }
            public function get isMultiSelect() : Boolean { return false; }
            public function set isMultiSelect(value:Boolean) : void { }
            public function get type() : int { return 0; }
            public function set type(value:int) : void { }
            public function get title() : String { return null; }
            public function set title(value:String) : void { }
            public function get qid() : int { return 0; }
            public function set qid(value:int) : void { }
   }}