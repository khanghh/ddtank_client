package bagAndInfo.amulet{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.ui.image.ScaleFrameImage;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.utils.ObjectUtils;   import ddt.manager.LanguageMgr;   import ddt.manager.MessageTipManager;   import ddt.manager.SoundManager;   import flash.display.Sprite;   import flash.events.Event;   import flash.events.MouseEvent;   import horse.HorseAmuletManager;      public class EquipAmuletActivateItem extends Sprite implements Disposeable   {                   private var _lock:ScaleFrameImage;            private var _lockSpr:Sprite;            private var _propertyText:FilterFrameText;            private var _valueText:FilterFrameText;            private var _startLevelText:FilterFrameText;            private var _lockBool:Boolean;            private var _type:int;            private var _value:int;            private var _startLevel:int;            public function EquipAmuletActivateItem(showLock:Boolean = true) { super(); }
            private function __onClikc(event:MouseEvent) : void { }
            public function update(property:int, value:int, probability:int = 0) : void { }
            public function set lockBool(value:Boolean) : void { }
            public function get lockBool() : Boolean { return false; }
            public function get propertyType() : int { return 0; }
            public function get propertyValue() : int { return 0; }
            public function get startLevel() : int { return 0; }
            public function dispose() : void { }
   }}