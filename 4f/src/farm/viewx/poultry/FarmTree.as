package farm.viewx.poultry{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.LayerManager;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.utils.PNGHitAreaFactory;   import ddt.manager.LanguageMgr;   import ddt.manager.MessageTipManager;   import ddt.manager.PlayerManager;   import ddt.manager.SoundManager;   import ddt.utils.PositionUtils;   import farm.FarmEvent;   import farm.FarmModelController;   import flash.display.Bitmap;   import flash.display.MovieClip;   import flash.display.Sprite;   import flash.events.MouseEvent;      public class FarmTree extends Sprite implements Disposeable   {                   private var _tree:MovieClip;            private var _leaf:MovieClip;            private var _level:FilterFrameText;            private var _levelNum:int;            private var _treeName:FilterFrameText;            private var _area:Sprite;            public function FarmTree() { super(); }
            private function initView() : void { }
            private function initEvent() : void { }
            protected function __onUpdateFarmTreeLevel(event:FarmEvent) : void { }
            public function setLevel(level:int) : void { }
            protected function __onTreeClick(event:MouseEvent) : void { }
            protected function __onTreeOver(event:MouseEvent) : void { }
            protected function __onTreeOut(event:MouseEvent) : void { }
            private function removeEvent() : void { }
            public function dispose() : void { }
   }}