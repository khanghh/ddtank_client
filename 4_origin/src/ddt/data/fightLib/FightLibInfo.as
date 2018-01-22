package ddt.data.fightLib
{
   import ddt.manager.PlayerManager;
   import fightLib.FightLibManager;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   
   public class FightLibInfo extends EventDispatcher
   {
      
      public static const MEASHUR_SCREEN:int = 1;
      
      public static const TWENTY_DEGREE:int = 2;
      
      public static const SIXTY_FIVE_DEGREE:int = 3;
      
      public static const HIGH_THROW:int = 4;
      
      public static const HIGH_GAP:int = 5;
      
      public static const EASY:int = 0;
      
      public static const NORMAL:int = 1;
      
      public static const DIFFICULT:int = 2;
      
      private static const AWARD_GIFTS:Array = [100,300,500];
      
      private static const AWARD_EXP:Array = [2000,5000,8000];
      
      private static const AWARD_ITEMS:Array = [[{
         "id":11021,
         "number":4
      },{
         "id":11002,
         "number":4
      },{
         "id":11006,
         "number":4
      },{
         "id":11010,
         "number":4
      },{
         "id":11014,
         "number":4
      },{
         "id":11408,
         "number":4
      }],[{
         "id":11022,
         "number":4
      },{
         "id":11003,
         "number":4
      },{
         "id":11007,
         "number":4
      },{
         "id":11011,
         "number":4
      },{
         "id":11015,
         "number":4
      },{
         "id":11408,
         "number":4
      }],[{
         "id":11023,
         "number":4
      },{
         "id":11004,
         "number":4
      },{
         "id":11008,
         "number":4
      },{
         "id":11012,
         "number":4
      },{
         "id":11016,
         "number":4
      },{
         "id":11408,
         "number":4
      }]];
       
      
      private var _id:int;
      
      private var _name:String;
      
      private var _difficulty:int;
      
      private var _requiedLevel:int;
      
      private var _description:String;
      
      private var _mapID:int;
      
      private var _commit:int = 0;
      
      private var value1:int;
      
      private var value2:int;
      
      public function FightLibInfo()
      {
         super();
      }
      
      public function get id() : int
      {
         return _id;
      }
      
      public function set id(param1:int) : void
      {
         _id = param1;
      }
      
      public function get name() : String
      {
         return _name;
      }
      
      public function set name(param1:String) : void
      {
         _name = param1;
      }
      
      public function get difficulty() : int
      {
         return _difficulty;
      }
      
      public function set difficulty(param1:int) : void
      {
         _difficulty = param1;
         if(_commit <= 0)
         {
            dispatchEvent(new Event("change"));
         }
      }
      
      public function get requiedLevel() : int
      {
         return _requiedLevel;
      }
      
      public function set requiedLevel(param1:int) : void
      {
         _requiedLevel = param1;
         if(_commit <= 0)
         {
            dispatchEvent(new Event("change"));
         }
      }
      
      public function get description() : String
      {
         return _description;
      }
      
      public function set description(param1:String) : void
      {
         _description = param1;
      }
      
      public function get mapID() : int
      {
         return _mapID;
      }
      
      public function set mapID(param1:int) : void
      {
         _mapID = param1;
      }
      
      public function beginChange() : void
      {
         _commit = Number(_commit) + 1;
      }
      
      public function commitChange() : void
      {
         _commit = Number(_commit) - 1;
         dispatchEvent(new Event("change"));
      }
      
      public function getAwardMedal() : int
      {
         var _loc2_:* = null;
         if(difficulty > -1 && difficulty < 3)
         {
            _loc2_ = getAwardInfoItems();
            var _loc4_:int = 0;
            var _loc3_:* = _loc2_;
            for each(var _loc1_ in _loc2_)
            {
               if(_loc1_.id == -300)
               {
                  return _loc1_.count;
               }
            }
         }
         return 0;
      }
      
      public function getAwardGiftsNum() : int
      {
         var _loc2_:* = null;
         if(difficulty > -1 && difficulty < 3)
         {
            _loc2_ = getAwardInfoItems();
            var _loc4_:int = 0;
            var _loc3_:* = _loc2_;
            for each(var _loc1_ in _loc2_)
            {
               if(_loc1_.id == -300)
               {
                  return _loc1_.count;
               }
            }
         }
         return 0;
      }
      
      public function getAwardEXPNum() : int
      {
         var _loc2_:* = null;
         if(difficulty > -1 && difficulty < 3)
         {
            _loc2_ = getAwardInfoItems();
            var _loc4_:int = 0;
            var _loc3_:* = _loc2_;
            for each(var _loc1_ in _loc2_)
            {
               if(_loc1_.id == 11107)
               {
                  return _loc1_.count;
               }
            }
         }
         return 0;
      }
      
      public function getAwardItems() : Array
      {
         var _loc3_:* = null;
         var _loc1_:Array = [];
         if(difficulty > -1 && difficulty < 3)
         {
            _loc3_ = getAwardInfoItems();
            var _loc5_:int = 0;
            var _loc4_:* = _loc3_;
            for each(var _loc2_ in _loc3_)
            {
               if(_loc2_.id != -300 && _loc2_.id != 11107)
               {
                  _loc1_.push(_loc2_);
               }
            }
         }
         return _loc1_;
      }
      
      private function getAwardInfoItems() : Array
      {
         var _loc1_:* = null;
         var _loc2_:FightLibAwardInfo = FightLibManager.Instance.getFightLibAwardInfoByID(id);
         switch(int(difficulty))
         {
            case 0:
               _loc1_ = _loc2_.easyAward;
               break;
            case 1:
               _loc1_ = _loc2_.normalAward;
               break;
            case 2:
               _loc1_ = _loc2_.difficultAward;
         }
         return _loc1_;
      }
      
      private function initMissionValue() : void
      {
         var _loc1_:String = PlayerManager.Instance.Self.fightLibMission.substr((id - 1000) * 2,2);
         value1 = int(_loc1_.substr(0,1));
         value2 = int(_loc1_.substr(1,1));
      }
      
      public function get InfoCanPlay() : Boolean
      {
         initMissionValue();
         return value1 > 0;
      }
      
      public function get easyCanPlay() : Boolean
      {
         return InfoCanPlay;
      }
      
      public function get normalCanPlay() : Boolean
      {
         initMissionValue();
         return value1 > 1;
      }
      
      public function get difficultCanPlay() : Boolean
      {
         initMissionValue();
         return value1 > 2;
      }
      
      public function get easyAwardGained() : Boolean
      {
         initMissionValue();
         return value2 > 0;
      }
      
      public function get normalAwardGained() : Boolean
      {
         initMissionValue();
         return value2 > 1;
      }
      
      public function get difficultAwardGained() : Boolean
      {
         initMissionValue();
         return value2 > 2;
      }
   }
}
