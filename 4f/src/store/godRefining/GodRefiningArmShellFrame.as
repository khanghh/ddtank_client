package store.godRefining
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.text.FilterFrameText;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import store.godRefining.view.GodRefiningPreItemCell;
   
   public class GodRefiningArmShellFrame extends Frame
   {
       
      
      private var _bg:Bitmap;
      
      private var _unloadBtn:BaseButton;
      
      private var _damageTitleTextArr:Vector.<FilterFrameText>;
      
      private var _damageContentTextArr:Vector.<FilterFrameText>;
      
      private var _levelText:FilterFrameText;
      
      private var _preItemCell:GodRefiningPreItemCell;
      
      public function GodRefiningArmShellFrame(){super();}
      
      override protected function init() : void{}
      
      private function initView() : void{}
      
      private function addEvents() : void{}
      
      private function __responseHandler(param1:FrameEvent) : void{}
      
      private function __unloadBtnHandler(param1:MouseEvent) : void{}
      
      private function removeEvents() : void{}
      
      override public function dispose() : void{}
   }
}
