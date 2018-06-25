package horse.amulet{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.ui.image.ScaleBitmapImage;   import com.pickgliss.utils.ObjectUtils;   import ddt.utils.PositionUtils;   import flash.display.Sprite;   import flash.events.Event;   import horse.HorseAmuletManager;      public class HorseAmuletMainView extends Sprite implements Disposeable   {                   private var _mainBg:ScaleBitmapImage;            private var _bgView:HorseAmuletBagView;            private var _equipView:HorseAmuletEquipView;            private var _activateView:HorseAmuletActivateView;            public function HorseAmuletMainView() { super(); }
            protected function initView() : void { }
            private function __onUpdateLeftView(e:Event) : void { }
            private function initEvent() : void { }
            private function removeEvent() : void { }
            public function dispose() : void { }
   }}