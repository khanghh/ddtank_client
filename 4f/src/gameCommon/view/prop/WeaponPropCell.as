package gameCommon.view.prop{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.ShowTipManager;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.utils.ObjectUtils;   import ddt.data.PropInfo;   import flash.display.Bitmap;   import flash.display.DisplayObject;   import flash.events.MouseEvent;      public class WeaponPropCell extends PropCell   {                   private var _countField:FilterFrameText;            public function WeaponPropCell(shortcutKey:String, mode:int) { super(null,null); }
            private static function creatDeputyWeaponIcon(templateId:int) : Bitmap { return null; }
            override public function setPossiton(x:int, y:int) : void { }
            override protected function drawLayer() : void { }
            override protected function configUI() : void { }
            public function setCount(count:int) : void { }
            override public function set info(val:PropInfo) : void { }
            override public function useProp() : void { }
            override public function dispose() : void { }
   }}