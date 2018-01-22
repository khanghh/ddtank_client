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
      
      public function WitchBlessingModel(param1:IEventDispatcher = null)
      {
         _itemInfoList = [];
         awardslist1 = [];
         awardslist2 = [];
         awardslist3 = [];
         ExpArr = [0];
         AwardsNums = [];
         DoubleMoney = [];
         super(param1);
      }
      
      public function set itemInfoList(param1:Array) : void
      {
         var _loc7_:int = 0;
         var _loc6_:* = null;
         var _loc2_:* = null;
         var _loc3_:* = null;
         var _loc5_:* = null;
         _loc7_ = 0;
         while(_loc7_ < param1.length)
         {
            _loc6_ = param1[_loc7_];
            if(_loc6_.Quality == 1)
            {
               awardslist1.push(_loc6_);
            }
            else if(_loc6_.Quality == 2)
            {
               awardslist2.push(_loc6_);
            }
            else if(_loc6_.Quality == 3)
            {
               awardslist3.push(_loc6_);
            }
            _loc7_++;
         }
         _itemInfoList = [awardslist1,awardslist2,awardslist3];
         var _loc4_:Object = ServerConfigManager.instance.serverConfigInfo["WitchBlessConfig"];
         if(_loc4_)
         {
            _loc2_ = _loc4_.Value;
            if(_loc2_ && _loc2_ != "")
            {
               _loc3_ = new WitchBlessingInfo();
               _loc5_ = _loc2_.split("|");
               _loc3_.ExpArr = (_loc5_[0] as String).split(",");
               _loc3_.AwardsNums = (_loc5_[1] as String).split(",");
               _loc3_.DoubleMoney = (_loc5_[2] as String).split(",");
            }
            infoDate = _loc3_;
         }
      }
      
      public function set infoDate(param1:WitchBlessingInfo) : void
      {
         var _loc4_:int = 0;
         var _loc3_:Array = param1.ExpArr;
         var _loc2_:int = 0;
         _loc4_ = 0;
         while(_loc4_ < _loc3_.length)
         {
            _loc2_ = _loc2_ + int(_loc3_[_loc4_]);
            ExpArr.push(_loc2_);
            _loc4_++;
         }
         AwardsNums = param1.AwardsNums;
         DoubleMoney = param1.DoubleMoney;
      }
      
      public function get itemInfoList() : Array
      {
         return _itemInfoList;
      }
      
      public function get activityTime() : String
      {
         var _loc2_:* = null;
         var _loc1_:* = null;
         var _loc3_:String = "";
         if(startDate && endDate)
         {
            _loc2_ = startDate.minutes > 9?startDate.minutes + "":"0" + startDate.minutes;
            _loc1_ = endDate.minutes > 9?endDate.minutes + "":"0" + endDate.minutes;
            _loc3_ = startDate.fullYear + "." + (startDate.month + 1) + "." + startDate.date + " - " + endDate.fullYear + "." + (endDate.month + 1) + "." + endDate.date;
         }
         return _loc3_;
      }
      
      public function dispose() : void
      {
      }
   }
}
