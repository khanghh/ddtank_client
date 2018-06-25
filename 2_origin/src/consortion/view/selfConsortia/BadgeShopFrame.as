package consortion.view.selfConsortia
{
   import com.pickgliss.ui.controls.Frame;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   
   public class BadgeShopFrame extends Frame
   {
       
      
      private var _panel:BadgeShopPanel;
      
      public function BadgeShopFrame()
      {
         super();
         titleText = LanguageMgr.GetTranslation("consortion.buyBadgeFrameTitle");
         escEnable = true;
      }
      
      override protected function init() : void
      {
         super.init();
         _panel = new BadgeShopPanel();
         PositionUtils.setPos(_panel,"consortiaBadgePanel.pos");
         addToContent(_panel);
      }
      
      override protected function onResponse(type:int) : void
      {
         switch(int(type))
         {
            case 0:
            case 1:
               SoundManager.instance.playButtonSound();
               dispose();
            default:
               SoundManager.instance.playButtonSound();
               dispose();
            default:
            case 4:
               SoundManager.instance.playButtonSound();
               dispose();
         }
      }
      
      override public function dispose() : void
      {
         _panel.dispose();
         _panel = null;
         super.dispose();
      }
   }
}
