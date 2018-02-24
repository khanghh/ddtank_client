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
      
      public function MinesBuyCell(){super();}
      
      protected function initView() : void{}
      
      protected function addEvent() : void{}
      
      protected function __outHandler(param1:MouseEvent) : void{}
      
      protected function __overHandler(param1:MouseEvent) : void{}
      
      protected function removeEvent() : void{}
      
      protected function __exchangeHandler(param1:MouseEvent) : void{}
      
      public function set info(param1:ShopDropInfo) : void{}
      
      public function get info() : ShopDropInfo{return null;}
      
      public function dispose() : void{}
   }
}
