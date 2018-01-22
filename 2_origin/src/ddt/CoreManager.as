package ddt
{
   import com.pickgliss.loader.CodeLoader;
   import com.pickgliss.ui.ComponentSetting;
   import ddt.view.UIModuleSmallLoading;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   
   public class CoreManager extends EventDispatcher
   {
       
      
      private var _codeLoader:CodeLoader;
      
      private var _codeURL:String;
      
      public function CoreManager(param1:IEventDispatcher = null)
      {
         super(param1);
      }
      
      public final function show(param1:String = "4.png") : void
      {
         _codeURL = param1;
         if(CodeLoader.loaded(_codeURL) || ComponentSetting.FLASHSITE == "")
         {
            onLoaded();
         }
         else
         {
            _codeLoader = new CodeLoader();
            _codeLoader.loadPNG(param1,onLoaded,onProgress);
            UIModuleSmallLoading.Instance.progress = 0;
            UIModuleSmallLoading.Instance.show();
         }
      }
      
      private function onProgress(param1:Number) : void
      {
         UIModuleSmallLoading.Instance.progress = param1 * 100;
      }
      
      protected function __onClose(param1:Event) : void
      {
         _codeLoader.stop();
         CodeLoader.removeURL(_codeURL);
         UIModuleSmallLoading.Instance.hide();
         UIModuleSmallLoading.Instance.removeEventListener("close",__onClose);
      }
      
      protected function onLoaded() : void
      {
         UIModuleSmallLoading.Instance.hide();
         dispatchEvent(new Event("complete"));
         start();
      }
      
      protected function start() : void
      {
      }
   }
}
