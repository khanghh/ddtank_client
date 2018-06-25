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
      
      public function HotSpringRoomModel()
      {
         _mapVO = new MapVO();
         _selfVO = new PlayerVO();
         _roomPlayerList = new DictionaryData();
         super();
      }
      
      public static function get Instance() : HotSpringRoomModel
      {
         if(_instance == null)
         {
            _instance = new HotSpringRoomModel();
         }
         return _instance;
      }
      
      public function get roomSelf() : HotSpringRoomInfo
      {
         return _roomSelf;
      }
      
      public function set roomSelf(value:HotSpringRoomInfo) : void
      {
         _roomSelf = value;
         dispatchEvent(new HotSpringRoomListEvent("roomCreate",_roomSelf));
      }
      
      public function get roomPlayerList() : DictionaryData
      {
         return _roomPlayerList;
      }
      
      public function set roomPlayerList(value:DictionaryData) : void
      {
         _roomPlayerList = value;
      }
      
      public function roomPlayerAddOrUpdate(playerVO:PlayerVO) : void
      {
         if(playerVO.playerInfo.ID == PlayerManager.Instance.Self.ID)
         {
            _selfVO = playerVO;
         }
         if(_roomPlayerList[playerVO.playerInfo.ID])
         {
            _roomPlayerList.add(playerVO.playerInfo.ID,playerVO);
            dispatchEvent(new HotSpringRoomEvent("roomPlayerUpdate",playerVO));
         }
         else
         {
            _roomPlayerList.add(playerVO.playerInfo.ID,playerVO);
            dispatchEvent(new HotSpringRoomEvent("roomPlayerAdd",playerVO));
         }
      }
      
      public function roomPlayerRemove(playerID:int) : void
      {
         if(_roomPlayerList)
         {
            _roomPlayerList.remove(playerID);
         }
         dispatchEvent(new HotSpringRoomEvent("roomPlayerRemove",playerID));
      }
      
      public function set mapVO(value:MapVO) : void
      {
         _mapVO = value;
      }
      
      public function get mapVO() : MapVO
      {
         return _mapVO;
      }
      
      public function get selfVO() : PlayerVO
      {
         return _selfVO;
      }
      
      public function set selfVO(value:PlayerVO) : void
      {
         _selfVO = value;
      }
      
      public function getExpUpValue(roomType:int, playerLevel:int, vipLevel:int = 0) : int
      {
         var hourValue:int = 0;
         if(!(int(roomType) - 1))
         {
            hourValue = ServerConfigManager.instance.HotSpringExp[playerLevel];
         }
         return Math.round(hourValue / 60 * (1 + vipLevel * 0.1));
      }
      
      public function dispose() : void
      {
         _roomSelf = null;
         _mapVO = null;
         _selfVO = null;
         if(_roomPlayerList)
         {
            while(_roomPlayerList.list.length > 0)
            {
               _roomPlayerList.list.shift();
            }
            _roomPlayerList.clear();
         }
         _roomPlayerList = null;
         _instance = null;
      }
   }
}
