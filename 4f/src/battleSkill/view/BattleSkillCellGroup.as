package battleSkill.view{   import battleSkill.BattleSkillManager;   import battleSkill.BattleSkillOptionType;   import battleSkill.event.BattleSkillEvent;   import battleSkill.info.BattleSkillSkillInfo;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.LayerManager;   import com.pickgliss.ui.controls.BaseButton;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.utils.ObjectUtils;   import ddt.manager.LanguageMgr;   import ddt.manager.SoundManager;   import flash.display.Sprite;   import flash.events.MouseEvent;   import flash.utils.getTimer;   import horse.HorseManager;   import horse.data.HorseSkillVo;   import room.RoomManager;   import room.model.RoomInfo;      public class BattleSkillCellGroup extends Sprite implements Disposeable   {                   private var _updateBtn:BaseButton;            private var _activateBtn:BaseButton;            private var _fullLevelBtn:FilterFrameText;            private var _disableTxt:FilterFrameText;            private var _isDisable:Boolean = false;            private var _skillCell:BattleSkillCell;            private var _data:BattleSkillSkillInfo;            private var _updateFrame:BattleSkillUpFrame = null;            private var _lastUpClickTime:int = 0;            public function BattleSkillCellGroup(data:BattleSkillSkillInfo = null) { super(); }
            private function initSkillCell() : void { }
            private function initView() : void { }
            private function initState() : void { }
            private function isFilterByCurRoomType() : Boolean { return false; }
            public function updateSkillState(info:BattleSkillSkillInfo) : void { }
            private function updateClick_Handler(evt:MouseEvent) : void { }
            private function activateClick_Handler(evt:MouseEvent) : void { }
            private function openUpdateFrame() : void { }
            private function cellClick_Handler(evt:MouseEvent) : void { }
            private function playSound() : void { }
            public function set info(data:BattleSkillSkillInfo) : void { }
            public function get info() : BattleSkillSkillInfo { return null; }
            private function initEvent() : void { }
            private function removeEvent() : void { }
            public function dispose() : void { }
   }}