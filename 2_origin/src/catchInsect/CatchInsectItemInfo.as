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
      
      public function CatchInsectItemInfo(param1:int = 0)
      {
         super();
         TemplateID = param1;
      }
      
      public function get TemplateInfo() : ItemTemplateInfo
      {
         if(_templateInfo == null)
         {
            return ItemManager.Instance.getTemplateById(this.TemplateID);
         }
         return _templateInfo;
      }
      
      public function get playerDefaultPos() : Point
      {
         return _playerDefaultPos;
      }
      
      public function set playerDefaultPos(param1:Point) : void
      {
         _playerDefaultPos = param1;
      }
      
      public function get fightOver() : Boolean
      {
         return _fightOver;
      }
      
      public function set fightOver(param1:Boolean) : void
      {
         _fightOver = param1;
      }
      
      public function get roomClose() : Boolean
      {
         return _roomClose;
      }
      
      public function set roomClose(param1:Boolean) : void
      {
         _roomClose = param1;
      }
      
      public function get myPlayerVO() : PlayerVO
      {
         return _myPlayerVO;
      }
      
      public function set myPlayerVO(param1:PlayerVO) : void
      {
         _myPlayerVO = param1;
      }
      
      public function set current_Blood(param1:Number) : void
      {
         if(_current_Blood == param1)
         {
            _cutValue = -1;
            return;
         }
         _cutValue = _current_Blood - param1;
         _current_Blood = param1;
         dispatchEvent(new Event("change"));
      }
      
      public function get current_Blood() : Number
      {
         return _current_Blood;
      }
      
      public function set isLiving(param1:Boolean) : void
      {
         _isLiving = param1;
         if(!_isLiving)
         {
            current_Blood = 0;
         }
      }
      
      public function get isLiving() : Boolean
      {
         return _isLiving;
      }
      
      public function get snowNum() : int
      {
         return _snowNum;
      }
      
      public function set snowNum(param1:int) : void
      {
         _snowNum = param1;
      }
   }
}
