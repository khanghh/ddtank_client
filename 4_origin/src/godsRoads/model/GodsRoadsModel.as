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
      
      public function getMissionInfoById(id:int) : GodsRoadsMissionInfo
      {
         var info:* = null;
         var i:int = 0;
         for(i = 0; i < _questionTemple.length; )
         {
            if(id == _questionTemple[i].questId)
            {
               info = _questionTemple[i];
               break;
            }
            i++;
         }
         return info;
      }
      
      public function set godsRoadsData(val:GodsRoadsVo) : void
      {
         vo = val;
      }
      
      public function get godsRoadsData() : GodsRoadsVo
      {
         return vo;
      }
      
      public function set missionInfo(val:Vector.<GodsRoadsMissionInfo>) : void
      {
         _questionTemple = val;
      }
      
      public function get missionInfo() : Vector.<GodsRoadsMissionInfo>
      {
         return _questionTemple;
      }
   }
}
