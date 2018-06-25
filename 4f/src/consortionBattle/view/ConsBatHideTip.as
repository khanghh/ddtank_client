package consortionBattle.view{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.controls.SelectedCheckButton;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.ui.image.ScaleBitmapImage;   import com.pickgliss.utils.ObjectUtils;   import consortionBattle.ConsortiaBattleManager;   import ddt.manager.LanguageMgr;   import ddt.manager.SoundManager;   import ddt.utils.PositionUtils;   import flash.display.Sprite;   import flash.events.Event;   import flash.events.MouseEvent;      public class ConsBatHideTip extends Sprite implements Disposeable   {            public static const SELECTED_CHANGE:String = "consBatHideTip_selected_change";                   private var _bg:ScaleBitmapImage;            private var _sameScb:SelectedCheckButton;            private var _tombScb:SelectedCheckButton;            private var _fightingScb:SelectedCheckButton;            public function ConsBatHideTip() { super(); }
            private function initView() : void { }
            private function initEvent() : void { }
            private function clickHandler(event:MouseEvent) : void { }
            public function hideAll() : void { }
            public function showAll() : void { }
            private function updateTransform() : void { }
            public function dispose() : void { }
   }}