package battleSkill.view
{
   import battleSkill.BattleSkillManager;
   import battleSkill.event.BattleSkillEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.GameInSocketOut;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.utils.HelpFrameUtils;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.utils.Dictionary;
   
   public class BattleSkillFrame extends Frame
   {
       
      
      private var _bg:Bitmap;
      
      private var _helpBtn:SimpleBitmapButton;
      
      private var _initiativeSkillView:BattleSkillCellGroupContainer;
      
      private var _passiveSkillView:BattleSkillCellGroupContainer;
      
      private var _bringSkillView:BringSkillCellGroupContainer;
      
      private var _allCellsDic:Dictionary;
      
      public function BattleSkillFrame(){super();}
      
      override protected function init() : void{}
      
      private function initView() : void{}
      
      public function get frameSkillCells() : Dictionary{return null;}
      
      public function get bringSkillView() : BringSkillCellGroupContainer{return null;}
      
      private function bringSkillComplete_Handler(param1:BattleSkillEvent) : void{}
      
      private function skillCellClick_Handler(param1:BattleSkillEvent) : void{}
      
      private function bringSkillCellClick_Handler(param1:BattleSkillEvent) : void{}
      
      private function initEvent() : void{}
      
      private function removeEvent() : void{}
      
      override public function dispose() : void{}
   }
}
