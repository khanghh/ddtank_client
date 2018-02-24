package hotSpring.model
{
   import ddt.data.HotSpringRoomInfo;
   import ddt.manager.PlayerManager;
   import ddt.manager.ServerConfigManager;
   import flash.events.EventDispatcher;
   import hotSpring.event.HotSpringRoomEvent;
   import hotSpring.event.HotSpringRoomListEvent;
   import hotSpring.vo.MapVO;
   import hotSpring.vo.PlayerVO;
   import road7th.data.DictionaryData;
   
   public class HotSpringRoomModel extends EventDispatcher
   {
      
      private static var _instance:HotSpringRoomModel;
      
      public static const expUpArray:Array = [0,200,240,288,346,415,498,597,717,860,946,1041,1145,1259,1385,1523,1676,1843,2028,2231,2342,2459,2582,2711,2847,2989,3139,3295,3460,3633,3815,3929,4047,4169,4294,4423,4555,4692,4833,4978,5127,5281,5439,5602,5770,5944,6122,6306,6495,6690,6890,7097,7310,7529,7755,7988,8227,8474,8728,8990,9260];
       
      
      private var _roomSelf:HotSpringRoomInfo;
      
      private var _mapVO:MapVO;
      
      private var _selfVO:PlayerVO;
      
      private var _roomPlayerList:DictionaryData;
      
      public function HotSpringRoomModel(){super();}
      
      public static function get Instance() : HotSpringRoomModel{return null;}
      
      public function get roomSelf() : HotSpringRoomInfo{return null;}
      
      public function set roomSelf(param1:HotSpringRoomInfo) : void{}
      
      public function get roomPlayerList() : DictionaryData{return null;}
      
      public function set roomPlayerList(param1:DictionaryData) : void{}
      
      public function roomPlayerAddOrUpdate(param1:PlayerVO) : void{}
      
      public function roomPlayerRemove(param1:int) : void{}
      
      public function set mapVO(param1:MapVO) : void{}
      
      public function get mapVO() : MapVO{return null;}
      
      public function get selfVO() : PlayerVO{return null;}
      
      public function set selfVO(param1:PlayerVO) : void{}
      
      public function getExpUpValue(param1:int, param2:int, param3:int = 0) : int{return 0;}
      
      public function dispose() : void{}
   }
}
