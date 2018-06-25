package GodSyah
{
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import hallIcon.HallIconManager;
   
   public class SyahControl extends EventDispatcher
   {
      
      private static var _instance:SyahControl;
       
      
      public function SyahControl(instance:SyahInstance)
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
      
      private function __showMainViewHandler(e:Event) : void
      {
         var _view:SyahView = new SyahView();
         _view.init();
         _view.x = -227;
         HallIconManager.instance.showCommonFrame(_view,"wonderfulActivityManager.btnTxt13");
      }
      
      private function __hideMainViewHandler(e:Event) : void
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
