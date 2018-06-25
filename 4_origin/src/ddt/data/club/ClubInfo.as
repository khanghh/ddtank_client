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
      
      public function ClubInfo()
      {
         super();
      }
      
      public function set StoreLevel($level:int) : void
      {
         _storeLevel = $level;
         dispatchEvent(new Event("richeschange",true));
      }
      
      public function get StoreLevel() : int
      {
         return _storeLevel;
      }
      
      public function set Riches(i:int) : void
      {
         this._riches = i;
         dispatchEvent(new Event("richeschange",true));
      }
      
      public function get Riches() : int
      {
         return this._riches;
      }
      
      public function get Description() : String
      {
         return _description;
      }
      
      public function set Description(value:String) : void
      {
         if(_description == value)
         {
            return;
         }
         _description = value;
         dispatchEvent(new Event("descriptionchange"));
      }
      
      public function get Placard() : String
      {
         return _placard;
      }
      
      public function set Placard(value:String) : void
      {
         if(_placard == value)
         {
            return;
         }
         _placard = value;
         dispatchEvent(new Event("placardchange"));
      }
   }
}
