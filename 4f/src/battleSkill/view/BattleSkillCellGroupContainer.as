package battleSkill.view{   import battleSkill.BattleSkillManager;   import battleSkill.event.BattleSkillEvent;   import battleSkill.info.BattleSkillSkillInfo;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.controls.ScrollPanel;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.utils.ObjectUtils;   import ddt.manager.SoundManager;   import flash.display.Sprite;   import flash.utils.Dictionary;      public class BattleSkillCellGroupContainer extends Sprite implements Disposeable   {                   private var _skillSp:ScrollPanel;            private var _skillSpri:Sprite;            private var _data:Array;            private var _cellsDic:Dictionary;            private var _cellList:Vector.<BattleSkillCellGroup>;            public function BattleSkillCellGroupContainer(data:Array) { super(); }
            private function initView() : void { }
            public function createSkillGroup(cellsDic:Dictionary) : void { }
            private function getFiltrationData() : Array { return null; }
            private function update(type:int = -1) : void { }
            private function crealListByType(type:int) : void { }
            private function cellMouseClick_Handler(evt:BattleSkillEvent) : void { }
            public function dispose() : void { }
   }}