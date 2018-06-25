package ddt.data.map
{
   import ddt.events.RoomEvent;
   import flash.events.EventDispatcher;
   import game.model.BaseSettleInfo;
   
   public class MissionInfo extends EventDispatcher
   {
      
      public static const BIG_TACK_CARD:int = 2;
      
      public static const SMALL_TAKE_CARD:int = 1;
      
      public static const HAVE_NO_CARD:int = 0;
       
      
      public var id:int;
      
      public var missionIndex:int;
      
      public var nextMissionIndex:int;
      
      public var totalMissiton:int;
      
      public var totalCount:int;
      
      public var currentCount:int;
      
      public var title1:String = "";
      
      public var title2:String = "";
      
      public var title3:String = "";
      
      public var title4:String = "";
      
      public var currentValue1:int;
      
      public var currentValue2:int;
      
      public var currentValue3:int;
      
      public var currentValue4:int;
      
      public var totalValue1:int;
      
      public var totalValue2:int;
      
      public var totalValue3:int;
      
      public var totalValue4:int;
      
      public var countAssetPlace:int = 1;
      
      public var currentTurn:int;
      
      public var totalTurn:int;
      
      public var name:String;
      
      public var success:String = "";
      
      public var failure:String = "";
      
      public var description:String = "";
      
      public var missionOverPlayer:Array;
      
      public var missionOverNPCMovies:Array;
      
      public var maxTime:int;
      
      public var canEnterFinall:Boolean;
      
      public var pic:String;
      
      public var param1:int;
      
      public var param2:int;
      
      public var tackCardType:int = 0;
      
      public var tryagain:int = 0;
      
      private var _maxTurnCount:int = 0;
      
      private var _turnCount:int;
      
      public function MissionInfo()
      {
         super();
      }
      
      public function findMissionOverInfo(playerid:int) : BaseSettleInfo
      {
         var i:int = 0;
         if(missionOverPlayer == null)
         {
            return null;
         }
         i = 0;
         while(i < missionOverPlayer.length)
         {
            if(missionOverPlayer[i].playerid == playerid)
            {
               return missionOverPlayer[i];
            }
            i++;
         }
         return null;
      }
      
      public function parseString(value:String) : void
      {
         var i:int = 0;
         var array:Array = value.split(",");
         title1 = "";
         title2 = "";
         title3 = "";
         title4 = "";
         for(i = 0; i < array.length; )
         {
            if(array[i] != null)
            {
               this["title" + (i + 1)] = array[i].toString();
               i++;
               continue;
            }
            return;
         }
      }
      
      public function get maxTurnCount() : int
      {
         return _maxTurnCount;
      }
      
      public function set maxTurnCount(val:int) : void
      {
         _maxTurnCount = val;
      }
      
      public function get turnCount() : int
      {
         return _turnCount;
      }
      
      public function set turnCount(val:int) : void
      {
         if(_turnCount != val)
         {
            _turnCount = val;
            dispatchEvent(new RoomEvent("turncountChanged"));
         }
      }
      
      public function get isWorldCupI() : Boolean
      {
         return id == 14001 || id == 14101 || id == 14201;
      }
      
      public function get isWorldCupII() : Boolean
      {
         return id == 14002 || id == 14102 || id == 14202;
      }
      
      public function get isWorldCupIII() : Boolean
      {
         return id == 14003 || id == 14103 || id == 14203;
      }
   }
}
