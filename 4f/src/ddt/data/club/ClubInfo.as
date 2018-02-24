package ddt.data.club
{
   import flash.events.Event;
   import flash.events.EventDispatcher;
   
   public class ClubInfo extends EventDispatcher
   {
      
      public static const DESCRIPTION_CHANGE:String = "descriptionchange";
      
      public static const PLACARD_CHANGE:String = "placardchange";
      
      public static const RICHES_CHANGE:String = "richeschange";
       
      
      public var ConsortiaID:int;
      
      public var ConsortiaName:String = "";
      
      public var CreatorID:int;
      
      public var CreatorName:String = "";
      
      public var ChairmanID:int;
      
      public var ChairmanName:String = "";
      
      public var Level:int;
      
      public var MaxCount:int;
      
      public var CelebCount:int;
      
      public var BuildDate:String = "";
      
      public var IP:String;
      
      public var Port:int;
      
      public var Count:int;
      
      public var Repute:int;
      
      public var IsApply:Boolean;
      
      public var State:int;
      
      public var DeductDate:String;
      
      public var Honor:int;
      
      public var LastDayRiches:int;
      
      public var OpenApply:Boolean;
      
      public var FightPower:int;
      
      private var _storeLevel:int;
      
      public var SmithLevel:int;
      
      public var ShopLevel:int;
      
      private var _riches:int;
      
      private var _description:String;
      
      private var _placard:String = "";
      
      public function ClubInfo(){super();}
      
      public function set StoreLevel(param1:int) : void{}
      
      public function get StoreLevel() : int{return 0;}
      
      public function set Riches(param1:int) : void{}
      
      public function get Riches() : int{return 0;}
      
      public function get Description() : String{return null;}
      
      public function set Description(param1:String) : void{}
      
      public function get Placard() : String{return null;}
      
      public function set Placard(param1:String) : void{}
   }
}
