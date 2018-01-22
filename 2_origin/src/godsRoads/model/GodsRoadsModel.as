package godsRoads.model
{
   import flash.events.EventDispatcher;
   import godsRoads.data.GodsRoadsMissionInfo;
   import godsRoads.data.GodsRoadsVo;
   
   public class GodsRoadsModel extends EventDispatcher
   {
       
      
      private var vo:GodsRoadsVo;
      
      private var _questionTemple:Vector.<GodsRoadsMissionInfo>;
      
      public function GodsRoadsModel()
      {
         super();
      }
      
      public function getMissionInfoById(param1:int) : GodsRoadsMissionInfo
      {
         var _loc3_:* = null;
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < _questionTemple.length)
         {
            if(param1 == _questionTemple[_loc2_].questId)
            {
               _loc3_ = _questionTemple[_loc2_];
               break;
            }
            _loc2_++;
         }
         return _loc3_;
      }
      
      public function set godsRoadsData(param1:GodsRoadsVo) : void
      {
         vo = param1;
      }
      
      public function get godsRoadsData() : GodsRoadsVo
      {
         return vo;
      }
      
      public function set missionInfo(param1:Vector.<GodsRoadsMissionInfo>) : void
      {
         _questionTemple = param1;
      }
      
      public function get missionInfo() : Vector.<GodsRoadsMissionInfo>
      {
         return _questionTemple;
      }
   }
}
