package pyramid.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PyramidManager;
   import ddt.manager.SoundManager;
   import ddt.manager.StateManager;
   import ddt.view.SimpleReturnBar;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import pyramid.PyramidControl;
   
   public class PyramidView extends Sprite implements Disposeable
   {
       
      
      private var _bg:Bitmap;
      
      private var _leftView:PyramidLeftView;
      
      private var _returnBtn:SimpleReturnBar;
      
      private var _helpView:PyramidHelpView;
      
      private var _shopView:PyramidShopView;
      
      private var _activeTimeTitle:FilterFrameText;
      
      private var _activeTimeTxt:FilterFrameText;
      
      public function PyramidView(){super();}
      
      private function setActiveTime() : void{}
      
      private function initView() : void{}
      
      private function initEvent() : void{}
      
      private function returnToMain() : void{}
      
      private function removeEvent() : void{}
      
      public function dispose() : void{}
   }
}
