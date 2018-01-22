package giftSystem.element
{
   import bagAndInfo.cell.CellFactory;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.MovieImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.ShopItemInfo;
   import ddt.manager.LanguageMgr;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import giftSystem.MyGiftCellInfo;
   import shop.view.ShopItemCell;
   
   public class MyGiftItem extends Sprite implements Disposeable
   {
       
      
      private var _info:MyGiftCellInfo;
      
      private var _BG:MovieImage;
      
      private var _nameBG:Bitmap;
      
      private var _giftBG:Bitmap;
      
      private var _name:FilterFrameText;
      
      private var _ownCount:FilterFrameText;
      
      private var _count:FilterFrameText;
      
      private var _itemCell:ShopItemCell;
      
      public function MyGiftItem()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _BG = ComponentFactory.Instance.creatComponentByStylename("ddtmyGiftItem.BG");
         _giftBG = ComponentFactory.Instance.creatBitmap("asset.ddtgiftGoodItem.BG");
         _giftBG.width = 55;
         _giftBG.height = 55;
         _giftBG.x = 25;
         _giftBG.y = 6;
         _nameBG = ComponentFactory.Instance.creatBitmap("asset.myGiftname.Bg");
         _name = ComponentFactory.Instance.creat("MyGiftItem.name");
         _ownCount = ComponentFactory.Instance.creat("MyGiftItem.ownCount");
         _count = ComponentFactory.Instance.creat("MyGiftItem.count");
         var _loc1_:Sprite = new Sprite();
         _loc1_.graphics.beginFill(16777215,0);
         _loc1_.graphics.drawRect(0,0,59,59);
         _loc1_.graphics.endFill();
         _itemCell = CellFactory.instance.createShopItemCell(_loc1_,null,true,true) as ShopItemCell;
         _itemCell.cellSize = 50;
         PositionUtils.setPos(_itemCell,"MyGiftItem.cellPos");
         addChild(_BG);
         addChild(_giftBG);
         addChild(_nameBG);
         addChild(_name);
         addChild(_ownCount);
         addChild(_count);
         addChild(_itemCell);
      }
      
      public function get info() : MyGiftCellInfo
      {
         return _info;
      }
      
      public function set info(param1:MyGiftCellInfo) : void
      {
         _info = param1;
         upView();
      }
      
      private function upView() : void
      {
         if(_info == null)
         {
            return;
         }
         var _loc1_:ShopItemInfo = _info.info;
         if(_loc1_ == null)
         {
            return;
         }
         _itemCell.info = _loc1_.TemplateInfo;
         _name.text = _itemCell.info.Name;
         upCountAndownCount();
      }
      
      public function set ownCount(param1:int) : void
      {
         _info.amount = param1;
         upCountAndownCount();
      }
      
      private function upCountAndownCount() : void
      {
         _count.text = String(_info.amount);
         _ownCount.text = LanguageMgr.GetTranslation("ddt.giftSystem.MyGiftItem.ownIII",getSpace(_count.text));
      }
      
      private function getSpace(param1:String) : String
      {
         var _loc3_:int = 0;
         if(!param1)
         {
            return "";
         }
         var _loc2_:String = "";
         _loc3_ = 0;
         while(_loc3_ < param1.length)
         {
            _loc2_ = _loc2_ + " ";
            _loc3_++;
         }
         return _loc2_;
      }
      
      override public function get height() : Number
      {
         return _BG.height;
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
         _info = null;
         if(_BG)
         {
            ObjectUtils.disposeObject(_BG);
         }
         _BG = null;
         if(_giftBG)
         {
            ObjectUtils.disposeObject(_giftBG);
         }
         _giftBG = null;
         if(_nameBG)
         {
            ObjectUtils.disposeObject(_nameBG);
         }
         _nameBG = null;
         if(_name)
         {
            ObjectUtils.disposeObject(_name);
         }
         _name = null;
         if(_ownCount)
         {
            ObjectUtils.disposeObject(_ownCount);
         }
         _ownCount = null;
         if(_count)
         {
            ObjectUtils.disposeObject(_count);
         }
         _count = null;
         if(_itemCell)
         {
            ObjectUtils.disposeObject(_itemCell);
         }
         _itemCell = null;
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}
