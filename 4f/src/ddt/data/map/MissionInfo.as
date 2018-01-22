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
      
      public function MissionInfo(){super();}
      
      public function findMissionOverInfo(param1:int) : BaseSettleInfo{return null;}
      
      public function parseString(param1:String) : void{}
      
      public function get maxTurnCount() : int{return 0;}
      
      public function set maxTurnCount(param1:int) : void{}
      
      public function get turnCount() : int{return 0;}
      
      public function set turnCount(param1:int) : void{}
      
      public function get isWorldCupI() : Boolean{return false;}
      
      public function get isWorldCupII() : Boolean{return false;}
      
      public function get isWorldCupIII() : Boolean{return false;}
   }
}
