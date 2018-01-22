package room.model
{
   import ddt.events.WebSpeedEvent;
   import ddt.manager.LanguageMgr;
   import flash.events.EventDispatcher;
   
   [Event(name="stateChange",type="tank.view.game.webspeed.WebSpeedEvent")]
   public class WebSpeedInfo extends EventDispatcher
   {
      
      public static const BEST:String = LanguageMgr.GetTranslation("tank.data.WebSpeedInfo.good");
      
      public static const BETTER:String = LanguageMgr.GetTranslation("tank.data.WebSpeedInfo.find");
      
      public static const WORST:String = LanguageMgr.GetTranslation("tank.data.WebSpeedInfo.bad");
       
      
      private var _fps:int;
      
      private var _delay:int;
      
      public function WebSpeedInfo(param1:int)
      {
         super();
         _delay = param1;
      }
      
      public function get fps() : int
      {
         return _fps;
      }
      
      public function set fps(param1:int) : void
      {
         if(_fps == param1)
         {
            return;
         }
         _fps = param1;
         dispatchEvent(new WebSpeedEvent("stateChange"));
      }
      
      public function get delay() : int
      {
         return _delay;
      }
      
      public function set delay(param1:int) : void
      {
         if(_delay == param1)
         {
            return;
         }
         _delay = param1;
         dispatchEvent(new WebSpeedEvent("stateChange"));
      }
      
      public function get stateId() : int
      {
         if(_delay > 600)
         {
            return 3;
         }
         if(_delay > 300)
         {
            return 2;
         }
         return 1;
      }
      
      public function get state() : String
      {
         if(_delay > 600)
         {
            return WORST;
         }
         if(_delay > 300)
         {
            return BETTER;
         }
         return BEST;
      }
   }
}
