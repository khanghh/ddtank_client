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
      
      public function TrainerLoader(module:String)
      {
         super();
         _module = "trainer" + module;
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
      
      private function __onUIModuleComplete(evt:UIModuleEvent) : void
      {
         UIModuleLoader.Instance.removeEventListener("uiModuleComplete",__onUIModuleComplete);
         if(evt.module == _module)
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
