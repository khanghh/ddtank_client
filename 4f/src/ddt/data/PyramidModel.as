package ddt.data
{
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.events.PyramidEvent;
   import ddt.manager.ItemManager;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   import flash.utils.Dictionary;
   
   public class PyramidModel extends EventDispatcher
   {
       
      
      public var isOpen:Boolean;
      
      public var isScoreExchange:Boolean;
      
      public var turnCardPrice:int;
      
      public var revivePrice:Array;
      
      public var freeCount:int;
      
      public var beginTime:Date;
      
      public var endTime:Date;
      
      public var currentLayer:int;
      
      public var position:int;
      
      public var maxLayer:int;
      
      private var _totalPoint:int;
      
      public var turnPoint:int;
      
      public var pointRatio:int;
      
      public var currentFreeCount:int;
      
      public var currentReviveCount:int;
      
      public var isPyramidStart:Boolean;
      
      public var selectLayerItems:Dictionary;
      
      public var templateID:int;
      
      public var isPyramidDie:Boolean;
      
      public var isUp:Boolean;
      
      public var items:Array;
      
      public function PyramidModel(param1:IEventDispatcher = null){super(null);}
      
      public function getLevelCardItems(param1:int) : Array{return null;}
      
      public function getLevelCardItem(param1:int, param2:int) : PyramidSystemItemsInfo{return null;}
      
      public function getInventoryItemInfo(param1:PyramidSystemItemsInfo) : InventoryItemInfo{return null;}
      
      public function get startActivityTime() : String{return null;}
      
      public function get endActivityTime() : String{return null;}
      
      public function get isShuffleMovie() : Boolean{return false;}
      
      public function dataChange(param1:String, param2:Object = null) : void{}
      
      public function set totalPoint(param1:int) : void{}
      
      public function get totalPoint() : int{return 0;}
   }
}
