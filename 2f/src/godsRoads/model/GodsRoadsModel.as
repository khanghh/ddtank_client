package godsRoads.model{   import flash.events.EventDispatcher;   import godsRoads.data.GodsRoadsMissionInfo;   import godsRoads.data.GodsRoadsVo;      public class GodsRoadsModel extends EventDispatcher   {                   private var vo:GodsRoadsVo;            private var _questionTemple:Vector.<GodsRoadsMissionInfo>;            public function GodsRoadsModel() { super(); }
            public function getMissionInfoById(id:int) : GodsRoadsMissionInfo { return null; }
            public function set godsRoadsData(val:GodsRoadsVo) : void { }
            public function get godsRoadsData() : GodsRoadsVo { return null; }
            public function set missionInfo(val:Vector.<GodsRoadsMissionInfo>) : void { }
            public function get missionInfo() : Vector.<GodsRoadsMissionInfo> { return null; }
   }}