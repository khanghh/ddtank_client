package bagAndInfo.info
{
   import bagAndInfo.cell.DragEffect;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import ddt.data.EquipType;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.interfaces.IAcceptDrag;
   import ddt.manager.DragManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import flash.display.Sprite;
   import petsBag.PetsBagManager;
   
   public class PersonalInfoDragInArea extends Sprite implements IAcceptDrag
   {
       
      
      private var temInfo:InventoryItemInfo;
      
      private var temEffect:DragEffect;
      
      public function PersonalInfoDragInArea(){super();}
      
      private function init() : void{}
      
      public function dragDrop(param1:DragEffect) : void{}
      
      private function __onResponse(param1:FrameEvent) : void{}
      
      private function sendDefy() : void{}
   }
}
