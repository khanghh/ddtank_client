package godsRoads.model
{
   import flash.events.EventDispatcher;
   import godsRoads.data.GodsRoadsMissionInfo;
   import godsRoads.data.GodsRoadsVo;
   
   public class GodsRoadsModel extends EventDispatcher
   {
       
      
      private var vo:GodsRoadsVo;
      
      private var _questionTemple:Vector.<GodsRoadsMissionInfo>;
      
      public function GodsRoadsModel(){super();}
      
      public function getMissionInfoById(param1:int) : GodsRoadsMissionInfo{return null;}
      
      public function set godsRoadsData(param1:GodsRoadsVo) : void{}
      
      public function get godsRoadsData() : GodsRoadsVo{return null;}
      
      public function set missionInfo(param1:Vector.<GodsRoadsMissionInfo>) : void{}
      
      public function get missionInfo() : Vector.<GodsRoadsMissionInfo>{return null;}
   }
}
