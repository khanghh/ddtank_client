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
      
      public function FightLibInfo(){super();}
      
      public function get id() : int{return 0;}
      
      public function set id(param1:int) : void{}
      
      public function get name() : String{return null;}
      
      public function set name(param1:String) : void{}
      
      public function get difficulty() : int{return 0;}
      
      public function set difficulty(param1:int) : void{}
      
      public function get requiedLevel() : int{return 0;}
      
      public function set requiedLevel(param1:int) : void{}
      
      public function get description() : String{return null;}
      
      public function set description(param1:String) : void{}
      
      public function get mapID() : int{return 0;}
      
      public function set mapID(param1:int) : void{}
      
      public function beginChange() : void{}
      
      public function commitChange() : void{}
      
      public function getAwardMedal() : int{return 0;}
      
      public function getAwardGiftsNum() : int{return 0;}
      
      public function getAwardEXPNum() : int{return 0;}
      
      public function getAwardItems() : Array{return null;}
      
      private function getAwardInfoItems() : Array{return null;}
      
      private function initMissionValue() : void{}
      
      public function get InfoCanPlay() : Boolean{return false;}
      
      public function get easyCanPlay() : Boolean{return false;}
      
      public function get normalCanPlay() : Boolean{return false;}
      
      public function get difficultCanPlay() : Boolean{return false;}
      
      public function get easyAwardGained() : Boolean{return false;}
      
      public function get normalAwardGained() : Boolean{return false;}
      
      public function get difficultAwardGained() : Boolean{return false;}
   }
}
