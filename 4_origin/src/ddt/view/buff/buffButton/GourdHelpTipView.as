package ddt.view.buff.buffButton
{
   import baglocked.BaglockedManager;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class GourdHelpTipView extends Sprite
   {
       
      
      private var _viewBg:ScaleBitmapImage;
      
      private var _stopButton:TextButton;
      
      private var _titleText:FilterFrameText;
      
      private var _precautionsText:FilterFrameText;
      
      public function GourdHelpTipView()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _viewBg = ComponentFactory.Instance.creatComponentByStylename("bagBuffer.gourdHelp.bg");
         _titleText = ComponentFactory.Instance.creat("bagBuffer.gourdHelp.titleText");
         _titleText.text = LanguageMgr.GetTranslation("GourdExpBottle.gourdHelpTipView.titleMsg");
         _precautionsText = ComponentFactory.Instance.creatComponentByStylename("bagBuffer.gourdHelp.precautionsText");
         _precautionsText.text = LanguageMgr.GetTranslation("GourdExpBottle.gourdHelpTipView.precautionsMsg");
         _stopButton = ComponentFactory.Instance.creatComponentByStylename("bagBuffer.gourdHelp.stopBtn");
         _stopButton.text = LanguageMgr.GetTranslation("GourdExpBottle.gourdHelpTipView.stopButtonText");
         _stopButton.addEventListener("click",__onClick);
         addChild(_viewBg);
         addChild(_titleText);
         addChild(_precautionsText);
         addChild(_stopButton);
      }
      
      protected function __onClick(event:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         var frame:BaseAlerFrame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("tips"),LanguageMgr.GetTranslation("GourdExpBottle.gourdHelpTipView.stopMsg"),"",LanguageMgr.GetTranslation("cancel"),true,true,false,2);
         frame.addEventListener("response",__onStopStorage);
      }
      
      protected function __onStopStorage(event:FrameEvent) : void
      {
         var frame:BaseAlerFrame = event.currentTarget as BaseAlerFrame;
         frame.removeEventListener("response",__onStopStorage);
         if(event.responseCode == 3 || event.responseCode == 2)
         {
            SocketManager.Instance.out.sendStopExpStorage(2);
         }
         frame.dispose();
      }
      
      public function dispose() : void
      {
         if(_viewBg)
         {
            ObjectUtils.disposeObject(_viewBg);
            _viewBg = null;
         }
         if(_stopButton)
         {
            ObjectUtils.disposeObject(_stopButton);
            _stopButton = null;
         }
         if(_titleText)
         {
            ObjectUtils.disposeObject(_titleText);
            _titleText = null;
         }
         if(_precautionsText)
         {
            ObjectUtils.disposeObject(_precautionsText);
            _precautionsText = null;
         }
      }
      
      public function get viewBg() : ScaleBitmapImage
      {
         return _viewBg;
      }
   }
}
