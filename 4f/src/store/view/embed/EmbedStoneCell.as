package store.view.embed{   import bagAndInfo.cell.BaseCell;   import bagAndInfo.cell.DragEffect;   import baglocked.BaglockedManager;   import beadSystem.beadSystemManager;   import beadSystem.controls.BeadAdvanceCell;   import beadSystem.model.BeadModel;   import com.pickgliss.events.FrameEvent;   import com.pickgliss.events.InteractiveEvent;   import com.pickgliss.ui.AlertManager;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.LayerManager;   import com.pickgliss.ui.controls.alert.BaseAlerFrame;   import com.pickgliss.ui.image.Image;   import com.pickgliss.ui.image.ScaleFrameImage;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.utils.DoubleClickManager;   import com.pickgliss.utils.ObjectUtils;   import ddt.command.ShineObject;   import ddt.data.EquipType;   import ddt.data.goods.InventoryItemInfo;   import ddt.data.goods.ItemTemplateInfo;   import ddt.data.player.PlayerInfo;   import ddt.events.CellEvent;   import ddt.events.PlayerPropertyEvent;   import ddt.manager.BeadTemplateManager;   import ddt.manager.DragManager;   import ddt.manager.LanguageMgr;   import ddt.manager.MessageTipManager;   import ddt.manager.PlayerManager;   import ddt.manager.ServerConfigManager;   import ddt.manager.SocketManager;   import ddt.manager.SoundManager;   import ddt.view.tips.GoodTipInfo;   import ddt.view.tips.MultipleLineTip;   import ddt.view.tips.OneLineTip;   import flash.display.Bitmap;   import flash.display.MovieClip;   import flash.display.Sprite;   import flash.events.Event;   import flash.events.MouseEvent;   import flash.geom.Point;   import flash.utils.getQualifiedClassName;   import road7th.utils.MovieClipWrapper;   import store.events.EmbedBackoutEvent;      public class EmbedStoneCell extends BaseCell   {            public static const Close:int = -1;            public static const Empty:int = 0;            public static const Full:int = 1;            public static const ATTACK:int = 1;            public static const DEFENSE:int = 2;            public static const ATTRIBUTE:int = 3;            public static const BEAD_STATE_CHANGED:String = "beadEmbed";                   private var _id:int;            private var _state:int = -1;            private var _stoneType:int;            private var _shiner:ShineObject;            private var _tipPanel:Sprite;            private var _tipDerial:Boolean;            private var tipSprite:Sprite;            private var _tipOne:MultipleLineTip;            private var _tipTwo:OneLineTip;            private var _openGrid:ScaleFrameImage;            private var _openBG:Bitmap;            private var _closeStrip:Bitmap;            private var _SelectedImage:Image;            private var _holeLv:int = -1;            private var _holeExp:int = -1;            private var _dragBeadPic:MovieClip;            private var _nameTxt:FilterFrameText;            private var _lockIcon:Bitmap;            private var _selected:Boolean = false;            private var _isOpend:Boolean = false;            private var _itemInfo:InventoryItemInfo;            private var _beadInfo:InventoryItemInfo;            private var _Player:PlayerInfo;            public function EmbedStoneCell(id:int, stoneType:int) { super(null,null); }
            private function setTipTwoData(pID:int) : void { }
            public function LockBead() : Boolean { return false; }
            private function __changeHandler(event:PlayerPropertyEvent) : void { }
            public function set selected(value:Boolean) : void { }
            public function get selected() : Boolean { return false; }
            public function holeLvUp() : void { }
            public function get ID() : int { return 0; }
            override public function get allowDrag() : Boolean { return false; }
            private function initEvents() : void { }
            override protected function onMouseOver(evt:MouseEvent) : void { }
            private function __clickHandler(event:InteractiveEvent) : void { }
            private function __doubleClick(event:InteractiveEvent) : void { }
            public function showTip(evt:MouseEvent) : void { }
            public function closeTip(evt:MouseEvent) : void { }
            override protected function onMouseOut(evt:MouseEvent) : void { }
            public function open() : void { }
            public function get isOpend() : Boolean { return false; }
            public function set HoleExp(value:int) : void { }
            public function get HoleExp() : int { return 0; }
            public function set HoleLv(value:int) : void { }
            public function get HoleLv() : int { return 0; }
            public function set StoneType(value:int) : void { }
            public function get StoneType() : int { return 0; }
            override public function dragStart() : void { }
            private function dragHidePicTxt() : void { }
            private function dragShowPicTxt() : void { }
            public function set itemInfo(value:InventoryItemInfo) : void { }
            public function get itemInfo() : InventoryItemInfo { return null; }
            override public function set info(value:ItemTemplateInfo) : void { }
            public function close() : void { }
            override protected function onMouseClick(evt:MouseEvent) : void { }
            private function disposeDragBeadPic() : void { }
            override public function dragDrop(effect:DragEffect) : void { }
            protected function __onBindRespones(pEvent:FrameEvent) : void { }
            override public function dragStop(effect:DragEffect) : void { }
            private function isRightType(item:InventoryItemInfo) : Boolean { return false; }
            public function get tipDerial() : Boolean { return false; }
            public function set tipDerial(value:Boolean) : void { }
            public function startShine() : void { }
            public function stopShine() : void { }
            public function hasDrill() : Boolean { return false; }
            public function get otherPlayer() : PlayerInfo { return null; }
            public function set otherPlayer(value:PlayerInfo) : void { }
            override protected function updateSize(sp:Sprite) : void { }
            override public function dispose() : void { }
            public function get state() : int { return 0; }
   }}