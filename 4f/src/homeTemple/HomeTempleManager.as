package homeTemple
{
   import ddt.events.CEvent;
   import ddt.utils.AssetModuleLoader;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.events.EventDispatcher;
   
   public class HomeTempleManager extends EventDispatcher
   {
      
      public static const SHOW:String = "ht_show";
      
      public static const HIDE:String = "ht_hide";
      
      private static var instance:HomeTempleManager;
       
      
      private var _con:DisplayObjectContainer;
      
      public function HomeTempleManager(param1:inner){super();}
      
      public static function getInstance() : HomeTempleManager{return null;}
      
      public function show() : void{}
      
      protected function start() : void{}
      
      public function setContainer(param1:DisplayObjectContainer) : void{}
      
      public function setView(param1:DisplayObject) : void{}
      
      public function removeView() : void{}
   }
}

class inner
{
    
   
   function inner(){super();}
}
