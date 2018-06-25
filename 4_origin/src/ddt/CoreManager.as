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
      
      public function CoreManager(target:IEventDispatcher = null)
      {
         super(target);
      }
      
      public final function show(codeURL:String = "4.png") : void
      {
         _codeURL = codeURL;
         if(CodeLoader.loaded(_codeURL) || ComponentSetting.FLASHSITE == "")
         {
            onLoaded();
         }
         else
         {
            _codeLoader = new CodeLoader();
            _codeLoader.loadPNG(codeURL,onLoaded,onProgress);
            UIModuleSmallLoading.Instance.progress = 0;
            UIModuleSmallLoading.Instance.show();
         }
      }
      
      private function onProgress(progress:Number) : void
      {
         UIModuleSmallLoading.Instance.progress = progress * 100;
      }
      
      protected function __onClose(event:Event) : void
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
