package chickActivation.view
{
   import bagAndInfo.cell.BagCell;
   import chickActivation.ChickActivationManager;
   import chickActivation.data.ChickActivationInfo;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.InventoryItemInfo;
   import flash.display.Sprite;
   
   public class ChickActivationItems extends Sprite implements Disposeable
   {
       
      
      private var _arrData:Array;
      
      private var _items:Sprite;
      
      private var _itemsPanel:ScrollPanel;
      
      public function ChickActivationItems()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _itemsPanel = ComponentFactory.Instance.creatComponentByStylename("chickActivationFrame.itemsScrollPanel");
         addChild(_itemsPanel);
         _items = new Sprite();
         _itemsPanel.setView(_items);
         _itemsPanel.invalidateViewport();
      }
      
      public function update(param1:Array) : void
      {
         _arrData = param1;
         updateView();
         _itemsPanel.invalidateViewport();
      }
      
      private function updateView() : void
      {
         var _loc2_:int = 0;
         var _loc1_:* = null;
         ObjectUtils.disposeAllChildren(_items);
         if(_arrData)
         {
            _loc2_ = 0;
            while(_loc2_ < _arrData.length)
            {
               _loc1_ = createCell(_arrData[_loc2_]);
               _loc1_.x = _loc2_ % 5 * 105;
               _loc1_.y = int(_loc2_ / 5) * 80 + 5;
               _items.addChild(_loc1_);
               _loc2_++;
            }
         }
      }
      
      private function createCell(param1:ChickActivationInfo) : BagCell
      {
         var _loc3_:InventoryItemInfo = ChickActivationManager.instance.model.getInventoryItemInfo(param1);
         if(_loc3_ == null)
         {
            return null;
         }
         var _loc2_:BagCell = new BagCell(0,_loc3_,true,ComponentFactory.Instance.creatBitmap("assets.chickActivation.itemBg"));
         _loc2_.width = 64;
         _loc2_.height = 64.1;
         _loc2_.setCount(_loc3_.Count);
         return _loc2_;
      }
      
      public function get arrData() : Array
      {
         return _arrData;
      }
      
      public function dispose() : void
      {
         if(_items)
         {
            ObjectUtils.disposeAllChildren(_items);
            ObjectUtils.disposeObject(_items);
            _items = null;
         }
         ObjectUtils.disposeObject(_itemsPanel);
         _itemsPanel = null;
         _arrData = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
