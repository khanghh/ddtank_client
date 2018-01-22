package oldPlayerRegress.view.itemView
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SoundManager;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import oldPlayerRegress.RegressControl;
   
   public class WelcomeView extends Frame
   {
       
      
      private var _titleBg:Bitmap;
      
      private var _welTitleImg:ScaleFrameImage;
      
      private var _privilegeBtn:TextButton;
      
      private var _welDescript:FilterFrameText;
      
      private var _firstDesData:FilterFrameText;
      
      private var _scrollPanel:ScrollPanel;
      
      private var _vBox:VBox;
      
      private var _listView:ScrollPanel;
      
      public function WelcomeView(){super();}
      
      private function _init() : void{}
      
      private function initView() : void{}
      
      private function initData() : void{}
      
      private function initEvent() : void{}
      
      protected function __onPrivilegeClick(param1:MouseEvent) : void{}
      
      private function removeEvent() : void{}
      
      public function show() : void{}
      
      override public function dispose() : void{}
   }
}
