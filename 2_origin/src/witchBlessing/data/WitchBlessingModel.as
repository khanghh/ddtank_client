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
      
      public function WitchBlessingModel(target:IEventDispatcher = null)
      {
         _itemInfoList = [];
         awardslist1 = [];
         awardslist2 = [];
         awardslist3 = [];
         ExpArr = [0];
         AwardsNums = [];
         DoubleMoney = [];
         super(target);
      }
      
      public function set itemInfoList(arr:Array) : void
      {
         var i:int = 0;
         var info:* = null;
         var str:* = null;
         var info1:* = null;
         var strArr:* = null;
         for(i = 0; i < arr.length; )
         {
            info = arr[i];
            if(info.Quality == 1)
            {
               awardslist1.push(info);
            }
            else if(info.Quality == 2)
            {
               awardslist2.push(info);
            }
            else if(info.Quality == 3)
            {
               awardslist3.push(info);
            }
            i++;
         }
         _itemInfoList = [awardslist1,awardslist2,awardslist3];
         var obj:Object = ServerConfigManager.instance.serverConfigInfo["WitchBlessConfig"];
         if(obj)
         {
            str = obj.Value;
            if(str && str != "")
            {
               info1 = new WitchBlessingInfo();
               strArr = str.split("|");
               info1.ExpArr = (strArr[0] as String).split(",");
               info1.AwardsNums = (strArr[1] as String).split(",");
               info1.DoubleMoney = (strArr[2] as String).split(",");
            }
            infoDate = info1;
         }
      }
      
      public function set infoDate(info:WitchBlessingInfo) : void
      {
         var i:int = 0;
         var exp:Array = info.ExpArr;
         var tempExp:int = 0;
         for(i = 0; i < exp.length; )
         {
            tempExp = tempExp + int(exp[i]);
            ExpArr.push(tempExp);
            i++;
         }
         AwardsNums = info.AwardsNums;
         DoubleMoney = info.DoubleMoney;
      }
      
      public function get itemInfoList() : Array
      {
         return _itemInfoList;
      }
      
      public function get activityTime() : String
      {
         var minutes1:* = null;
         var minutes2:* = null;
         var dateString:String = "";
         if(startDate && endDate)
         {
            minutes1 = startDate.minutes > 9?startDate.minutes + "":"0" + startDate.minutes;
            minutes2 = endDate.minutes > 9?endDate.minutes + "":"0" + endDate.minutes;
            dateString = startDate.fullYear + "." + (startDate.month + 1) + "." + startDate.date + " - " + endDate.fullYear + "." + (endDate.month + 1) + "." + endDate.date;
         }
         return dateString;
      }
      
      public function dispose() : void
      {
      }
   }
}
