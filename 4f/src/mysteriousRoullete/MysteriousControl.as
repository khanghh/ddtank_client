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
      
      public function MysteriousControl(){super();}
      
      public static function get instance() : MysteriousControl{return null;}
      
      public function setup() : void{}
      
      public function showFrame(param1:MysteriousEvent) : void{}
      
      public function loadMysteriousRouletteModule(param1:Function = null, param2:Array = null) : void{}
      
      private function loadCompleteHandler(param1:UIModuleEvent) : void{}
      
      private function onUimoduleLoadProgress(param1:UIModuleEvent) : void{}
      
      public function setView(param1:MysteriousActivityView) : void{}
      
      public function addMask() : void{}
      
      public function removeMask() : void{}
      
      private function onMaskClick(param1:MouseEvent) : void{}
      
      public function dispose() : void{}
   }
}
