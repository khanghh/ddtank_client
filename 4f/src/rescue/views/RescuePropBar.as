package rescue.views
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.PropInfo;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.manager.ItemManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import gameCommon.view.prop.WeaponPropCell;
   import org.aswing.KeyStroke;
   import org.aswing.KeyboardManager;
   
   public class RescuePropBar extends Sprite implements Disposeable
   {
       
      
      private var _background:Bitmap;
      
      private var _cellf:WeaponPropCell;
      
      private var _cellr:WeaponPropCell;
      
      public function RescuePropBar(){super();}
      
      private function initView() : void{}
      
      private function initEvents() : void{}
      
      protected function __cellrClick(param1:MouseEvent) : void{}
      
      protected function __keyDown(param1:KeyboardEvent) : void{}
      
      private function doNothing() : void{}
      
      public function setKingBlessEnable() : void{}
      
      public function setKingBlessCount(param1:int) : void{}
      
      private function removeEvents() : void{}
      
      public function dispose() : void{}
   }
}
