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
      
      public function set id(value:int) : void
      {
         _id = value;
      }
      
      public function get name() : String
      {
         return _name;
      }
      
      public function set name(value:String) : void
      {
         _name = value;
      }
      
      public function get difficulty() : int
      {
         return _difficulty;
      }
      
      public function set difficulty(value:int) : void
      {
         _difficulty = value;
         if(_commit <= 0)
         {
            dispatchEvent(new Event("change"));
         }
      }
      
      public function get requiedLevel() : int
      {
         return _requiedLevel;
      }
      
      public function set requiedLevel(value:int) : void
      {
         _requiedLevel = value;
         if(_commit <= 0)
         {
            dispatchEvent(new Event("change"));
         }
      }
      
      public function get description() : String
      {
         return _description;
      }
      
      public function set description(value:String) : void
      {
         _description = value;
      }
      
      public function get mapID() : int
      {
         return _mapID;
      }
      
      public function set mapID(value:int) : void
      {
         _mapID = value;
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
         var awardItems:* = null;
         if(difficulty > -1 && difficulty < 3)
         {
            awardItems = getAwardInfoItems();
            var _loc4_:int = 0;
            var _loc3_:* = awardItems;
            for each(var item in awardItems)
            {
               if(item.id == -300)
               {
                  return item.count;
               }
            }
         }
         return 0;
      }
      
      public function getAwardGiftsNum() : int
      {
         var awardItems:* = null;
         if(difficulty > -1 && difficulty < 3)
         {
            awardItems = getAwardInfoItems();
            var _loc4_:int = 0;
            var _loc3_:* = awardItems;
            for each(var item in awardItems)
            {
               if(item.id == -300)
               {
                  return item.count;
               }
            }
         }
         return 0;
      }
      
      public function getAwardEXPNum() : int
      {
         var awardItems:* = null;
         if(difficulty > -1 && difficulty < 3)
         {
            awardItems = getAwardInfoItems();
            var _loc4_:int = 0;
            var _loc3_:* = awardItems;
            for each(var item in awardItems)
            {
               if(item.id == 11107)
               {
                  return item.count;
               }
            }
         }
         return 0;
      }
      
      public function getAwardItems() : Array
      {
         var awardItems:* = null;
         var result:Array = [];
         if(difficulty > -1 && difficulty < 3)
         {
            awardItems = getAwardInfoItems();
            var _loc5_:int = 0;
            var _loc4_:* = awardItems;
            for each(var item in awardItems)
            {
               if(item.id != -300 && item.id != 11107)
               {
                  result.push(item);
               }
            }
         }
         return result;
      }
      
      private function getAwardInfoItems() : Array
      {
         var result:* = null;
         var awardInfo:FightLibAwardInfo = FightLibManager.Instance.getFightLibAwardInfoByID(id);
         switch(int(difficulty))
         {
            case 0:
               result = awardInfo.easyAward;
               break;
            case 1:
               result = awardInfo.normalAward;
               break;
            case 2:
               result = awardInfo.difficultAward;
         }
         return result;
      }
      
      private function initMissionValue() : void
      {
         var info:String = PlayerManager.Instance.Self.fightLibMission.substr((id - 1000) * 2,2);
         value1 = int(info.substr(0,1));
         value2 = int(info.substr(1,1));
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
