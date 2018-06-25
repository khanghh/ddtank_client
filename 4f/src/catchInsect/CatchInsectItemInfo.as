package catchInsect{   import ddt.data.goods.ItemTemplateInfo;   import ddt.manager.ItemManager;   import flash.events.Event;   import flash.events.EventDispatcher;   import flash.geom.Point;      public class CatchInsectItemInfo extends EventDispatcher   {                   public var TemplateID:int;            public var Count:int = 1;            private var _templateInfo:ItemTemplateInfo;            public var isUp:Boolean;            public var isFall:Boolean;            public var num:int = 10;            private var _playerDefaultPos:Point;            private var _fightOver:Boolean;            private var _roomClose:Boolean;            private var _myPlayerVO:PlayerVO;            private var _isLiving:Boolean;            private var _current_Blood:Number;            private var _cutValue:Number;            private var _snowNum:int;            public function CatchInsectItemInfo($TemplateID:int = 0) { super(); }
            public function get TemplateInfo() : ItemTemplateInfo { return null; }
            public function get playerDefaultPos() : Point { return null; }
            public function set playerDefaultPos(value:Point) : void { }
            public function get fightOver() : Boolean { return false; }
            public function set fightOver(value:Boolean) : void { }
            public function get roomClose() : Boolean { return false; }
            public function set roomClose(value:Boolean) : void { }
            public function get myPlayerVO() : PlayerVO { return null; }
            public function set myPlayerVO(value:PlayerVO) : void { }
            public function set current_Blood(value:Number) : void { }
            public function get current_Blood() : Number { return 0; }
            public function set isLiving(value:Boolean) : void { }
            public function get isLiving() : Boolean { return false; }
            public function get snowNum() : int { return 0; }
            public function set snowNum(value:int) : void { }
   }}