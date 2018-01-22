package levelFund.view
{
   import baglocked.BaglockedManager;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.ServerConfigManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.CheckMoneyUtils;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import levelFund.LevelFundManager;
   import levelFund.event.LevelFundEvent;
   
   public class LevelFundView extends Sprite implements Disposeable
   {
       
      
      private var _panel:ScrollPanel;
      
      private var _itemsSprite:Sprite;
      
      private var _items:Array;
      
      private var _buyLevelTxt:FilterFrameText;
      
      private var _buyFundBtn1:BaseButton;
      
      private var _buyFundBtn2:BaseButton;
      
      private var _buyFundBtn3:BaseButton;
      
      private var _buyCompleteIcon:Bitmap;
      
      private var _buyType:int = 0;
      
      private var _buyPrice:int = 0;
      
      public function LevelFundView()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _buyLevelTxt = ComponentFactory.Instance.creatComponentByStylename("levelFund.levelFundView.buyLevelTxt");
         _buyLevelTxt.text = LanguageMgr.GetTranslation("levelFund.levelFundView.buyLevelTxtMsg");
         addChild(_buyLevelTxt);
         _buyFundBtn1 = ComponentFactory.Instance.creatComponentByStylename("levelFund.levelFundView.buyFundBtn1");
         _buyFundBtn2 = ComponentFactory.Instance.creatComponentByStylename("levelFund.levelFundView.buyFundBtn2");
         _buyFundBtn3 = ComponentFactory.Instance.creatComponentByStylename("levelFund.levelFundView.buyFundBtn3");
         addChild(_buyFundBtn1);
         addChild(_buyFundBtn2);
         addChild(_buyFundBtn3);
         _buyCompleteIcon = ComponentFactory.Instance.creatBitmap("levelFund.levelFundView.buyCompleteIcon");
         _buyCompleteIcon.visible = false;
         addChild(_buyCompleteIcon);
         _panel = ComponentFactory.Instance.creatComponentByStylename("levelFund.levelFundViewPanel");
         _itemsSprite = new Sprite();
         _panel.setView(_itemsSprite);
         addChild(_panel);
         addItems();
         setBuyCompleteState(LevelFundManager.instance.model.buyType);
         updateItems(LevelFundManager.instance.model.getBuyMultiple);
      }
      
      private function setBuyCompleteState(param1:int = 0) : void
      {
         if(param1 > 0)
         {
            _buyCompleteIcon.visible = true;
            PositionUtils.setPos(_buyCompleteIcon,"levelFund.levelFundView.getAwardCompleteIconPos" + param1);
            _buyFundBtn1.mouseEnabled = false;
            _buyFundBtn2.mouseEnabled = false;
            _buyFundBtn3.mouseEnabled = false;
         }
         else
         {
            _buyFundBtn1.mouseEnabled = true;
            _buyFundBtn2.mouseEnabled = true;
            _buyFundBtn3.mouseEnabled = true;
            _buyCompleteIcon.visible = false;
         }
      }
      
      private function addItems() : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = null;
         _items = [];
         var _loc1_:Array = LevelFundManager.instance.model.dataArr;
         _loc3_ = 0;
         while(_loc3_ < _loc1_.length)
         {
            _loc2_ = new LevelFundViewItem(_loc3_);
            _loc2_.y = _loc3_ * 39;
            _items.push(_loc2_);
            _itemsSprite.addChild(_loc2_);
            _loc3_++;
         }
         _panel.invalidateViewport();
      }
      
      private function updateItems(param1:int) : void
      {
         var _loc4_:int = 0;
         var _loc3_:* = null;
         var _loc2_:Array = LevelFundManager.instance.model.dataArr;
         _loc4_ = 0;
         while(_loc4_ < _items.length)
         {
            _loc3_ = _items[_loc4_];
            _loc3_.updateView(_loc2_[_loc4_],param1);
            _loc4_++;
         }
      }
      
      private function initEvent() : void
      {
         _buyFundBtn1.addEventListener("click",__buyFundBtnClickHandler);
         _buyFundBtn2.addEventListener("click",__buyFundBtnClickHandler);
         _buyFundBtn3.addEventListener("click",__buyFundBtnClickHandler);
         _buyFundBtn1.addEventListener("mouseOver",__buyFundBtnOverHandler);
         _buyFundBtn2.addEventListener("mouseOver",__buyFundBtnOverHandler);
         _buyFundBtn3.addEventListener("mouseOver",__buyFundBtnOverHandler);
         _buyFundBtn1.addEventListener("mouseOut",__buyFundBtnOutHandler);
         _buyFundBtn2.addEventListener("mouseOut",__buyFundBtnOutHandler);
         _buyFundBtn3.addEventListener("mouseOut",__buyFundBtnOutHandler);
         LevelFundManager.instance.addEventListener("update_view",__updateViewHandler);
      }
      
      private function __buyFundBtnClickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         var _loc2_:int = 3;
         if(param1.target == _buyFundBtn1)
         {
            _loc2_ = 1;
         }
         else if(param1.target == _buyFundBtn2)
         {
            _loc2_ = 2;
         }
         showBuyTipFrame(_loc2_);
      }
      
      private function showBuyTipFrame(param1:int) : void
      {
         _buyType = param1;
         var _loc3_:int = 5;
         if(_buyType == 1)
         {
            _loc3_ = 1;
         }
         else if(_buyType == 2)
         {
            _loc3_ = 3;
         }
         var _loc4_:Array = ServerConfigManager.instance.levelFundPrice;
         if(_loc4_)
         {
            _buyPrice = int(_loc4_[_buyType - 1]);
         }
         var _loc2_:BaseAlerFrame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("tips"),LanguageMgr.GetTranslation("levelFund.buyLevelFund.buyTipTxt",_buyPrice,_loc3_),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),true,true,true,2,null,"SimpleAlert",60,false,0);
         _loc2_.addEventListener("response",confirmResponse);
      }
      
      private function confirmResponse(param1:FrameEvent) : void
      {
         var _loc2_:BaseAlerFrame = param1.currentTarget as BaseAlerFrame;
         _loc2_.removeEventListener("response",confirmResponse);
         if(param1.responseCode == 2 || param1.responseCode == 3)
         {
            CheckMoneyUtils.instance.checkMoney(_loc2_.isBand,_buyPrice,onCheckComplete);
         }
         _loc2_.dispose();
      }
      
      protected function onCheckComplete() : void
      {
         SocketManager.Instance.out.sendBuyLevelFund(CheckMoneyUtils.instance.isBind,_buyType);
      }
      
      private function __buyFundBtnOverHandler(param1:MouseEvent) : void
      {
         var _loc2_:int = 5;
         if(param1.target == _buyFundBtn1)
         {
            _loc2_ = 1;
         }
         else if(param1.target == _buyFundBtn2)
         {
            _loc2_ = 3;
         }
         updateItems(_loc2_);
      }
      
      private function __buyFundBtnOutHandler(param1:MouseEvent) : void
      {
         updateItems(LevelFundManager.instance.model.getBuyMultiple);
      }
      
      private function __updateViewHandler(param1:LevelFundEvent) : void
      {
         setBuyCompleteState(LevelFundManager.instance.model.buyType);
         updateItems(LevelFundManager.instance.model.getBuyMultiple);
      }
      
      private function removeEvent() : void
      {
         _buyFundBtn1.removeEventListener("click",__buyFundBtnClickHandler);
         _buyFundBtn2.removeEventListener("click",__buyFundBtnClickHandler);
         _buyFundBtn3.removeEventListener("click",__buyFundBtnClickHandler);
         _buyFundBtn1.removeEventListener("mouseOver",__buyFundBtnOverHandler);
         _buyFundBtn2.removeEventListener("mouseOver",__buyFundBtnOverHandler);
         _buyFundBtn3.removeEventListener("mouseOver",__buyFundBtnOverHandler);
         _buyFundBtn1.removeEventListener("mouseOut",__buyFundBtnOutHandler);
         _buyFundBtn2.removeEventListener("mouseOut",__buyFundBtnOutHandler);
         _buyFundBtn3.removeEventListener("mouseOut",__buyFundBtnOutHandler);
         LevelFundManager.instance.removeEventListener("update_view",__updateViewHandler);
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_buyLevelTxt);
         _buyLevelTxt = null;
         ObjectUtils.disposeObject(_buyCompleteIcon);
         _buyCompleteIcon = null;
         ObjectUtils.disposeObject(_panel);
         _panel = null;
         ObjectUtils.disposeAllChildren(_itemsSprite);
         ObjectUtils.disposeObject(_itemsSprite);
         _itemsSprite = null;
         ObjectUtils.disposeObject(_buyFundBtn1);
         _buyFundBtn1 = null;
         ObjectUtils.disposeObject(_buyFundBtn2);
         _buyFundBtn2 = null;
         ObjectUtils.disposeObject(_buyFundBtn3);
         _buyFundBtn3 = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
