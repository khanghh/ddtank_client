package farm.viewx
{
   import baglocked.BaglockedManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.manager.ItemManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import farm.FarmEvent;
   import farm.FarmModelController;
   import farm.modelx.FieldVO;
   import farm.view.compose.event.SelectComposeItemEvent;
   import flash.display.Sprite;
   import petsBag.PetsBagManager;
   
   public class FarmFieldsView extends Sprite implements Disposeable
   {
       
      
      private var _fields:Vector.<FarmFieldBlock>;
      
      private var _configmPnl:ConfirmKillCropAlertFrame;
      
      public function FarmFieldsView(){super();}
      
      private function initEvent() : void{}
      
      private function remvoeEvent() : void{}
      
      private function initView() : void{}
      
      private function __setFields(param1:FarmEvent) : void{}
      
      public function setFieldByHelper() : void{}
      
      protected function __fieldInfoReady(param1:FarmEvent) : void{}
      
      private function __hasSeeding(param1:FarmEvent) : void{}
      
      private function __frushField(param1:FarmEvent) : void{}
      
      private function __gainField(param1:FarmEvent) : void{}
      
      private function __accelerateField(param1:FarmEvent) : void{}
      
      private function __helperSwitchHandler(param1:FarmEvent) : void{}
      
      private function __helperKeyHandler(param1:FarmEvent) : void{}
      
      private function __onKillcropField(param1:FarmEvent) : void{}
      
      private function upFields() : void{}
      
      private function upFlagPlace() : void{}
      
      private function __showComfigKillCrop(param1:SelectComposeItemEvent) : void{}
      
      private function __killCropClick(param1:SelectComposeItemEvent) : void{}
      
      public function autoHelperHandler(param1:FieldVO) : void{}
      
      public function dispose() : void{}
      
      public function get fields() : Vector.<FarmFieldBlock>{return null;}
   }
}
