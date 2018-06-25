package battleSkill{   import battleSkill.event.BattleSkillEvent;   import battleSkill.info.BattleSkillSkillInfo;   import battleSkill.view.BattleSkillCell;   import battleSkill.view.BattleSkillCellGroup;   import battleSkill.view.BattleSkillFrame;   import battleSkill.view.BringSkillCellGroupContainer;   import com.pickgliss.events.FrameEvent;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.LayerManager;   import com.pickgliss.utils.ObjectUtils;   import ddt.CoreController;   import ddt.manager.GameInSocketOut;   import ddt.manager.SoundManager;   import flash.utils.Dictionary;      public class BattleSkillController extends CoreController   {            private static var _controller:BattleSkillController;                   private var _skillFrame:BattleSkillFrame;            public function BattleSkillController() { super(); }
            public static function get instance() : BattleSkillController { return null; }
            public function setup() : void { }
            private function openSkillView_Handler(evt:BattleSkillEvent) : void { }
            private function battleSkillInfo_Handler(evt:BattleSkillEvent) : void { }
            private function refreshMainView_Handler(evt:BattleSkillEvent) : void { }
            private function updateSkillList(skillId:int, newSkillInfo:BattleSkillSkillInfo) : void { }
            private function updateBringList(skillId:int, newSkillInfo:BattleSkillSkillInfo) : void { }
            private function initActivateSkillView() : void { }
            private function initBringSkillView() : void { }
            private function __responseHandler(evt:FrameEvent) : void { }
            private function get _manager() : BattleSkillManager { return null; }
   }}