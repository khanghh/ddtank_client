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
         var sp:Sprite = new Sprite();
         sp.graphics.beginFill(16777215,0);
         sp.graphics.drawRect(0,0,59,59);
         sp.graphics.endFill();
         _itemCell = CellFactory.instance.createShopItemCell(sp,null,true,true) as ShopItemCell;
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
      
      public function set info(value:MyGiftCellInfo) : void
      {
         _info = value;
         upView();
      }
      
      private function upView() : void
      {
         if(_info == null)
         {
            return;
         }
         var shopItemInfo:ShopItemInfo = _info.info;
         if(shopItemInfo == null)
         {
            return;
         }
         _itemCell.info = shopItemInfo.TemplateInfo;
         _name.text = _itemCell.info.Name;
         upCountAndownCount();
      }
      
      public function set ownCount(value:int) : void
      {
         _info.amount = value;
         upCountAndownCount();
      }
      
      private function upCountAndownCount() : void
      {
         _count.text = String(_info.amount);
         _ownCount.text = LanguageMgr.GetTranslation("ddt.giftSystem.MyGiftItem.ownIII",getSpace(_count.text));
      }
      
      private function getSpace(s:String) : String
      {
         var i:int = 0;
         if(!s)
         {
            return "";
         }
         var temp:String = "";
         for(i = 0; i < s.length; )
         {
            temp = temp + " ";
            i++;
         }
         return temp;
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
