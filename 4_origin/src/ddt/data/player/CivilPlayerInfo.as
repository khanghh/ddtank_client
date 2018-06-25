package ddt.data.player
{
   import flash.events.EventDispatcher;
   
   public class CivilPlayerInfo extends EventDispatcher
   {
       
      
      private var _info:PlayerInfo;
      
      public var MarryInfoID:int;
      
      public var IsPublishEquip:Boolean;
      
      public var Introduction:String;
      
      public var IsConsortia:Boolean;
      
      public var UserId:Number;
      
      public function CivilPlayerInfo()
      {
         super();
      }
      
      public function set info($info:PlayerInfo) : void
      {
         _info = $info;
      }
      
      public function get info() : PlayerInfo
      {
         return _info;
      }
   }
}
