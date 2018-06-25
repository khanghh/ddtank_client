package academy{   import ddt.data.player.AcademyPlayerInfo;      public class AcademyModel   {                   private var _requestType:Boolean;            private var _currentSex:Boolean;            private var _register:Boolean;            private var _appshipStateType:Boolean;            private var _academyPlayers:Vector.<AcademyPlayerInfo>;            private var _currentAcademyItemInfo:AcademyPlayerInfo;            private var _totalPage:int;            private var _selfIsRegister:Boolean;            private var _selfDescribe:String;            public function AcademyModel() { super(); }
            private function init() : void { }
            public function set list(players:Vector.<AcademyPlayerInfo>) : void { }
            public function get list() : Vector.<AcademyPlayerInfo> { return null; }
            public function set sex(value:Boolean) : void { }
            public function get sex() : Boolean { return false; }
            public function set state(value:Boolean) : void { }
            public function get state() : Boolean { return false; }
            public function set info(value:AcademyPlayerInfo) : void { }
            public function get info() : AcademyPlayerInfo { return null; }
            public function set totalPage(value:int) : void { }
            public function get totalPage() : int { return 0; }
            public function set selfIsRegister(value:Boolean) : void { }
            public function get selfIsRegister() : Boolean { return false; }
            public function set selfDescribe(value:String) : void { }
            public function get selfDescribe() : String { return null; }
   }}