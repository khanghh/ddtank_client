package homeTemple.view
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SoundManager;
   import ddt.utils.HelpFrameUtils;
   import ddt.utils.PositionUtils;
   import homeTemple.HomeTempleController;
   
   public class HomeTempleFrame extends Frame implements Disposeable
   {
       
      
      private var _btnHelp:BaseButton;
      
      private var _blessing:HomeTempleBlessing;
      
      private var _levelView:HomeTempleLevel;
      
      public function HomeTempleFrame()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__onResponse);
      }
      
      private function initView() : void
      {
         ObjectUtils.disposeObject(_closeButton);
         _btnHelp = HelpFrameUtils.Instance.simpleHelpButton(this,"cardSystem.texpSystem.btnHelp","home.temple.helpBtnPos",LanguageMgr.GetTranslation("store.view.HelpButtonText"),"asset.home.temple.helpInfo",408,488);
         _blessing = new HomeTempleBlessing();
         addToContent(_blessing);
         _levelView = new HomeTempleLevel();
         PositionUtils.setPos(_levelView,"home.temple.blessLevelPos");
         addToContent(_levelView);
      }
      
      protected function __onResponse(param1:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               HomeTempleController.Instance.hide();
         }
      }
      
      public function resetBlessingPos() : void
      {
         _blessing.resetBlessingPos();
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__onResponse);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_btnHelp);
         _btnHelp = null;
         ObjectUtils.disposeObject(_blessing);
         _blessing = null;
         ObjectUtils.disposeObject(_levelView);
         _levelView = null;
         super.dispose();
      }
   }
}
