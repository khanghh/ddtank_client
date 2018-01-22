package ddt.loader
{
   import com.pickgliss.events.UIModuleEvent;
   import com.pickgliss.loader.UIModuleLoader;
   import com.pickgliss.ui.core.Disposeable;
   import flash.events.EventDispatcher;
   
   public class TrainerLoader extends EventDispatcher implements Disposeable
   {
       
      
      private var _module:String;
      
      private var _loadCompleted:Boolean;
      
      public function TrainerLoader(param1:String)
      {
         super();
         _module = "trainer" + param1;
      }
      
      public function get completed() : Boolean
      {
         return _loadCompleted;
      }
      
      public function load() : void
      {
         UIModuleLoader.Instance.addEventListener("uiModuleComplete",__onUIModuleComplete);
         UIModuleLoader.Instance.addUIModuleImp(_module);
      }
      
      private function __onUIModuleComplete(param1:UIModuleEvent) : void
      {
         UIModuleLoader.Instance.removeEventListener("uiModuleComplete",__onUIModuleComplete);
         if(param1.module == _module)
         {
            _loadCompleted = true;
         }
      }
      
      public function dispose() : void
      {
         UIModuleLoader.Instance.removeEventListener("uiModuleComplete",__onUIModuleComplete);
      }
   }
}
