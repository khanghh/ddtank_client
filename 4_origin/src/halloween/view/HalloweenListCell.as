package halloween.view
{
   import bagAndInfo.cell.BagCell;
   import baglocked.BaglockedManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.ItemManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import halloween.data.HalloweenModel;
   
   public class HalloweenListCell extends Sprite implements Disposeable
   {
       
      
      private var _info:HalloweenModel;
      
      private var _bg:Bitmap;
      
      private var _candy:Bitmap;
      
      private var _items:BagCell;
      
      private var _itemsName:FilterFrameText;
      
      private var _itemsPrice:FilterFrameText;
      
      private var _exchangeBtn:SimpleBitmapButton;
      
      public function HalloweenListCell()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creat("asset.halloween.listView.cell.bg");
         addChild(_bg);
         _candy = ComponentFactory.Instance.creat("asset.halloween.candy");
         PositionUtils.setPos(_candy,"halloween.candyPos2");
         addChild(_candy);
         _items = new BagCell(0);
         _items.setBgVisible(false);
         var _loc1_:* = 1.3;
         _items.scaleY = _loc1_;
         _items.scaleX = _loc1_;
         PositionUtils.setPos(_items,"halloween.itemsPos");
         addChild(_items);
         _itemsName = ComponentFactory.Instance.creatComponentByStylename("halloween.itemsNameText");
         addChild(_itemsName);
         _itemsPrice = ComponentFactory.Instance.creatComponentByStylename("halloween.itemsPriceText");
         addChild(_itemsPrice);
         _exchangeBtn = ComponentFactory.Instance.creatComponentByStylename("halloween.exchangeBtn");
         _exchangeBtn.visible = false;
         addChild(_exchangeBtn);
      }
      
      private function initEvent() : void
      {
         _exchangeBtn.addEventListener("click",__onExchangeClick);
      }
      
      protected function __onExchangeClick(param1:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         SocketManager.Instance.out.getHalloweenExchange(_info.Index);
      }
      
      public function set info(param1:HalloweenModel) : void
      {
         var _loc2_:* = param1 != null;
         _itemsPrice.visible = _loc2_;
         _loc2_ = _loc2_;
         _itemsName.visible = _loc2_;
         _loc2_ = _loc2_;
         _items.visible = _loc2_;
         _exchangeBtn.visible = _loc2_;
         if(param1)
         {
            if(_info == param1)
            {
               return;
            }
            _info = param1;
            _items.info = ItemManager.Instance.getTemplateById(_info.Id);
            _itemsName.text = _items.info.Name;
            _itemsPrice.text = _info.Price.toString();
            _exchangeBtn.visible = true;
         }
      }
      
      private function removeEvent() : void
      {
         _exchangeBtn.removeEventListener("click",__onExchangeClick);
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_candy);
         _candy = null;
         ObjectUtils.disposeObject(_items);
         _items = null;
         ObjectUtils.disposeObject(_itemsName);
         _itemsName = null;
         ObjectUtils.disposeObject(_itemsPrice);
         _itemsPrice = null;
         ObjectUtils.disposeObject(_exchangeBtn);
         _exchangeBtn = null;
      }
   }
}
