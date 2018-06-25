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
      
      public function HomeTempleManager(single:inner)
      {
         super();
      }
      
      public static function getInstance() : HomeTempleManager
      {
         if(!instance)
         {
            instance = new HomeTempleManager(new inner());
         }
         return instance;
      }
      
      public function show() : void
      {
         AssetModuleLoader.addModelLoader("homeTemple",6);
         AssetModuleLoader.startCodeLoader(start);
      }
      
      protected function start() : void
      {
         dispatchEvent(new CEvent("ht_show"));
      }
      
      public function setContainer(con:DisplayObjectContainer) : void
      {
         _con = con;
      }
      
      public function setView(view:DisplayObject) : void
      {
         if(_con)
         {
            _con.addChild(view);
         }
      }
      
      public function removeView() : void
      {
         _con = null;
         dispatchEvent(new CEvent("ht_hide"));
      }
   }
}

class inner
{
    
   
   function inner()
   {
      super();
   }
}
