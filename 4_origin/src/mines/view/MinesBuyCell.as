package mines.view
{
   import bagAndInfo.cell.BagCell;
   import baglocked.BaglockedManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.ItemManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SoundManager;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import mines.analyzer.ShopDropInfo;
   
   public class MinesBuyCell extends Sprite implements Disposeable
   {
       
      
      protected var _buyBtn:SimpleBitmapButton;
      
      protected var _bagCell:BagCell;
      
      private var _info:ShopDropInfo;
      
      public function MinesBuyCell()
      {
         super();
         initView();
         addEvent();
      }
      
      protected function initView() : void
      {
         _bagCell = new BagCell(0,null,true,ComponentFactory.Instance.creatBitmap("asset.mines.shopView.cellBg"));
         var _loc1_:int = 71;
         _bagCell.height = _loc1_;
         _bagCell.width = _loc1_;
         addChild(_bagCell);
         _buyBtn = ComponentFactory.Instance.creatComponentByStylename("mines.cell.buyBtn");
         addChild(_buyBtn);
         _buyBtn.visible = false;
      }
      
      protected function addEvent() : void
      {
         _buyBtn.addEventListener("click",__exchangeHandler);
         addEventListener("rollOver",__overHandler);
         addEventListener("rollOut",__outHandler);
      }
      
      protected function __outHandler(event:MouseEvent) : void
      {
         _buyBtn.visible = false;
      }
      
      protected function __overHandler(event:MouseEvent) : void
      {
         _buyBtn.visible = true;
      }
      
      protected function removeEvent() : void
      {
         _buyBtn.removeEventListener("click",__exchangeHandler);
         removeEventListener("rollOver",__overHandler);
         removeEventListener("rollOut",__outHandler);
      }
      
      protected function __exchangeHandler(e:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         var quickBuyFrame:MinesExchangeFrame = ComponentFactory.Instance.creatComponentByStylename("mines.cell.exchangeFrame");
         quickBuyFrame.setType(1);
         quickBuyFrame.setData(_info.templateID,_info.templateID,_info.price);
         LayerManager.Instance.addToLayer(quickBuyFrame,3,true,1);
      }
      
      public function set info(value:ShopDropInfo) : void
      {
         _info = value;
         _bagCell.info = ItemManager.Instance.getTemplateById(_info.templateID);
         _bagCell.setCount(_info.limitedCount);
      }
      
      public function get info() : ShopDropInfo
      {
         return _info;
      }
      
      public function dispose() : void
      {
         removeEvent();
         while(this.numChildren)
         {
            ObjectUtils.disposeObject(this.getChildAt(0));
         }
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
