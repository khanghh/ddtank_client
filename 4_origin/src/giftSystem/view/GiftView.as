package giftSystem.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.player.PlayerInfo;
   import ddt.manager.LanguageMgr;
   import ddt.utils.HelpFrameUtils;
   import flash.display.Sprite;
   
   public class GiftView extends Sprite implements Disposeable
   {
       
      
      private var _giftInfoView:GiftInfoView;
      
      private var _giftShopView:GiftShopView;
      
      private var _helpBtn:BaseButton;
      
      private var _info:PlayerInfo;
      
      public function GiftView()
      {
         super();
         initView();
         initEvent();
      }
      
      public function set info(param1:PlayerInfo) : void
      {
         if(_info == param1)
         {
            return;
         }
         _info = param1;
         _giftInfoView.info = _info;
      }
      
      private function initView() : void
      {
         _giftInfoView = ComponentFactory.Instance.creatCustomObject("giftInfoView");
         _giftShopView = ComponentFactory.Instance.creatCustomObject("giftShopView");
         addChild(_giftInfoView);
         addChild(_giftShopView);
         _helpBtn = HelpFrameUtils.Instance.simpleHelpButton(this,"GiftView.helpBtn",null,LanguageMgr.GetTranslation("ddt.giftSystem.giftView.helpFrameTitle"),"ddtgiftSystem.help.txt",408,488);
      }
      
      private function initEvent() : void
      {
      }
      
      private function removeEvent() : void
      {
      }
      
      public function dispose() : void
      {
         removeEvent();
         if(_giftInfoView)
         {
            _giftInfoView.dispose();
         }
         _giftInfoView = null;
         if(_giftShopView)
         {
            _giftShopView.dispose();
         }
         _giftShopView = null;
         if(_helpBtn)
         {
            ObjectUtils.disposeObject(_helpBtn);
         }
         _helpBtn = null;
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}
