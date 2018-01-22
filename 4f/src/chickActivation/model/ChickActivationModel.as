package chickActivation.model
{
   import chickActivation.data.ChickActivationInfo;
   import chickActivation.event.ChickActivationEvent;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.manager.ItemManager;
   import ddt.manager.TimeManager;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   import flash.utils.Dictionary;
   
   public class ChickActivationModel extends EventDispatcher
   {
       
      
      public var isOpen:Boolean = true;
      
      private var _itemInfoList:Array;
      
      public var qualityDic:Dictionary;
      
      public var isKeyOpened:int;
      
      public var keyIndex:int;
      
      public var keyOpenedTime:Date;
      
      public var keyOpenedType:int;
      
      public var gainArr:Array;
      
      public function ChickActivationModel(param1:IEventDispatcher = null){super(null);}
      
      public function getInventoryItemInfo(param1:ChickActivationInfo) : InventoryItemInfo{return null;}
      
      public function findQualityValue(param1:String) : int{return 0;}
      
      public function getRemainingDay() : int{return 0;}
      
      public function getGainLevel(param1:int) : Boolean{return false;}
      
      public function get itemInfoList() : Array{return null;}
      
      public function set itemInfoList(param1:Array) : void{}
      
      public function dataChange(param1:String, param2:Object = null) : void{}
   }
}
