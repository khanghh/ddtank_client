package ddt.data.player
{
   import flash.events.EventDispatcher;
   
   public class AcademyPlayerInfo extends EventDispatcher
   {
       
      
      private var _info:PlayerInfo;
      
      public var Introduction:String;
      
      public var IsPublishEquip:Boolean;
      
      public function AcademyPlayerInfo()
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
