package ddt.view.tips{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.image.Image;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.ui.tip.BaseTip;   import com.pickgliss.utils.ObjectUtils;   import ddt.display.BitmapLoaderProxy;   import ddt.manager.PathManager;   import ddt.utils.PositionUtils;   import flash.display.Sprite;   import flash.geom.Rectangle;      public class PetTip extends BaseTip   {            private static const PET_ICON_SIZE:int = 35;                   private var _petName:FilterFrameText;            private var _petIcon:BitmapLoaderProxy;            private var _petIconContainer:Sprite;            private var _petLevel:FilterFrameText;            private var _bg:Image;            public function PetTip() { super(); }
            override protected function init() : void { }
            override protected function addChildren() : void { }
            override public function set tipData(data:Object) : void { }
            override public function dispose() : void { }
            private function updateWH() : void { }
   }}