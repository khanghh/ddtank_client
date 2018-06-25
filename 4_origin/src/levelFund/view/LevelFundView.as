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
      
      private function setBuyCompleteState(type:int = 0) : void
      {
         if(type > 0)
         {
            _buyCompleteIcon.visible = true;
            PositionUtils.setPos(_buyCompleteIcon,"levelFund.levelFundView.getAwardCompleteIconPos" + type);
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
         var i:int = 0;
         var item:* = null;
         _items = [];
         var dataArr:Array = LevelFundManager.instance.model.dataArr;
         for(i = 0; i < dataArr.length; )
         {
            item = new LevelFundViewItem(i);
            item.y = i * 39;
            _items.push(item);
            _itemsSprite.addChild(item);
            i++;
         }
         _panel.invalidateViewport();
      }
      
      private function updateItems(buyMultiple:int) : void
      {
         var i:int = 0;
         var item:* = null;
         var dataArr:Array = LevelFundManager.instance.model.dataArr;
         for(i = 0; i < _items.length; )
         {
            item = _items[i];
            item.updateView(dataArr[i],buyMultiple);
            i++;
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
      
      private function __buyFundBtnClickHandler(event:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         var buyType:int = 3;
         if(event.target == _buyFundBtn1)
         {
            buyType = 1;
         }
         else if(event.target == _buyFundBtn2)
         {
            buyType = 2;
         }
         showBuyTipFrame(buyType);
      }
      
      private function showBuyTipFrame(buyType:int) : void
      {
         _buyType = buyType;
         var multiple:int = 5;
         if(_buyType == 1)
         {
            multiple = 1;
         }
         else if(_buyType == 2)
         {
            multiple = 3;
         }
         var levelFundPrice:Array = ServerConfigManager.instance.levelFundPrice;
         if(levelFundPrice)
         {
            _buyPrice = int(levelFundPrice[_buyType - 1]);
         }
         var frame:BaseAlerFrame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("tips"),LanguageMgr.GetTranslation("levelFund.buyLevelFund.buyTipTxt",_buyPrice,multiple),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),true,true,true,2,null,"SimpleAlert",60,false,0);
         frame.addEventListener("response",confirmResponse);
      }
      
      private function confirmResponse(e:FrameEvent) : void
      {
         var frame:BaseAlerFrame = e.currentTarget as BaseAlerFrame;
         frame.removeEventListener("response",confirmResponse);
         if(e.responseCode == 2 || e.responseCode == 3)
         {
            CheckMoneyUtils.instance.checkMoney(frame.isBand,_buyPrice,onCheckComplete);
         }
         frame.dispose();
      }
      
      protected function onCheckComplete() : void
      {
         SocketManager.Instance.out.sendBuyLevelFund(CheckMoneyUtils.instance.isBind,_buyType);
      }
      
      private function __buyFundBtnOverHandler(event:MouseEvent) : void
      {
         var multiple:int = 5;
         if(event.target == _buyFundBtn1)
         {
            multiple = 1;
         }
         else if(event.target == _buyFundBtn2)
         {
            multiple = 3;
         }
         updateItems(multiple);
      }
      
      private function __buyFundBtnOutHandler(event:MouseEvent) : void
      {
         updateItems(LevelFundManager.instance.model.getBuyMultiple);
      }
      
      private function __updateViewHandler(event:LevelFundEvent) : void
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
