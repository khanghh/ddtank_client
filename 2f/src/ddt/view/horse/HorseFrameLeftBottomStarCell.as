package ddt.view.horse{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.utils.ObjectUtils;   import flash.display.Bitmap;   import flash.display.MovieClip;   import flash.display.Sprite;   import flash.events.Event;   import horse.HorseManager;   import horse.data.HorseTemplateVo;   import road7th.utils.MovieClipWrapper;      public class HorseFrameLeftBottomStarCell extends Sprite implements Disposeable   {                   private var _bg:Bitmap;            private var _bg2:Bitmap;            private var _normalMc:MovieClip;            private var _level:int;            private var _isOpen:Boolean = false;            private var _skillCell:HorseSkillCell;            public function HorseFrameLeftBottomStarCell() { super(); }
            private function initView() : void { }
            public function refreshView(index:int, curLevel:int) : void { }
            private function openHandler() : void { }
            private function playEndHandler(event:Event) : void { }
            public function dispose() : void { }
   }}