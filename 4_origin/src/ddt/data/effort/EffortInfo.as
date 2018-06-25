package ddt.data.effort
{
   import com.pickgliss.ui.controls.cell.INotSameHeightListCellData;
   import ddt.events.EffortEvent;
   import flash.events.EventDispatcher;
   import road7th.data.DictionaryData;
   
   public class EffortInfo extends EventDispatcher implements INotSameHeightListCellData
   {
       
      
      public var ID:int;
      
      public var PlaceID:int;
      
      public var Title:String;
      
      public var Detail:String;
      
      public var NeedMinLevel:int;
      
      public var NeedMaxLevel:int;
      
      public var PreAchievementID:String;
      
      public var IsOther:Boolean;
      
      public var AchievementType:int;
      
      public var CanHide:Boolean;
      
      public var StartDate:Date;
      
      public var EndDate:Date;
      
      public var AchievementPoint:int;
      
      public var EffortQualificationList:DictionaryData;
      
      public var effortRewardArray:Array;
      
      private var effortCompleteState:EffortCompleteStateInfo;
      
      public var isAddToList:Boolean;
      
      public var picId:int;
      
      public var completedDate:Date;
      
      public var isSelect:Boolean;
      
      public var maxHeight:int = 95;
      
      public var minHeight:int = 95;
      
      public function EffortInfo()
      {
         super();
      }
      
      public function set CompleteStateInfo(info:EffortCompleteStateInfo) : void
      {
         effortCompleteState = info;
      }
      
      public function get CompleteStateInfo() : EffortCompleteStateInfo
      {
         return effortCompleteState;
      }
      
      public function update() : void
      {
         dispatchEvent(new EffortEvent("changed"));
      }
      
      public function testIsComplete() : void
      {
      }
      
      public function addEffortQualification(info:EffortQualificationInfo) : void
      {
         if(!EffortQualificationList)
         {
            EffortQualificationList = new DictionaryData();
         }
         EffortQualificationList[info.CondictionType] = info;
         update();
      }
      
      public function addEffortReward(info:EffortRewardInfo) : void
      {
         if(!effortRewardArray)
         {
            effortRewardArray = [];
         }
         effortRewardArray.push(info);
      }
      
      public function getCellHeight() : Number
      {
         if(isSelect)
         {
            return maxHeight;
         }
         return minHeight;
      }
   }
}
