package horse.amulet{   import bagAndInfo.cell.BagCell;   import bagAndInfo.cell.DragEffect;   import baglocked.BaglockedManager;   import com.pickgliss.events.FrameEvent;   import com.pickgliss.ui.AlertManager;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.controls.alert.BaseAlerFrame;   import com.pickgliss.utils.ObjectUtils;   import ddt.data.goods.InventoryItemInfo;   import ddt.data.goods.ItemTemplateInfo;   import ddt.manager.DragManager;   import ddt.manager.LanguageMgr;   import ddt.manager.MessageTipManager;   import ddt.manager.PlayerManager;   import ddt.manager.SocketManager;   import ddt.manager.SoundManager;   import flash.display.Bitmap;   import flash.display.DisplayObject;   import horse.HorseAmuletManager;      public class HorseAmuletCell extends BagCell   {                   private var _isLock:Boolean;            private var _lockIcon:Bitmap;            private var _alertFrame:BaseAlerFrame;            private var _markPlace:int;            public function HorseAmuletCell(index:int, info:ItemTemplateInfo = null, bg:DisplayObject = null) { super(null,null,null,null,null); }
            public function Lock() : Boolean { return false; }
            public function smash() : void { }
            private function __onConfirmResponse(event:FrameEvent) : void { }
            override public function dragStart() : void { }
            override public function dragDrop(effect:DragEffect) : void { }
            private function __onClickFrame(e:FrameEvent) : void { }
            private function disposeAlertFrame() : void { }
            override public function dragStop(effect:DragEffect) : void { }
            override public function set info(value:ItemTemplateInfo) : void { }
            override public function dispose() : void { }
   }}