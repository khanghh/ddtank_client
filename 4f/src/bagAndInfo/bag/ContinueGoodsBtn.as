package bagAndInfo.bag
{
   import bagAndInfo.cell.BagCell;
   import bagAndInfo.cell.DragEffect;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.TextButton;
   import ddt.data.EquipType;
   import ddt.interfaces.IDragable;
   import ddt.manager.DragManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.ShopManager;
   import ddt.manager.SoundManager;
   import ddt.view.goods.AddPricePanel;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   
   public class ContinueGoodsBtn extends TextButton implements IDragable
   {
       
      
      public var _isContinueGoods:Boolean;
      
      public function ContinueGoodsBtn(){super();}
      
      private function addEvt() : void{}
      
      private function removeEvt() : void{}
      
      private function clickthis(param1:MouseEvent) : void{}
      
      public function getSource() : IDragable{return null;}
      
      public function dragStop(param1:DragEffect) : void{}
      
      public function get isContinueGoods() : Boolean{return false;}
   }
}
