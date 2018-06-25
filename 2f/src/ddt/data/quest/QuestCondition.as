package ddt.data.quest{   public class QuestCondition   {                   private var _description:String;            private var _type:int;            private var _param1:int;            private var _param2:int;            private var _questId:int;            private var _conId:int;            private var _turnType:int;            public var isOpitional:Boolean;            public function QuestCondition(questId:int, conId:int, type:int, desc:String = "", para1:int = 0, para2:int = 0, turnType:int = 0) { super(); }
            public function get target() : int { return 0; }
            public function get param() : int { return 0; }
            public function get param2() : int { return 0; }
            public function get description() : String { return null; }
            public function get type() : int { return 0; }
            public function tos() : String { return null; }
            public function get questID() : int { return 0; }
            public function get ConID() : int { return 0; }
            public function get turnType() : int { return 0; }
   }}