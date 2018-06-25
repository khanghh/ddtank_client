package horse.view{   import com.greensock.TweenLite;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.LayerManager;   import com.pickgliss.ui.controls.SimpleBitmapButton;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.utils.ObjectUtils;   import ddt.manager.SoundManager;   import ddt.view.horse.HorseSkillCell;   import flash.display.Bitmap;   import flash.display.MovieClip;   import flash.display.Sprite;   import flash.events.Event;   import flash.events.MouseEvent;   import flash.geom.Point;   import road7th.utils.MovieClipWrapper;      public class HorseGetSkillView extends Sprite implements Disposeable   {                   private var _bg:Bitmap;            private var _getBtn:SimpleBitmapButton;            private var _skillCell:HorseSkillCell;            public function HorseGetSkillView() { super(); }
            private function initView() : void { }
            public function show(skillId:int) : void { }
            private function completeMc1(event:Event) : void { }
            private function getClickHandler(event:MouseEvent) : void { }
            private function skillCellMoveComplete1() : void { }
            private function skillCellMoveComplete2() : void { }
            private function skillCellMoveComplete3() : void { }
            private function skillCellMoveComplete4() : void { }
            private function completeMc2(event:Event) : void { }
            private function completeMc3(event:Event) : void { }
            public function dispose() : void { }
   }}