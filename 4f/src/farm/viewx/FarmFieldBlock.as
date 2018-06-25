package farm.viewx{   import bagAndInfo.cell.DragEffect;   import baglocked.BaglockedManager;   import com.pickgliss.loader.DisplayLoader;   import com.pickgliss.loader.LoadResourceManager;   import com.pickgliss.loader.LoaderEvent;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.controls.BaseButton;   import com.pickgliss.ui.controls.SimpleBitmapButton;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.ui.image.ScaleFrameImage;   import com.pickgliss.utils.DisplayUtils;   import com.pickgliss.utils.ObjectUtils;   import com.pickgliss.utils.PNGHitAreaFactory;   import ddt.data.goods.InventoryItemInfo;   import ddt.interfaces.IAcceptDrag;   import ddt.manager.DragManager;   import ddt.manager.ItemManager;   import ddt.manager.LanguageMgr;   import ddt.manager.MessageTipManager;   import ddt.manager.PathManager;   import ddt.manager.PlayerManager;   import ddt.manager.SoundManager;   import ddt.utils.PositionUtils;   import farm.FarmEvent;   import farm.FarmModelController;   import farm.modelx.FieldVO;   import farm.view.compose.event.SelectComposeItemEvent;   import flash.display.Bitmap;   import flash.display.MovieClip;   import flash.display.Sprite;   import flash.events.Event;   import flash.events.MouseEvent;   import flash.utils.getQualifiedClassName;   import petsBag.PetsBagManager;      public class FarmFieldBlock extends Sprite implements Disposeable, IAcceptDrag   {                   private var _fieldId:int;            private var _info:FieldVO;            private var _picPath:String;            private var _field:ScaleFrameImage;            private var _flag:SimpleBitmapButton;            private var _hitArea:Sprite;            private var _loadingasset:MovieClip;            private var _loader:DisplayLoader;            private var _type:int = -1;            private var _plant:BaseButton;            private var _countdown:CountdownView;            public function FarmFieldBlock(id:int) { super(); }
            public function set flag(value:Boolean) : void { }
            public function get info() : FieldVO { return null; }
            public function set info(info:FieldVO) : void { }
            protected function __onMouseClick(event:MouseEvent) : void { }
            private function upTips() : void { }
            private function initEvent() : void { }
            public function setBeginHelper(seedID:int) : void { }
            private function __onMouseOver(evt:MouseEvent) : void { }
            private function __onMouseOut(evt:MouseEvent) : void { }
            private function initView() : void { }
            protected function __accelerate(event:Event) : void { }
            protected function __frush(event:Event) : void { }
            private function __plantClickHandler(event:MouseEvent) : void { }
            protected function __onClick(event:MouseEvent) : void { }
            private function petFarmGuilde() : void { }
            private function loadIcon(type:int) : void { }
            private function __complete(event:LoaderEvent) : void { }
            public function dragDrop(effect:DragEffect) : void { }
            private function __flagClickHandler(event:MouseEvent) : void { }
            public function dispose() : void { }
   }}