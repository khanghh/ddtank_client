package catchInsect
{
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.manager.ItemManager;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.geom.Point;
   
   public class CatchInsectItemInfo extends EventDispatcher
   {
       
      
      public var TemplateID:int;
      
      public var Count:int = 1;
      
      private var _templateInfo:ItemTemplateInfo;
      
      public var isUp:Boolean;
      
      public var isFall:Boolean;
      
      public var num:int = 10;
      
      private var _playerDefaultPos:Point;
      
      private var _fightOver:Boolean;
      
      private var _roomClose:Boolean;
      
      private var _myPlayerVO:PlayerVO;
      
      private var _isLiving:Boolean;
      
      private var _current_Blood:Number;
      
      private var _cutValue:Number;
      
      private var _snowNum:int;
      
      public function CatchInsectItemInfo(param1:int = 0){super();}
      
      public function get TemplateInfo() : ItemTemplateInfo{return null;}
      
      public function get playerDefaultPos() : Point{return null;}
      
      public function set playerDefaultPos(param1:Point) : void{}
      
      public function get fightOver() : Boolean{return false;}
      
      public function set fightOver(param1:Boolean) : void{}
      
      public function get roomClose() : Boolean{return false;}
      
      public function set roomClose(param1:Boolean) : void{}
      
      public function get myPlayerVO() : PlayerVO{return null;}
      
      public function set myPlayerVO(param1:PlayerVO) : void{}
      
      public function set current_Blood(param1:Number) : void{}
      
      public function get current_Blood() : Number{return 0;}
      
      public function set isLiving(param1:Boolean) : void{}
      
      public function get isLiving() : Boolean{return false;}
      
      public function get snowNum() : int{return 0;}
      
      public function set snowNum(param1:int) : void{}
   }
}
