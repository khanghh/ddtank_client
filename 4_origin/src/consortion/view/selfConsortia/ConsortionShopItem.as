package consortion.view.selfConsortia
{
   import bagAndInfo.cell.BaseCell;
   import baglocked.BaglockedManager;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.bagStore.BagStore;
   import ddt.command.QuickBuyFrame;
   import ddt.data.goods.ItemPrice;
   import ddt.data.goods.ShopItemInfo;
   import ddt.events.ShortcutBuyEvent;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   
   public class ConsortionShopItem extends Sprite implements Disposeable
   {
       
      
      private var _info:ShopItemInfo;
      
      private var _enable:Boolean;
      
      private var _time:int;
      
      private var _bg:ScaleBitmapImage;
      
      private var _cellBG:DisplayObject;
      
      private var _cell:BaseCell;
      
      private var _limitCount:FilterFrameText;
      
      private var _nameTxt:FilterFrameText;
      
      private var _selfRichBg:MutipleImage;
      
      private var _selfRichText:FilterFrameText;
      
      private var _selfRichTxt:FilterFrameText;
      
      private var _btnArr:Vector.<ConsortionShopItemBtn>;
      
      private var _line:MutipleImage;
      
      public function ConsortionShopItem($enable:Boolean)
      {
         super();
         _enable = $enable;
         initView();
      }
      
      override public function get height() : Number
      {
         return _bg.height;
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("shopFrame.ItemBG1");
         _cellBG = ComponentFactory.Instance.creatCustomObject("shopFrame.ItemCellBG");
         _nameTxt = ComponentFactory.Instance.creat("consortion.shopItem.name");
         _selfRichBg = ComponentFactory.Instance.creatComponentByStylename("consortion.shop.selfRichOfferInputBG");
         _selfRichText = ComponentFactory.Instance.creat("consortion.shop.selfRichOfferTxt");
         _selfRichText.text = LanguageMgr.GetTranslation("consortion.shop.selfRichOfferTxt.text");
         _selfRichTxt = ComponentFactory.Instance.creat("consortion.shop.selfRichOffer");
         _line = ComponentFactory.Instance.creatComponentByStylename("consortion.shopFrame.VerticalLine");
         var sprite:Sprite = new Sprite();
         sprite.graphics.beginFill(16777215,0);
         sprite.graphics.drawRect(0,0,48,48);
         sprite.graphics.endFill();
         _cell = new BaseCell(sprite);
         PositionUtils.setPos(_cell,"consortion.shopItem.CellPos");
         _limitCount = ComponentFactory.Instance.creatComponentByStylename("consortion.shopItem.limitCount");
         addChild(_bg);
         addChild(_cellBG);
         addChild(_cell);
         addChild(_limitCount);
         addChild(_nameTxt);
         addChild(_selfRichBg);
         addChild(_selfRichText);
         _selfRichBg.visible = false;
         _selfRichText.visible = false;
         addChild(_selfRichTxt);
         addChild(_line);
         _selfRichTxt.visible = false;
         _btnArr = new Vector.<ConsortionShopItemBtn>(3);
         setFilters = _enable;
         _limitCount.visible = false;
      }
      
      private function removeEvent() : void
      {
         var i:int = 0;
         for(i = 0; i < 3; )
         {
            if(_btnArr[i])
            {
               _btnArr[i].removeEventListener("click",__clickHandler);
            }
            i++;
         }
         if(_info)
         {
            _info.removeEventListener("change",__limitChange);
         }
      }
      
      private function __limitChange(event:Event) : void
      {
         _limitCount.text = String(_info.LimitCount);
      }
      
      public function set setFilters(b:Boolean) : void
      {
         if(b)
         {
            var _loc2_:* = null;
            _bg.filters = _loc2_;
            §§push(_loc2_);
         }
         else
         {
            _loc2_ = ComponentFactory.Instance.creatFilters("grayFilter");
            _bg.filters = _loc2_;
            §§push(_loc2_);
         }
      }
      
      public function set info($info:ShopItemInfo) : void
      {
         if(_info == $info || !$info)
         {
            return;
         }
         if(_info)
         {
            _info.removeEventListener("change",__limitChange);
         }
         _info = $info;
         _info.addEventListener("change",__limitChange);
         upView();
      }
      
      public function set neededRich(num:int) : void
      {
         _selfRichTxt.text = String(num);
      }
      
      private function upView() : void
      {
         var i:int = 0;
         _cell.info = _info.TemplateInfo;
         _nameTxt.text = _info.TemplateInfo.Name;
         _limitCount.text = String(_info.LimitCount);
         _limitCount.visible = _info.TemplateInfo.CategoryID == 14?_info.TemplateID == 14011?false:true:false;
         _limitCount.visible = _info.LimitCount > -1;
         _selfRichBg.visible = true;
         _selfRichText.visible = true;
         _selfRichTxt.visible = true;
         for(i = 0; i < 3; )
         {
            if(_info.getItemPrice(i + 1).IsValid)
            {
               _btnArr[i] = new ConsortionShopItemBtn();
               addChild(_btnArr[i]);
               PositionUtils.setPos(_btnArr[i],"consortion.shopItem.btnPos" + i);
               _btnArr[i].setValue(_info.getItemPrice(i + 1).toString(),_info.getTimeToString(i + 1));
               _btnArr[i].addEventListener("click",__clickHandler);
            }
            i++;
         }
      }
      
      private function __clickHandler(event:MouseEvent) : void
      {
         var type:int = 0;
         var alert:* = null;
         var _quickFrame:* = null;
         SoundManager.instance.play("008");
         var target:ConsortionShopItemBtn = event.currentTarget as ConsortionShopItemBtn;
         _time = _btnArr.indexOf(target) + 1;
         var itemPrice:ItemPrice = _info.getItemPrice(_time);
         if(itemPrice.bothMoneyValue > 0)
         {
            type = 3;
         }
         else if(_info.getItemPrice(_time).bandDdtMoneyValue > 0)
         {
            type = 4;
         }
         else if(itemPrice.badgeValue > 0)
         {
            type = 6;
         }
         else if(itemPrice.gesteValue > 0)
         {
            type = 2;
         }
         if(checkMoney(type))
         {
            if(itemPrice.goldValue > 0)
            {
               alert = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("tank.view.common.AddPricePanel.pay"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,false,false,2);
               alert.addEventListener("response",__onResponse);
               return;
            }
            _quickFrame = ComponentFactory.Instance.creatComponentByStylename("ddtcore.QuickFrame");
            _quickFrame.setTitleText(LanguageMgr.GetTranslation("tank.view.store.matte.goldQuickBuy"));
            _quickFrame.setItemID(_info.TemplateID,type,_time);
            _quickFrame.buyFrom = 0;
            _quickFrame.addEventListener("shortcutBuy",__shortCutBuyHandler);
            _quickFrame.addEventListener("removedFromStage",removeFromStageHandler);
            LayerManager.Instance.addToLayer(_quickFrame,2,true,1);
            if(_info && _info.TemplateID == 11179)
            {
               _quickFrame.hideSelectedBand();
            }
         }
      }
      
      private function removeFromStageHandler(event:Event) : void
      {
         BagStore.instance.reduceTipPanelNumber();
      }
      
      private function __shortCutBuyHandler(evt:ShortcutBuyEvent) : void
      {
         evt.stopImmediatePropagation();
         dispatchEvent(new ShortcutBuyEvent(evt.ItemID,evt.ItemNum));
      }
      
      private function __onResponse(e:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         var alert:BaseAlerFrame = e.currentTarget as BaseAlerFrame;
         alert.removeEventListener("response",__onResponse);
         if(alert.parent)
         {
            alert.parent.removeChild(alert);
         }
         ObjectUtils.disposeObject(alert);
         alert = null;
         if(e.responseCode == 3 || e.responseCode == 2)
         {
            if(_info)
            {
               sendConsortiaShop();
            }
         }
      }
      
      private function sendConsortiaShop() : void
      {
         var items:Array = [_info.GoodsID];
         var types:Array = [_time];
         var colors:Array = [""];
         var dresses:Array = [false];
         var skins:Array = [""];
         var places:Array = [-1];
         SocketManager.Instance.out.sendBuyGoods(items,types,colors,places,dresses,skins);
      }
      
      private function checkMoney(type:int) : Boolean
      {
         var goldAlert:* = null;
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return false;
         }
         if(_info.LimitCount == 0)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("shop.ShopIIModel.countOver"));
            return false;
         }
         if(!_enable)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.consortia.consortiashop.ConsortiaShopItem.checkMoney"));
            return false;
         }
         var price:ItemPrice = _info.getItemPrice(_time);
         if(type == 3)
         {
            if(PlayerManager.Instance.Self.Money < price.bothMoneyValue)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("treasureHunting.tip1"));
               return false;
            }
         }
         else if(type == 6)
         {
            if(PlayerManager.Instance.Self.PropBag.getItemCountByTemplateId(12567) < price.badgeValue)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ConsortiaShopItem.badgebuzu"));
               return false;
            }
         }
         else if(type == 2)
         {
            if(PlayerManager.Instance.Self.Offer < price.gesteValue)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ConsortiaShopItem.gongXunbuzu"));
               return false;
            }
         }
         else if(PlayerManager.Instance.Self.Gold < _info.getItemPrice(_time).goldValue)
         {
            goldAlert = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("tank.view.GoldInadequate"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,false,false,1);
            goldAlert.moveEnable = false;
            goldAlert.addEventListener("response",__quickBuyResponse);
            return false;
         }
         return true;
      }
      
      private function __quickBuyResponse(evt:FrameEvent) : void
      {
         var quickBuy:* = null;
         SoundManager.instance.play("008");
         var frame:BaseAlerFrame = evt.currentTarget as BaseAlerFrame;
         frame.removeEventListener("response",__quickBuyResponse);
         frame.dispose();
         if(frame.parent)
         {
            frame.parent.removeChild(frame);
         }
         frame = null;
         if(evt.responseCode == 3)
         {
            quickBuy = ComponentFactory.Instance.creatComponentByStylename("ddtcore.QuickFrame");
            quickBuy.itemID = 11233;
            quickBuy.setTitleText(LanguageMgr.GetTranslation("tank.view.store.matte.goldQuickBuy"));
            LayerManager.Instance.addToLayer(quickBuy,3,true,1);
         }
      }
      
      public function dispose() : void
      {
         var i:int = 0;
         removeEvent();
         _info = null;
         for(i = 0; i < 3; )
         {
            if(_btnArr[i])
            {
               ObjectUtils.disposeObject(_btnArr[i]);
            }
            _btnArr[i] = null;
            i++;
         }
         ObjectUtils.disposeAllChildren(this);
         _bg = null;
         _cellBG = null;
         _limitCount = null;
         _cell = null;
         _nameTxt = null;
         _selfRichBg = null;
         _selfRichText = null;
         _selfRichTxt = null;
         _line = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
