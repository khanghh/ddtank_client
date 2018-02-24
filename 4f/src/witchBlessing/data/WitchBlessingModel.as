package witchBlessing.data
{
   import com.pickgliss.ui.core.Disposeable;
   import ddt.manager.ServerConfigManager;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   
   public class WitchBlessingModel extends EventDispatcher implements Disposeable
   {
       
      
      public var isOpen:Boolean = true;
      
      public var totalExp:int = 0;
      
      public var startDate:Date;
      
      public var endDate:Date;
      
      public var lv1GetAwardsTimes:int = 0;
      
      public var lv2GetAwardsTimes:int = 0;
      
      public var lv3GetAwardsTimes:int = 0;
      
      public var lv1CD:int = 0;
      
      public var lv2CD:int = 0;
      
      public var lv3CD:int = 0;
      
      public var isDouble:Boolean = false;
      
      private var _itemInfoList:Array;
      
      public var awardslist1:Array;
      
      public var awardslist2:Array;
      
      public var awardslist3:Array;
      
      public var ExpArr:Array;
      
      public var AwardsNums:Array;
      
      public var DoubleMoney:Array;
      
      public function WitchBlessingModel(param1:IEventDispatcher = null){super(null);}
      
      public function set itemInfoList(param1:Array) : void{}
      
      public function set infoDate(param1:WitchBlessingInfo) : void{}
      
      public function get itemInfoList() : Array{return null;}
      
      public function get activityTime() : String{return null;}
      
      public function dispose() : void{}
   }
}
