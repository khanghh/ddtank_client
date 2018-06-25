package ddt.view.horse
{
   import bagAndInfo.cell.BagCell;
   import baglocked.BaglockedManager;
   import com.greensock.TweenLite;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.events.BagEvent;
   import ddt.manager.ItemManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SoundManager;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import shop.manager.ShopBuyManager;
   
   public class HorseFrameRightBottomItemCell extends Sprite implements Disposeable
   {
       
      
      private var _itemCell:BagCell;
      
      private var _buyImage:Bitmap;
      
      private var _itemId:int;
      
      private var _goodsId:int;
      
      private var _countVisible:Boolean;
      
      public function HorseFrameRightBottomItemCell(itemId:int, goodsId:int = 0, countVisible:Boolean = true)
      {
         super();
         this.buttonMode = true;
         _itemId = itemId;
         _goodsId = goodsId == 0?itemId:int(goodsId);
         _countVisible = countVisible;
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         var bg:Bitmap = ComponentFactory.Instance.creatBitmap("asset.horse.frame.itemBg");
         _itemCell = new BagCell(1,ItemManager.Instance.getTemplateById(_itemId),true,bg,false);
         _itemCell.PicPos = new Point(9,9);
         _itemCell.setContentSize(59,59);
         addChild(_itemCell);
         if(_countVisible)
         {
            updateItemCellCount();
         }
         else
         {
            _itemCell.setCountNotVisible();
         }
         _buyImage = ComponentFactory.Instance.creatBitmap("asset.horse.frame.buyBtn");
         addChild(_buyImage);
         _buyImage.alpha = 0;
      }
      
      private function updateItemCellCount() : void
      {
         _itemCell.setCount(PlayerManager.Instance.Self.PropBag.getItemCountByTemplateId(_itemId));
         _itemCell.refreshTbxPos();
      }
      
      private function initEvent() : void
      {
         addEventListener("click",clickHandler,false,0,true);
         addEventListener("mouseOver",overHandler,false,0,true);
         addEventListener("mouseOut",outHandler,false,0,true);
         if(_countVisible)
         {
            PlayerManager.Instance.Self.PropBag.addEventListener("update",itemUpdateHandler);
         }
      }
      
      private function itemUpdateHandler(event:BagEvent) : void
      {
         updateItemCellCount();
      }
      
      private function clickHandler(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         ShopBuyManager.Instance.buy(_goodsId,1,-1);
      }
      
      private function overHandler(event:MouseEvent) : void
      {
         TweenLite.to(_buyImage,0.25,{"alpha":1});
      }
      
      private function outHandler(event:MouseEvent) : void
      {
         TweenLite.to(_buyImage,0.25,{"alpha":0});
      }
      
      private function removeEvent() : void
      {
         removeEventListener("click",clickHandler);
         removeEventListener("mouseOver",overHandler);
         removeEventListener("mouseOut",outHandler);
         PlayerManager.Instance.Self.PropBag.removeEventListener("update",itemUpdateHandler);
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeAllChildren(this);
         _itemCell = null;
         _buyImage = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
      
      public function get itemCell() : BagCell
      {
         return _itemCell;
      }
   }
}
