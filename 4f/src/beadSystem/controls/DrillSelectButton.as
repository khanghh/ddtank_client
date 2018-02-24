package beadSystem.controls
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.ShowTipManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.list.IDropListTarget;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.display.BitmapLoaderProxy;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PathManager;
   import ddt.manager.PlayerManager;
   import ddt.utils.PositionUtils;
   import ddt.view.tips.GoodTipInfo;
   import flash.display.DisplayObject;
   import flash.geom.Rectangle;
   
   public class DrillSelectButton extends Component implements IDropListTarget
   {
       
      
      private var _btn:BaseButton;
      
      private var _itemInfo:DrillItemInfo;
      
      private var _data:InventoryItemInfo;
      
      private var _frameText:FilterFrameText;
      
      private var _dataIcon:BitmapLoaderProxy;
      
      public function DrillSelectButton(){super();}
      
      public function setCursor(param1:int) : void{}
      
      public function get caretIndex() : int{return 0;}
      
      public function setValue(param1:*) : void{}
      
      public function get DrillItem() : InventoryItemInfo{return null;}
      
      public function getValueLength() : int{return 0;}
      
      override public function asDisplayObject() : DisplayObject{return null;}
      
      override public function dispose() : void{}
   }
}
