package panicBuying.components
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.data.goods.Price;
   import ddt.data.goods.ShopCarItemInfo;
   import ddt.data.goods.ShopItemInfo;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.ShopManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import panicBuying.data.PBuyingItemInfo;
   import panicBuying.views.PanicBuyingBuyView;
   import panicBuying.views.PanicBuyingCell;
   import shop.manager.ShopBuyManager;
   import shop.manager.ShopGiftsManager;
   
   public class PanicBuyingItem extends Sprite implements Disposeable
   {
       
      
      private var _bg:Bitmap;
      
      private var _title:FilterFrameText;
      
      private var _countTxt:FilterFrameText;
      
      private var _bagCell:PanicBuyingCell;
      
      private var _originalPrice:FilterFrameText;
      
      private var _delLine:Shape;
      
      private var _price:FilterFrameText;
      
      private var _payType:ScaleFrameImage;
      
      private var _entireRemainTxt:FilterFrameText;
      
      private var _giveBtn:SimpleBitmapButton;
      
      private var _askForBtn:SimpleBitmapButton;
      
      private var _buyBtn:SimpleBitmapButton;
      
      private var _tipSprite:Component;
      
      private var _vip:Bitmap;
      
      private var _tag:Bitmap;
      
      private var _levelTxt:FilterFrameText;
      
      private var _type:int;
      
      private var _templateId:int;
      
      private var _info:PBuyingItemInfo;
      
      public function PanicBuyingItem()
      {
         super();
         initView();
         addEvents();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creat("panicBuying.itemBg");
         addChild(_bg);
         _title = ComponentFactory.Instance.creatComponentByStylename("panicBuying.itemTitle");
         addChild(_title);
         _countTxt = ComponentFactory.Instance.creatComponentByStylename("panicBuying.countTxt");
         addChild(_countTxt);
         _originalPrice = ComponentFactory.Instance.creatComponentByStylename("panicBuying.originalPrice");
         addChild(_originalPrice);
         _delLine = DeleteLineUtil.newDeleteLine(_originalPrice);
         addChild(_delLine);
         _price = ComponentFactory.Instance.creatComponentByStylename("panicBuying.price");
         addChild(_price);
         _payType = ComponentFactory.Instance.creatComponentByStylename("ddtshop.GoodPayTypeLabel");
         addChild(_payType);
         _payType.setFrame(2);
         PositionUtils.setPos(_payType,"panicBuying.payTypePos");
         _giveBtn = ComponentFactory.Instance.creatComponentByStylename("panicBuying.giveBtn");
         addChild(_giveBtn);
         _askForBtn = ComponentFactory.Instance.creatComponentByStylename("panicBuying.askForBtn");
         addChild(_askForBtn);
         _buyBtn = ComponentFactory.Instance.creatComponentByStylename("panicBuying.buyBtn");
         addChild(_buyBtn);
         _entireRemainTxt = ComponentFactory.Instance.creat("entire.remainTxt");
         addChild(_entireRemainTxt);
         _tipSprite = new Component();
         _tipSprite.graphics.beginFill(0,0);
         _tipSprite.graphics.drawRect(0,0,_buyBtn.width,_buyBtn.height);
         _tipSprite.graphics.endFill();
         _tipSprite.width = _buyBtn.width;
         _tipSprite.height = _buyBtn.height;
         _tipSprite.x = _buyBtn.x;
         _tipSprite.y = _buyBtn.y;
         _tipSprite.tipStyle = "ddt.view.tips.OneLineTip";
         _tipSprite.tipDirctions = "3";
         _tipSprite.visible = false;
         addChild(_tipSprite);
      }
      
      private function addEvents() : void
      {
         _buyBtn.addEventListener("click",__buyBtnClick);
         _askForBtn.addEventListener("click",__askForBtnClick);
         _giveBtn.addEventListener("click",__giveBtnClick);
      }
      
      protected function __giveBtnClick(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         ShopGiftsManager.Instance.buy(_info.goodsId,true,2);
      }
      
      protected function __askForBtnClick(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         ShopBuyManager.Instance.buy(_info.goodsId,2,3);
      }
      
      protected function __buyBtnClick(event:MouseEvent) : void
      {
         var _view:* = null;
         var isBind:Boolean = false;
         SoundManager.instance.play("008");
         Price.ONLYMONEY = _info.priceType == -8?true:false;
         if(!(int(_type) - 2))
         {
            ShopBuyManager.Instance.buy(_info.goodsId,2,_info.priceType);
         }
         else
         {
            _view = new PanicBuyingBuyView(_info.priceType);
            LayerManager.Instance.addToLayer(_view,3,true,1);
            _view.info = _info;
            _view.goodsID = _templateId;
            if(_info.remain > 0)
            {
               _view.numberSelecter.valueLimit = "1," + _info.remain;
            }
            _view.numberSelecter.validate();
         }
      }
      
      public function setData(info:PBuyingItemInfo, $curType:int) : void
      {
         var shopItemInfo:* = null;
         var shopItem:* = null;
         ObjectUtils.disposeObject(_vip);
         _vip = null;
         ObjectUtils.disposeObject(_tag);
         _tag = null;
         ObjectUtils.disposeObject(_levelTxt);
         _levelTxt = null;
         ObjectUtils.disposeObject(_bagCell);
         _bagCell = null;
         var flag:* = info.templateId != 0;
         _entireRemainTxt.visible = false;
         var _loc7_:* = flag;
         _payType.visible = _loc7_;
         _loc7_ = _loc7_;
         _buyBtn.visible = _loc7_;
         _loc7_ = _loc7_;
         _askForBtn.visible = _loc7_;
         _loc7_ = _loc7_;
         _giveBtn.visible = _loc7_;
         _loc7_ = _loc7_;
         _price.visible = _loc7_;
         _loc7_ = _loc7_;
         _delLine.visible = _loc7_;
         _loc7_ = _loc7_;
         _originalPrice.visible = _loc7_;
         _loc7_ = _loc7_;
         _countTxt.visible = _loc7_;
         _title.visible = _loc7_;
         if(!flag)
         {
            return;
         }
         _templateId = info.templateId;
         _info = info;
         _payType.setFrame(_info.priceType == -8?2:Number(_info.priceType == -9?1:2));
         _price.text = _info.price.toString();
         _originalPrice.text = LanguageMgr.GetTranslation("panicBuying.originalPrice",_info.originalPrice);
         DeleteLineUtil.setDeleteLine(_delLine,_originalPrice);
         _loc7_ = _info.originalPrice > 0;
         _delLine.visible = _loc7_;
         _originalPrice.visible = _loc7_;
         var template:ItemTemplateInfo = ItemManager.Instance.getTemplateById(_templateId);
         _title.text = template.Name;
         _bagCell = new PanicBuyingCell(0,template,info.buyType,info.unitCount);
         addChild(_bagCell);
         _bagCell.setContentSize(65,65);
         _bagCell.setBgVisible(false);
         PositionUtils.setPos(_bagCell,"panicBuying.bagCellPos");
         if($curType == 2)
         {
            shopItemInfo = ShopManager.Instance.getShopItemByGoodsID(_info.goodsId);
            if(!shopItemInfo)
            {
               shopItemInfo = ShopManager.Instance.getGoodsByTemplateID(_info.goodsId);
            }
            if(shopItemInfo.buyTypeToString == "个")
            {
               _bagCell.setCount(shopItemInfo.AUnit);
            }
            else
            {
               _bagCell.setCount(1);
            }
         }
         else
         {
            shopItem = new ShopCarItemInfo(0,_templateId);
            shopItem.APrice1 = _info.priceType;
            shopItem.APrice2 = _info.priceType;
            shopItem.APrice3 = _info.priceType;
            shopItem.BuyType = _info.buyType;
            shopItem.AUnit = _info.unitCount;
            shopItem.AValue1 = _info.price;
            shopItem.BUnit = -1;
            shopItem.CUnit = -1;
            if(shopItem.buyTypeToString == "个")
            {
               _bagCell.setCount(_info.unitCount);
            }
            else
            {
               _bagCell.setCount(info.count);
            }
         }
         if($curType == 2)
         {
            _type = 2;
            _giveBtn.visible = false;
            _askForBtn.visible = false;
            _countTxt.visible = false;
         }
         else if($curType == 4)
         {
            _type = 4;
            _entireRemainTxt.visible = true;
            _giveBtn.visible = false;
            _askForBtn.visible = false;
            _countTxt.visible = false;
         }
         else
         {
            _giveBtn.visible = false;
            _askForBtn.visible = false;
            _countTxt.text = _info.remain + "/" + _info.total;
            _countTxt.visible = _info.total > 0;
            if(_info.levelLimit != 0)
            {
               _type = 0;
               createTag();
            }
            else if(_info.vipLimit != 0)
            {
               _type = 1;
               createTag();
            }
            else
            {
               _type = 3;
            }
         }
         checkBtnEnable();
      }
      
      private function checkBtnEnable() : void
      {
         switch(int(_type))
         {
            case 0:
               if((_info.total == 0 || _info.remain > 0) && PlayerManager.Instance.Self.Grade >= _info.levelLimit)
               {
                  _buyBtn.enable = true;
                  _tipSprite.visible = false;
               }
               else
               {
                  _buyBtn.enable = false;
                  _tipSprite.visible = true;
                  _tipSprite.tipData = PlayerManager.Instance.Self.Grade >= _info.levelLimit?LanguageMgr.GetTranslation("panicBuying.timesLimit"):LanguageMgr.GetTranslation("panicBuying.levelLimit",_info.levelLimit);
               }
               break;
            case 1:
               if((_info.total == 0 || _info.remain > 0) && PlayerManager.Instance.Self.IsVIP && PlayerManager.Instance.Self.VIPLevel >= _info.vipLimit)
               {
                  _buyBtn.enable = true;
                  _tipSprite.visible = false;
               }
               else
               {
                  _buyBtn.enable = false;
                  _tipSprite.visible = true;
                  _tipSprite.tipData = PlayerManager.Instance.Self.IsVIP && PlayerManager.Instance.Self.VIPLevel >= _info.vipLimit?LanguageMgr.GetTranslation("panicBuying.timesLimit"):LanguageMgr.GetTranslation("panicBuying.vipLvlLimit",_info.vipLimit);
               }
               break;
            case 2:
               _buyBtn.enable = true;
               _tipSprite.visible = false;
               break;
            case 3:
               if(_info.total == 0 || _info.remain > 0)
               {
                  _buyBtn.enable = true;
                  _tipSprite.visible = false;
                  break;
               }
               _buyBtn.enable = false;
               _tipSprite.visible = true;
               _tipSprite.tipData = LanguageMgr.GetTranslation("panicBuying.timesLimit");
               break;
            case 4:
               if(_info.limitedType == 0)
               {
                  _buyBtn.enable = true;
                  _entireRemainTxt.text = LanguageMgr.GetTranslation("panicBuying.enitreBuyNoLimited");
               }
               else if(_info.limitedType == 1)
               {
                  if(_info.remain > 0)
                  {
                     _buyBtn.enable = true;
                  }
                  else
                  {
                     _buyBtn.enable = false;
                  }
                  _entireRemainTxt.text = LanguageMgr.GetTranslation("panicBuying.entireBuyRemain",Math.max(0,_info.remain));
               }
               _tipSprite.visible = false;
               _countTxt.visible = false;
         }
         if(_type == 4)
         {
            _originalPrice.y = 36;
            _price.y = 56;
            _delLine.y = 37;
            _payType.y = 53;
            addChild(_entireRemainTxt);
         }
         else
         {
            _originalPrice.y = 40;
            _price.y = 67;
            _delLine.y = 40;
            _payType.y = 65;
            _entireRemainTxt.parent && removeChild(_entireRemainTxt);
         }
      }
      
      private function createTag() : void
      {
         switch(int(_type))
         {
            case 0:
               if(_info.levelLimit >= 1 && _info.levelLimit <= 19)
               {
                  _tag = ComponentFactory.Instance.creat("panicBuying.greenTag");
                  _levelTxt = ComponentFactory.Instance.creatComponentByStylename("panicBuying.levelTxt1");
               }
               else if(_info.levelLimit >= 20 && _info.levelLimit <= 39)
               {
                  _tag = ComponentFactory.Instance.creat("panicBuying.orangeTag");
                  _levelTxt = ComponentFactory.Instance.creatComponentByStylename("panicBuying.levelTxt2");
               }
               else if(_info.levelLimit >= 40 && _info.levelLimit <= 59)
               {
                  _tag = ComponentFactory.Instance.creat("panicBuying.rosyTag");
                  _levelTxt = ComponentFactory.Instance.creatComponentByStylename("panicBuying.levelTxt3");
               }
               else if(_info.levelLimit >= 60 && _info.levelLimit <= 70)
               {
                  _tag = ComponentFactory.Instance.creat("panicBuying.redTag");
                  _levelTxt = ComponentFactory.Instance.creatComponentByStylename("panicBuying.levelTxt4");
               }
               addChild(_tag);
               addChild(_levelTxt);
               _levelTxt.text = LanguageMgr.GetTranslation("panicBuying.levelTxt",_info.levelLimit);
               break;
            case 1:
               if(_info.vipLimit >= 1 && _info.vipLimit <= 3)
               {
                  _tag = ComponentFactory.Instance.creat("panicBuying.greenTag");
               }
               else if(_info.vipLimit >= 4 && _info.vipLimit <= 6)
               {
                  _tag = ComponentFactory.Instance.creat("panicBuying.orangeTag");
               }
               else if(_info.vipLimit >= 7 && _info.vipLimit <= 9)
               {
                  _tag = ComponentFactory.Instance.creat("panicBuying.rosyTag");
               }
               else if(_info.vipLimit >= 10 && _info.vipLimit <= 12)
               {
                  _tag = ComponentFactory.Instance.creat("panicBuying.redTag");
               }
               if(_tag)
               {
                  addChild(_tag);
               }
               if(_info.vipLimit >= 1 && _info.vipLimit <= 12)
               {
                  _vip = ComponentFactory.Instance.creat("panicBuying.vip" + _info.vipLimit);
                  PositionUtils.setPos(_vip,"panicBuying.vipPos");
                  addChild(_vip);
                  break;
               }
         }
      }
      
      public function dispose() : void
      {
         removeEvents();
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_title);
         _title = null;
         ObjectUtils.disposeObject(_countTxt);
         _countTxt = null;
         ObjectUtils.disposeObject(_bagCell);
         _bagCell = null;
         ObjectUtils.disposeObject(_originalPrice);
         _originalPrice = null;
         ObjectUtils.disposeObject(_delLine);
         _delLine = null;
         ObjectUtils.disposeObject(_price);
         _price = null;
         ObjectUtils.disposeObject(_payType);
         _payType = null;
         ObjectUtils.disposeObject(_giveBtn);
         _giveBtn = null;
         ObjectUtils.disposeObject(_askForBtn);
         _askForBtn = null;
         ObjectUtils.disposeObject(_buyBtn);
         _buyBtn = null;
         ObjectUtils.disposeObject(_tipSprite);
         _tipSprite = null;
         ObjectUtils.disposeObject(_vip);
         _vip = null;
         ObjectUtils.disposeObject(_tag);
         _tag = null;
         ObjectUtils.disposeObject(_levelTxt);
         _levelTxt = null;
         if(_entireRemainTxt != null)
         {
            ObjectUtils.disposeObject(_entireRemainTxt);
            _entireRemainTxt = null;
         }
      }
      
      private function removeEvents() : void
      {
         _buyBtn.removeEventListener("click",__buyBtnClick);
         _askForBtn.removeEventListener("click",__askForBtnClick);
         _giveBtn.removeEventListener("click",__giveBtnClick);
      }
   }
}
