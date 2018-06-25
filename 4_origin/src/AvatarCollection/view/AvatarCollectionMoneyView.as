package AvatarCollection.view
{
   import bagAndInfo.bag.RichesButton;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.events.PlayerPropertyEvent;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.utils.PositionUtils;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   
   public class AvatarCollectionMoneyView extends Sprite implements Disposeable
   {
       
      
      private var _honorBg:MovieClip;
      
      private var _honorTxt:FilterFrameText;
      
      private var _goldBg:MovieClip;
      
      private var _goldTxt:FilterFrameText;
      
      private var _honorButton:RichesButton;
      
      private var _goldButton:RichesButton;
      
      public function AvatarCollectionMoneyView()
      {
         super();
         this.x = 19;
         this.y = 388;
         initView();
         initEvent();
         refreshView();
      }
      
      private function initView() : void
      {
         _honorBg = ComponentFactory.Instance.creat("asset.avatarColl.honorIcon");
         PositionUtils.setPos(_honorBg,"avatarColl.rightView.honorBgPos");
         _honorTxt = ComponentFactory.Instance.creatComponentByStylename("avatarColl.rightView.honorTxt");
         _goldBg = ComponentFactory.Instance.creat("asset.avatarColl.goldIcon");
         PositionUtils.setPos(_goldBg,"avatarColl.rightView.goldBgPos");
         _goldTxt = ComponentFactory.Instance.creatComponentByStylename("avatarColl.rightView.goldTxt");
         _honorButton = ComponentFactory.Instance.creatCustomObject("avatarColl.rightMoneyView.honorButton");
         _honorButton.tipData = LanguageMgr.GetTranslation("ddt.totem.rightView.honorTipTxt");
         _goldButton = ComponentFactory.Instance.creatCustomObject("avatarColl.rightMoneyView.goldButton");
         _goldButton.tipData = LanguageMgr.GetTranslation("tank.view.bagII.MoneyDirections");
         addChild(_honorBg);
         addChild(_honorTxt);
         addChild(_goldBg);
         addChild(_goldTxt);
         addChild(_honorButton);
         addChild(_goldButton);
      }
      
      private function initEvent() : void
      {
         PlayerManager.Instance.Self.addEventListener("propertychange",__propertyChange);
      }
      
      private function __propertyChange(evt:PlayerPropertyEvent) : void
      {
         if(evt.changedProperties["Gold"] || evt.changedProperties["myHonor"])
         {
            refreshView();
         }
      }
      
      private function refreshView() : void
      {
         _honorTxt.text = PlayerManager.Instance.Self.myHonor.toString();
         _goldTxt.text = PlayerManager.Instance.Self.Gold.toString();
      }
      
      private function removeEvent() : void
      {
         PlayerManager.Instance.Self.removeEventListener("propertychange",__propertyChange);
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeAllChildren(this);
         _honorBg = null;
         _honorTxt = null;
         _goldBg = null;
         _goldTxt = null;
         _honorButton = null;
         _goldButton = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
