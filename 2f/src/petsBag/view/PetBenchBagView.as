package petsBag.view{   import com.pickgliss.events.FrameEvent;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.controls.BaseButton;   import com.pickgliss.ui.controls.Frame;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.ui.image.Scale9CornerImage;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.utils.ObjectUtils;   import ddt.events.CEvent;   import ddt.manager.LanguageMgr;   import ddt.manager.PlayerManager;   import ddt.manager.SoundManager;   import ddt.utils.PositionUtils;   import flash.display.DisplayObject;   import flash.display.Sprite;   import flash.events.MouseEvent;   import petsBag.PetsBagManager;   import petsBag.event.UpdatePetInfoEvent;   import petsBag.view.item.PetSmallItemButton;      public class PetBenchBagView extends Frame implements Disposeable   {            private static const PAGE_COUNT:int = 3;                   private var _cellList:Vector.<PetSmallItemButton>;            private var _detailTxt:FilterFrameText;            private var _cellTotalCount:Number = 20;            private var _content:Sprite;            private var _pageSp:Sprite;            private var _prevBtn:BaseButton;            private var _nextBtn:BaseButton;            private var _pageBg:Scale9CornerImage;            private var _pageTxt:FilterFrameText;            private var _curPage:int;            public function PetBenchBagView() { super(); }
            private function addEvents() : void { }
            private function removeEvents() : void { }
            protected function __prevBtnClick(event:MouseEvent) : void { }
            protected function __nextBtnClick(event:MouseEvent) : void { }
            public function get curPage() : int { return 0; }
            public function set curPage(value:int) : void { }
            protected function __onHideView(event:UpdatePetInfoEvent) : void { }
            protected function onUpdatePet(e:CEvent) : void { }
            protected function __onPetCellUnlock(e:UpdatePetInfoEvent) : void { }
            override protected function init() : void { }
            private function addBG() : void { }
            protected function onClick(e:MouseEvent) : void { }
            protected function onCellDoubleClick(e:MouseEvent) : void { }
            private function _response(evt:FrameEvent) : void { }
            private function close() : void { }
            public function update() : void { }
            private function updateEmptyCells(i:int) : void { }
            override public function dispose() : void { }
   }}