package mysteriousRoullete
{
   import com.pickgliss.events.UIModuleEvent;
   import com.pickgliss.loader.UIModuleLoader;
   import com.pickgliss.ui.LayerManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.view.UIModuleSmallLoading;
   import flash.display.Sprite;
   import flash.events.EventDispatcher;
   import flash.events.MouseEvent;
   import hallIcon.HallIconManager;
   import mysteriousRoullete.event.MysteriousEvent;
   import mysteriousRoullete.view.MysteriousActivityView;
   
   public class MysteriousControl extends EventDispatcher
   {
      
      private static var _instance:MysteriousControl;
       
      
      public var mysteriousView:MysteriousActivityView;
      
      private var _func:Function;
      
      private var _funcParams:Array;
      
      private var _mask:Sprite;
      
      public function MysteriousControl()
      {
         super();
      }
      
      public static function get instance() : MysteriousControl
      {
         if(!_instance)
         {
            _instance = new MysteriousControl();
         }
         return _instance;
      }
      
      public function setup() : void
      {
         MysteriousManager.instance.addEventListener("showView",showFrame);
      }
      
      public function showFrame(e:MysteriousEvent) : void
      {
         var _view:MysteriousActivityView = new MysteriousActivityView();
         _view.init();
         _view.x = -227;
         HallIconManager.instance.showCommonFrame(_view,"wonderfulActivityManager.btnTxt14");
      }
      
      public function loadMysteriousRouletteModule(complete:Function = null, completeParams:Array = null) : void
      {
         _func = complete;
         _funcParams = completeParams;
         UIModuleSmallLoading.Instance.progress = 0;
         UIModuleSmallLoading.Instance.show();
         UIModuleLoader.Instance.addEventListener("uiModuleComplete",loadCompleteHandler);
         UIModuleLoader.Instance.addEventListener("uiMoudleProgress",onUimoduleLoadProgress);
         UIModuleLoader.Instance.addUIModuleImp("mysteriousRoulette");
      }
      
      private function loadCompleteHandler(event:UIModuleEvent) : void
      {
         if(event.module == "mysteriousRoulette")
         {
            UIModuleSmallLoading.Instance.hide();
            UIModuleLoader.Instance.removeEventListener("uiModuleComplete",loadCompleteHandler);
            UIModuleLoader.Instance.removeEventListener("uiMoudleProgress",onUimoduleLoadProgress);
            if(null != _func)
            {
               _func.apply(null,_funcParams);
            }
            _func = null;
            _funcParams = null;
         }
      }
      
      private function onUimoduleLoadProgress(event:UIModuleEvent) : void
      {
         if(event.module == "mysteriousRoulette")
         {
            UIModuleSmallLoading.Instance.progress = event.loader.progress * 100;
         }
      }
      
      public function setView(view:MysteriousActivityView) : void
      {
         mysteriousView = view;
      }
      
      public function addMask() : void
      {
         if(_mask == null)
         {
            _mask = new Sprite();
            _mask.graphics.beginFill(0,0);
            _mask.graphics.drawRect(0,0,2000,1200);
            _mask.graphics.endFill();
            _mask.addEventListener("click",onMaskClick);
         }
         LayerManager.Instance.addToLayer(_mask,2,false,2);
      }
      
      public function removeMask() : void
      {
         if(_mask != null)
         {
            _mask.parent.removeChild(_mask);
            _mask.removeEventListener("click",onMaskClick);
            _mask = null;
         }
      }
      
      private function onMaskClick(event:MouseEvent) : void
      {
         MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("mysteriousRoulette.running"));
      }
      
      public function dispose() : void
      {
         mysteriousView = null;
      }
   }
}
