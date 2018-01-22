package email.view
{
   import baglocked.BaglockedManager;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ShowTipManager;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.EquipType;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.manager.LanguageMgr;
   import ddt.manager.LeavePageManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SoundManager;
   import email.MailManager;
   import email.manager.MailControl;
   import flash.events.MouseEvent;
   import mark.data.MarkChipData;
   import mark.data.MarkProData;
   
   public class DiamondOfReading extends DiamondBase
   {
       
      
      private var type:int;
      
      private var payAlertFrame:BaseAlerFrame;
      
      public function DiamondOfReading(){super();}
      
      public function set readOnly(param1:Boolean) : void{}
      
      override protected function addEvent() : void{}
      
      override protected function removeEvent() : void{}
      
      override protected function update() : void{}
      
      private function __distill(param1:MouseEvent) : void{}
      
      private function __payFrameResponse(param1:FrameEvent) : void{}
      
      private function confirmPay() : void{}
      
      private function __confirmResponse(param1:FrameEvent) : void{}
      
      private function canclePay() : void{}
      
      override public function dispose() : void{}
   }
}
