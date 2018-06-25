package christmas.info
{
   import christmas.player.PlayerVO;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.manager.ItemManager;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.geom.Point;
   
   public class ChristmasSystemItemsInfo extends EventDispatcher
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
      
      public function ChristmasSystemItemsInfo($TemplateID:int = 0)
      {
         super();
         TemplateID = $TemplateID;
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
      
      public function set playerDefaultPos(value:Point) : void
      {
         _playerDefaultPos = value;
      }
      
      public function get fightOver() : Boolean
      {
         return _fightOver;
      }
      
      public function set fightOver(value:Boolean) : void
      {
         _fightOver = value;
      }
      
      public function get roomClose() : Boolean
      {
         return _roomClose;
      }
      
      public function set roomClose(value:Boolean) : void
      {
         _roomClose = value;
      }
      
      public function get myPlayerVO() : PlayerVO
      {
         return _myPlayerVO;
      }
      
      public function set myPlayerVO(value:PlayerVO) : void
      {
         _myPlayerVO = value;
      }
      
      public function set current_Blood(value:Number) : void
      {
         if(_current_Blood == value)
         {
            _cutValue = -1;
            return;
         }
         _cutValue = _current_Blood - value;
         _current_Blood = value;
         dispatchEvent(new Event("change"));
      }
      
      public function get current_Blood() : Number
      {
         return _current_Blood;
      }
      
      public function set isLiving(value:Boolean) : void
      {
         _isLiving = value;
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
      
      public function set snowNum(value:int) : void
      {
         _snowNum = value;
      }
   }
}
