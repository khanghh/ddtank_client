package petsBag.view{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.controls.ScrollPanel;   import com.pickgliss.ui.controls.container.SimpleTileList;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.utils.ObjectUtils;   import ddt.manager.SocketManager;   import flash.display.Sprite;   import flash.geom.Point;   import pet.data.PetSkill;   import pet.data.PetSkillTemplateInfo;   import petsBag.PetsBagManager;   import petsBag.event.PetItemEvent;   import petsBag.view.item.SkillItem;      public class PetSkillPnl extends Sprite implements Disposeable   {                   private var _petSkill:SimpleTileList;            private var _petSkillScroll:ScrollPanel;            private var _isWatch:Boolean = false;            private var _itemInfoVec:Array;            private var _itemViewVec:Vector.<SkillItem>;            public function PetSkillPnl(isWatch:Boolean) { super(); }
            private function creatView() : void { }
            public function set itemInfo(petSkillAll:Array) : void { }
            public function update() : void { }
            protected function creatItems() : void { }
            public function set scrollVisble(value:Boolean) : void { }
            private function removeItems() : void { }
            private function initEvent() : void { }
            private function removeEvent() : void { }
            private function __skillItemClick(e:PetItemEvent) : void { }
            public function dispose() : void { }
   }}