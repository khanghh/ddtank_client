package farm.viewx{   import baglocked.BaglockedManager;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.LayerManager;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.utils.ObjectUtils;   import ddt.data.goods.InventoryItemInfo;   import ddt.manager.ItemManager;   import ddt.manager.PlayerManager;   import ddt.manager.SoundManager;   import ddt.utils.PositionUtils;   import farm.FarmEvent;   import farm.FarmModelController;   import farm.modelx.FieldVO;   import farm.view.compose.event.SelectComposeItemEvent;   import flash.display.Sprite;   import petsBag.PetsBagManager;      public class FarmFieldsView extends Sprite implements Disposeable   {                   private var _fields:Vector.<FarmFieldBlock>;            private var _configmPnl:ConfirmKillCropAlertFrame;            public function FarmFieldsView() { super(); }
            private function initEvent() : void { }
            private function remvoeEvent() : void { }
            private function initView() : void { }
            private function __setFields(event:FarmEvent) : void { }
            public function setFieldByHelper() : void { }
            protected function __fieldInfoReady(event:FarmEvent) : void { }
            private function __hasSeeding(event:FarmEvent) : void { }
            private function __frushField(event:FarmEvent) : void { }
            private function __gainField(event:FarmEvent) : void { }
            private function __accelerateField(event:FarmEvent) : void { }
            private function __helperSwitchHandler(event:FarmEvent) : void { }
            private function __helperKeyHandler(event:FarmEvent) : void { }
            private function __onKillcropField(event:FarmEvent) : void { }
            private function upFields() : void { }
            private function upFlagPlace() : void { }
            private function __showComfigKillCrop(e:SelectComposeItemEvent) : void { }
            private function __killCropClick(e:SelectComposeItemEvent) : void { }
            public function autoHelperHandler(_info:FieldVO) : void { }
            public function dispose() : void { }
            public function get fields() : Vector.<FarmFieldBlock> { return null; }
   }}