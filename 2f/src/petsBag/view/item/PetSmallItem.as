package petsBag.view.item{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.utils.ObjectUtils;   import ddt.display.BitmapLoaderProxy;   import ddt.manager.PathManager;   import flash.display.Bitmap;   import flash.display.DisplayObject;   import flash.display.Sprite;   import flash.events.Event;   import flash.events.MouseEvent;   import pet.data.PetInfo;   import petsBag.PetsBagManager;      public class PetSmallItem extends Sprite implements Disposeable   {            public static const PET_ITEM_WIDTH:int = 78;                   protected var _bg:DisplayObject;            protected var _info:PetInfo;            protected var _petIcon:BitmapLoaderProxy;            protected var _isFight:Boolean = false;            protected var _fightIcon:Bitmap;            private var _isSelect:Boolean = false;            protected var _shiner:DisplayObject;            public function PetSmallItem(info:PetInfo = null) { super(); }
            protected function initEvent() : void { }
            protected function removeEvent() : void { }
            protected function clickHandler(e:MouseEvent) : void { }
            public function get info() : PetInfo { return null; }
            public function set info(value:PetInfo) : void { }
            private function __fixPetIconPostion(e:Event) : void { }
            protected function initView() : void { }
            public function set isFight(value:Boolean) : void { }
            public function set selected(value:Boolean) : void { }
            public function get selected() : Boolean { return false; }
            public function dispose() : void { }
   }}