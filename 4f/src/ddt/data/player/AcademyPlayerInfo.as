package ddt.data.player
{
   import flash.events.EventDispatcher;
   
   public class AcademyPlayerInfo extends EventDispatcher
   {
       
      
      private var _info:PlayerInfo;
      
      public var Introduction:String;
      
      public var IsPublishEquip:Boolean;
      
      public function AcademyPlayerInfo(){super();}
      
      public function set info(param1:PlayerInfo) : void{}
      
      public function get info() : PlayerInfo{return null;}
   }
}
