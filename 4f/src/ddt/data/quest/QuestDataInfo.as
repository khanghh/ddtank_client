package ddt.data.quest{   public class QuestDataInfo   {                   public var isGet:Boolean;            public var repeatLeft:int;            public var hadChecked:Boolean;            public var quality:int;            private var _questID:int;            private var _progress:Array;            private var _isAutoComplete:Vector.<Boolean>;            public var CompleteDate:Date;            public var AddTiemsDate:Date;            private var _isAchieved:Boolean;            private var _isNew:Boolean;            private var _informed:Boolean;            private var _isExist:Boolean;            public function QuestDataInfo(id:int) { super(); }
            public function set isExist(value:Boolean) : void { }
            public function get isExist() : Boolean { return false; }
            public function get id() : int { return 0; }
            public function set isNew(value:Boolean) : void { }
            public function get isNew() : Boolean { return false; }
            public function set informed(value:Boolean) : void { }
            public function get needInformed() : Boolean { return false; }
            public function get isAchieved() : Boolean { return false; }
            public function set isAchieved(isAchieved:Boolean) : void { }
            public function setProgress(con0:int, con1:int = 0, con2:int = 0, con3:int = 0) : void { }
            public function setProgressConcoat(proArray:Array) : void { }
            public function get progress() : Array { return null; }
            public function setIsAutoComplete($AutoCom0:Boolean, $AutoCom1:Boolean, $AutoCom2:Boolean, $AutoCom3:Boolean) : void { }
            public function setIsAutoCompleteConcoat($autoComArray:Vector.<Boolean>) : void { }
            public function get isAutoComplete() : Vector.<Boolean> { return null; }
   }}