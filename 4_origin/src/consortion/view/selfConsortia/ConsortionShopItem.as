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
      
      public function ConsortionShopItem(param1:Boolean)
      {
         super();
         _enable = param1;
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
         var _loc1_:Sprite = new Sprite();
         _loc1_.graphics.beginFill(16777215,0);
         _loc1_.graphics.drawRect(0,0,48,48);
         _loc1_.graphics.endFill();
         _cell = new BaseCell(_loc1_);
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
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < 3)
         {
            if(_btnArr[_loc1_])
            {
               _btnArr[_loc1_].removeEventListener("click",__clickHandler);
            }
            _loc1_++;
         }
         if(_info)
         {
            _info.removeEventListener("change",__limitChange);
         }
      }
      
      private function __limitChange(param1:Event) : void
      {
         _limitCount.text = String(_info.LimitCount);
      }
      
      public function set setFilters(param1:Boolean) : void
      {
         if(param1)
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
      
      public function set info(param1:ShopItemInfo) : void
      {
         if(_info == param1 || !param1)
         {
            return;
         }
         if(_info)
         {
            _info.removeEventListener("change",__limitChange);
         }
         _info = param1;
         _info.addEventListener("change",__limitChange);
         upView();
      }
      
      public function set neededRich(param1:int) : void
      {
         _selfRichTxt.text = String(param1);
      }
      
      private function upView() : void
      {
         var _loc1_:int = 0;
         _cell.info = _info.TemplateInfo;
         _nameTxt.text = _info.TemplateInfo.Name;
         _limitCount.text = String(_info.LimitCount);
         _limitCount.visible = _info.TemplateInfo.CategoryID == 14?_info.TemplateID == 14011?false:true:false;
         _limitCount.visible = _info.LimitCount > -1;
         _selfRichBg.visible = true;
         _selfRichText.visible = true;
         _selfRichTxt.visible = true;
         _loc1_ = 0;
         while(_loc1_ < 3)
         {
            if(_info.getItemPrice(_loc1_ + 1).IsValid)
            {
               _btnArr[_loc1_] = new ConsortionShopItemBtn();
               addChild(_btnArr[_loc1_]);
               PositionUtils.setPos(_btnArr[_loc1_],"consortion.shopItem.btnPos" + _loc1_);
               _btnArr[_loc1_].setValue(_info.getItemPrice(_loc1_ + 1).toString(),_info.getTimeToString(_loc1_ + 1));
               _btnArr[_loc1_].addEventListener("click",__clickHandler);
            }
            _loc1_++;
         }
      }
      
      private function __clickHandler(param1:MouseEvent) : void
      {
         var _loc5_:int = 0;
         var _loc2_:* = null;
         var _loc4_:* = null;
         SoundManager.instance.play("008");
         var _loc3_:ConsortionShopItemBtn = param1.currentTarget as ConsortionShopItemBtn;
         _time = _btnArr.indexOf(_loc3_) + 1;
         var _loc6_:ItemPrice = _info.getItemPrice(_time);
         if(_loc6_.bothMoneyValue > 0)
         {
            _loc5_ = 3;
         }
         else if(_info.getItemPrice(_time).bandDdtMoneyValue > 0)
         {
            _loc5_ = 4;
         }
         else if(_loc6_.badgeValue > 0)
         {
            _loc5_ = 6;
         }
         else if(_loc6_.gesteValue > 0)
         {
            _loc5_ = 2;
         }
         if(checkMoney(_loc5_))
         {
            if(_loc6_.goldValue > 0)
            {
               _loc2_ = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("tank.view.common.AddPricePanel.pay"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,false,false,2);
               _loc2_.addEventListener("response",__onResponse);
               return;
            }
            _loc4_ = ComponentFactory.Instance.creatComponentByStylename("ddtcore.QuickFrame");
            _loc4_.setTitleText(LanguageMgr.GetTranslation("tank.view.store.matte.goldQuickBuy"));
            _loc4_.setItemID(_info.TemplateID,_loc5_,_time);
            _loc4_.buyFrom = 0;
            _loc4_.addEventListener("shortcutBuy",__shortCutBuyHandler);
            _loc4_.addEventListener("removedFromStage",removeFromStageHandler);
            LayerManager.Instance.addToLayer(_loc4_,2,true,1);
            if(_info && _info.TemplateID == 11179)
            {
               _loc4_.hideSelectedBand();
            }
         }
      }
      
      private function removeFromStageHandler(param1:Event) : void
      {
         BagStore.instance.reduceTipPanelNumber();
      }
      
      private function __shortCutBuyHandler(param1:ShortcutBuyEvent) : void
      {
         param1.stopImmediatePropagation();
         dispatchEvent(new ShortcutBuyEvent(param1.ItemID,param1.ItemNum));
      }
      
      private function __onResponse(param1:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         var _loc2_:BaseAlerFrame = param1.currentTarget as BaseAlerFrame;
         _loc2_.removeEventListener("response",__onResponse);
         if(_loc2_.parent)
         {
            _loc2_.parent.removeChild(_loc2_);
         }
         ObjectUtils.disposeObject(_loc2_);
         _loc2_ = null;
         if(param1.responseCode == 3 || param1.responseCode == 2)
         {
            if(_info)
            {
               sendConsortiaShop();
            }
         }
      }
      
      private function sendConsortiaShop() : void
      {
         var _loc1_:Array = [_info.GoodsID];
         var _loc5_:Array = [_time];
         var _loc2_:Array = [""];
         var _loc3_:Array = [false];
         var _loc6_:Array = [""];
         var _loc4_:Array = [-1];
         SocketManager.Instance.out.sendBuyGoods(_loc1_,_loc5_,_loc2_,_loc4_,_loc3_,_loc6_);
      }
      
      private function checkMoney(param1:int) : Boolean
      {
         var _loc2_:* = null;
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
         var _loc3_:ItemPrice = _info.getItemPrice(_time);
         if(param1 == 3)
         {
            if(PlayerManager.Instance.Self.Money < _loc3_.bothMoneyValue)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("treasureHunting.tip1"));
               return false;
            }
         }
         else if(param1 == 6)
         {
            if(PlayerManager.Instance.Self.PropBag.getItemCountByTemplateId(12567) < _loc3_.badgeValue)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ConsortiaShopItem.badgebuzu"));
               return false;
            }
         }
         else if(param1 == 2)
         {
            if(PlayerManager.Instance.Self.Offer < _loc3_.gesteValue)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ConsortiaShopItem.gongXunbuzu"));
               return false;
            }
         }
         else if(PlayerManager.Instance.Self.Gold < _info.getItemPrice(_time).goldValue)
         {
            _loc2_ = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("tank.view.GoldInadequate"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,false,false,1);
            _loc2_.moveEnable = false;
            _loc2_.addEventListener("response",__quickBuyResponse);
            return false;
         }
         return true;
      }
      
      private function __quickBuyResponse(param1:FrameEvent) : void
      {
         var _loc3_:* = null;
         SoundManager.instance.play("008");
         var _loc2_:BaseAlerFrame = param1.currentTarget as BaseAlerFrame;
         _loc2_.removeEventListener("response",__quickBuyResponse);
         _loc2_.dispose();
         if(_loc2_.parent)
         {
            _loc2_.parent.removeChild(_loc2_);
         }
         _loc2_ = null;
         if(param1.responseCode == 3)
         {
            _loc3_ = ComponentFactory.Instance.creatComponentByStylename("ddtcore.QuickFrame");
            _loc3_.itemID = 11233;
            _loc3_.setTitleText(LanguageMgr.GetTranslation("tank.view.store.matte.goldQuickBuy"));
            LayerManager.Instance.addToLayer(_loc3_,3,true,1);
         }
      }
      
      public function dispose() : void
      {
         var _loc1_:int = 0;
         removeEvent();
         _info = null;
         _loc1_ = 0;
         while(_loc1_ < 3)
         {
            if(_btnArr[_loc1_])
            {
               ObjectUtils.disposeObject(_btnArr[_loc1_]);
            }
            _btnArr[_loc1_] = null;
            _loc1_++;
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
