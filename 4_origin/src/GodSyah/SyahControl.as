package GodSyah
{
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import hallIcon.HallIconManager;
   
   public class SyahControl extends EventDispatcher
   {
      
      private static var _instance:SyahControl;
       
      
      public function SyahControl(param1:SyahInstance)
      {
         super();
      }
      
      public static function get instance() : SyahControl
      {
         if(_instance == null)
         {
            _instance = new SyahControl(new SyahInstance());
         }
         return _instance;
      }
      
      public function setup() : void
      {
         SyahManager.Instance.addEventListener("showMainView",__showMainViewHandler);
         SyahManager.Instance.addEventListener("hideMainView",__hideMainViewHandler);
      }
      
      private function __showMainViewHandler(param1:Event) : void
      {
         var _loc2_:SyahView = new SyahView();
         _loc2_.init();
         _loc2_.x = -227;
         HallIconManager.instance.showCommonFrame(_loc2_,"wonderfulActivityManager.btnTxt13");
      }
      
      private function __hideMainViewHandler(param1:Event) : void
      {
      }
   }
}

class SyahInstance
{
    
   
   function SyahInstance()
   {
      super();
   }
}
