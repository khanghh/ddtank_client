package giftSystem.element
{
   import bagAndInfo.cell.CellFactory;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.ISelectable;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.image.TiledImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.ShopItemInfo;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import giftSystem.GiftController;
   import shop.view.ShopItemCell;
   
   public class GiftGoodItem extends Sprite implements ISelectable, Disposeable
   {
      
      public static const MONEY:uint = 2;
      
      public static const GIFT:uint = 3;
      
      public static const MEDAL:uint = 4;
       
      
      private var _selected:Boolean;
      
      private var _info:ShopItemInfo;
      
      private var _background:ScaleFrameImage;
      
      private var _giftGoodItemBG:Bitmap;
      
      private var _icon:ScaleFrameImage;
      
      private var _itemCell:ShopItemCell;
      
      private var _giftName:FilterFrameText;
      
      private var _charmValue:FilterFrameText;
      
      private var _charmName:FilterFrameText;
      
      private var _moneyValue:FilterFrameText;
      
      private var _moneyName:FilterFrameText;
      
      private var _freeName:FilterFrameText;
      
      private var _freeValue:FilterFrameText;
      
      private var _presentBtn:BaseButton;
      
      private var _line:TiledImage;
      
      private var _line1:TiledImage;
      
      public function GiftGoodItem()
      {
         super();
         init();
      }
      
      private function init() : void
      {
         _background = ComponentFactory.Instance.creatComponentByStylename("asset.giftGoodItem.background");
         _giftGoodItemBG = ComponentFactory.Instance.creatBitmap("asset.ddtgiftGoodItem.BG");
         _icon = ComponentFactory.Instance.creatComponentByStylename("GiftGoodItem.GoodItemIcon");
         _giftName = ComponentFactory.Instance.creat("GiftGoodItem.giftName");
         _charmValue = ComponentFactory.Instance.creat("GiftGoodItem.charmValue");
         _charmName = ComponentFactory.Instance.creat("GiftGoodItem.charmName");
         _moneyValue = ComponentFactory.Instance.creat("GiftGoodItem.moneyValue");
         _moneyName = ComponentFactory.Instance.creatComponentByStylename("GiftGoodItem.moneyName");
         _freeName = ComponentFactory.Instance.creatComponentByStylename("GiftGoodItem.freeName");
         _freeValue = ComponentFactory.Instance.creatComponentByStylename("GiftGoodItem.freeValue");
         _presentBtn = ComponentFactory.Instance.creatComponentByStylename("GiftGoodItem.presentBtn");
         _line = ComponentFactory.Instance.creatComponentByStylename("core.ddtgiftSystem.line");
         _line1 = ComponentFactory.Instance.creatComponentByStylename("core.ddtgiftSystem.line");
         var _loc2_:int = 68;
         _line1.x = _loc2_;
         _line.x = _loc2_;
         _line.y = 44;
         _line1.y = 61;
         var _loc1_:Sprite = new Sprite();
         _loc1_.graphics.beginFill(16777215,0);
         _loc1_.graphics.drawRect(0,0,56,56);
         _loc1_.graphics.endFill();
         _loc1_.alpha = 0;
         _itemCell = CellFactory.instance.createShopItemCell(_loc1_,null,true,true) as ShopItemCell;
         _itemCell.cellSize = 46;
         PositionUtils.setPos(_itemCell,"giftGoodItem.itemCellPos");
         addChild(_background);
         addChild(_giftGoodItemBG);
         addChild(_itemCell);
         addChild(_icon);
         addChild(_giftName);
         addChild(_charmValue);
         addChild(_charmName);
         addChild(_moneyValue);
         addChild(_moneyName);
         addChild(_freeName);
         addChild(_presentBtn);
         addChild(_freeValue);
         addChild(_line);
         addChild(_line1);
         upView();
         _presentBtn.addEventListener("click",__showClearingInterface);
      }
      
      private function __showClearingInterface(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(_info.Label == 6 && parseInt(_freeValue.text) <= 0)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.giftSystem.GiftGoodItem.freeLimit"));
            return;
         }
         GiftController.Instance.openClearingInterface(_info);
      }
      
      public function set info(param1:ShopItemInfo) : void
      {
         if(_info == param1)
         {
            return;
         }
         _info = param1;
         upView();
      }
      
      public function get info() : ShopItemInfo
      {
         return _info;
      }
      
      private function upView() : void
      {
         if(_info == null)
         {
            _itemCell.info = null;
         }
         else
         {
            _itemCell.info = _info.TemplateInfo;
         }
         if(_itemCell.info)
         {
            var _loc1_:* = true;
            _presentBtn.visible = _loc1_;
            _loc1_ = _loc1_;
            _moneyValue.visible = _loc1_;
            _loc1_ = _loc1_;
            _charmName.visible = _loc1_;
            _loc1_ = _loc1_;
            _charmValue.visible = _loc1_;
            _giftName.visible = _loc1_;
            _giftName.text = _itemCell.info.Name;
            _charmValue.text = _itemCell.info.Property2 + LanguageMgr.GetTranslation("shop.ShopIISaveFigurePanel.point");
            _charmName.text = LanguageMgr.GetTranslation("ddt.giftSystem.GiftGoodItem.charm");
            switch(int(_info.getItemPrice(1).PriceType) - -2)
            {
               case 0:
                  _moneyName.text = LanguageMgr.GetTranslation("ddt.giftSystem.GiftGoodItem.bangdingmoney");
                  _moneyValue.text = _info.getItemPrice(1).bandDdtMoneyValue.toString();
                  break;
               case 1:
                  _moneyName.text = LanguageMgr.GetTranslation("ddt.giftSystem.GiftGoodItem.money");
                  _moneyValue.text = _info.getItemPrice(1).bothMoneyValue.toString();
            }
            _icon.visible = _info.Label == 0?false:true;
            if(_info.Label == 6)
            {
               _icon.setFrame(7);
               _background.setFrame(2);
               _freeName.text = LanguageMgr.GetTranslation("ddt.giftSystem.GiftGoodItem.free");
               __upItemCount(null);
               _info.addEventListener("change",__upItemCount);
            }
            else
            {
               _background.setFrame(1);
               _icon.setFrame(_info.Label);
            }
         }
         else
         {
            _loc1_ = false;
            _presentBtn.visible = _loc1_;
            _icon.visible = _loc1_;
            _background.setFrame(1);
         }
      }
      
      protected function __upItemCount(param1:Event) : void
      {
         _freeValue.text = _info.LimitCount > 0?_info.LimitCount.toString():"0";
      }
      
      override public function get height() : Number
      {
         return _background.height;
      }
      
      override public function get width() : Number
      {
         return _background.width;
      }
      
      public function set autoSelect(param1:Boolean) : void
      {
      }
      
      public function get selected() : Boolean
      {
         return _selected;
      }
      
      public function set selected(param1:Boolean) : void
      {
         if(_selected == param1)
         {
            return;
         }
         _selected = param1;
      }
      
      public function asDisplayObject() : DisplayObject
      {
         return this;
      }
      
      public function dispose() : void
      {
         _presentBtn.removeEventListener("click",__showClearingInterface);
         if(_info && _info.Label == 6)
         {
            _info.removeEventListener("change",__upItemCount);
         }
         if(_background)
         {
            ObjectUtils.disposeObject(_background);
         }
         _background = null;
         if(_giftGoodItemBG)
         {
            ObjectUtils.disposeObject(_giftGoodItemBG);
         }
         _giftGoodItemBG = null;
         if(_icon)
         {
            ObjectUtils.disposeObject(_icon);
         }
         _icon = null;
         if(_itemCell)
         {
            ObjectUtils.disposeObject(_itemCell);
         }
         _itemCell = null;
         if(_giftName)
         {
            ObjectUtils.disposeObject(_giftName);
         }
         _giftName = null;
         if(_charmValue)
         {
            ObjectUtils.disposeObject(_charmValue);
         }
         _charmValue = null;
         if(_charmName)
         {
            ObjectUtils.disposeObject(_charmName);
         }
         _charmName = null;
         if(_moneyValue)
         {
            ObjectUtils.disposeObject(_moneyValue);
         }
         _moneyValue = null;
         if(_moneyName)
         {
            ObjectUtils.disposeObject(_moneyName);
         }
         _moneyName = null;
         if(_freeName)
         {
            ObjectUtils.disposeObject(_freeName);
         }
         _freeName = null;
         if(_freeValue)
         {
            ObjectUtils.disposeObject(_freeValue);
         }
         _freeValue = null;
         if(_presentBtn)
         {
            ObjectUtils.disposeObject(_presentBtn);
         }
         _presentBtn = null;
         if(_line)
         {
            ObjectUtils.disposeObject(_line);
         }
         _line = null;
         if(_line1)
         {
            ObjectUtils.disposeObject(_line1);
         }
         _line1 = null;
      }
   }
}
