package godsRoads.analyze
{
   import com.pickgliss.loader.DataAnalyzer;
   import godsRoads.data.GodsRoadsMissionInfo;
   import godsRoads.manager.GodsRoadsManager;
   
   public class GodsRoadsDataAnalyzer extends DataAnalyzer
   {
       
      
      public var dataList:Vector.<GodsRoadsMissionInfo>;
      
      public function GodsRoadsDataAnalyzer(param1:Function)
      {
         dataList = new Vector.<GodsRoadsMissionInfo>();
         super(param1);
      }
      
      override public function analyze(param1:*) : void
      {
         var _loc5_:* = null;
         var _loc6_:int = 0;
         var _loc2_:* = null;
         var _loc3_:* = null;
         var _loc4_:XML = new XML(param1);
         GodsRoadsManager.instance.XMLData = _loc4_;
         if(_loc4_.@value == "true")
         {
            _loc5_ = _loc4_..Item;
            _loc6_ = 0;
            while(_loc6_ < _loc5_.length())
            {
               if(_loc5_[_loc6_].@QuestType != 1)
               {
                  _loc2_ = new GodsRoadsMissionInfo();
                  _loc3_ = _loc5_[_loc6_]..Item_Condiction;
                  _loc2_.questId = _loc5_[_loc6_].@ID;
                  _loc2_.Title = _loc5_[_loc6_].@Title;
                  _loc2_.Detail = _loc5_[_loc6_].@Detail;
                  _loc2_.Objective = _loc5_[_loc6_].@Objective;
                  _loc2_.NeedMinLevel = _loc5_[_loc6_].@NeedMinLevel;
                  _loc2_.NeedMaxLevel = _loc5_[_loc6_].@NeedMaxLevel;
                  _loc2_.Period = _loc5_[_loc6_].@Period;
                  _loc2_.conditiontId = _loc3_[0].@CondictionID;
                  _loc2_.conditiontTitle = _loc3_[0].@CondictionTitle;
                  _loc2_.conditionType = _loc3_[0].@CondictionType;
                  _loc2_.Para1 = _loc3_[0].@Para1;
                  _loc2_.Para2 = _loc3_[0].@Para2;
                  _loc2_.IndexType = _loc3_[0].@IndexType;
                  dataList.push(_loc2_);
               }
               _loc6_++;
            }
            onAnalyzeComplete();
         }
      }
   }
}
