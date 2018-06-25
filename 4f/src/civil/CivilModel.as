package civil{   import ddt.data.player.CivilPlayerInfo;   import ddt.manager.PlayerManager;   import flash.events.EventDispatcher;      public class CivilModel extends EventDispatcher   {                   private var _civilPlayers:Array;            private var _currentcivilItemInfo:CivilPlayerInfo;            private var _totalPage:int;            private var _currentLeafSex:Boolean = true;            private var _register:Boolean = false;            private var _IsFirst:Boolean = false;            public function CivilModel(isFirst:Boolean) { super(); }
            public function set currentcivilItemInfo($info:CivilPlayerInfo) : void { }
            public function get currentcivilItemInfo() : CivilPlayerInfo { return null; }
            public function upSelfPublishEquit(b:Boolean) : void { }
            public function upSelfIntroduction(msg:String) : void { }
            public function set civilPlayers(value:Array) : void { }
            public function update() : void { }
            public function updateBtn() : void { }
            public function get civilPlayers() : Array { return null; }
            public function set TotalPage(value:int) : void { }
            public function get TotalPage() : int { return 0; }
            public function get sex() : Boolean { return false; }
            public function set sex(value:Boolean) : void { }
            public function get registed() : Boolean { return false; }
            public function set registed(val:Boolean) : void { }
            public function get IsFirst() : Boolean { return false; }
            public function dispose() : void { }
   }}