package battleSkill.view
{
   import baglocked.BaglockedManager;
   import battleSkill.BattleSkillManager;
   import battleSkill.BattleSkillOptionType;
   import battleSkill.event.BattleSkillEvent;
   import battleSkill.info.BattleSkillSkillInfo;
   import battleSkill.info.BattleSkillUpdateInfo;
   import battleSkill.info.BattleSkillUpdateMaterialInfo;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.BagInfo;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SoundManager;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import flash.utils.getTimer;
   
   public class BattleSkillUpFrame extends Frame
   {
       
      
      private var _bg:Bitmap;
      
      private var _activateMaterialImgTxt:Bitmap;
      
      private var _updateMaterialImgTxt:Bitmap;
      
      private var _activateBtn:BaseButton;
      
      private var _updateBtn:BaseButton;
      
      private var _curInfo:BattleSkillSkillInfo;
      
      private var _nextInfo:BattleSkillSkillInfo;
      
      private var _type:int;
      
      private var _curSkillLevTxt:FilterFrameText;
      
      private var _NextSkillLevTxt:FilterFrameText;
      
      private var _materialHBox:HBox;
      
      private var _curSkillCell:BattleSkillCell;
      
      private var _nextSkillCell:BattleSkillCell;
      
      private var _isCanUp:Boolean = false;
      
      private var _lastUpClickTime:int = 0;
      
      private var _materialCell:BattleSkillMaterialCell;
      
      public function BattleSkillUpFrame(){super();}
      
      override protected function init() : void{}
      
      private function initView() : void{}
      
      private function initEvent() : void{}
      
      private function removeEvent() : void{}
      
      private function refreshView(param1:BattleSkillEvent) : void{}
      
      private function updateSkill_Handler(param1:MouseEvent) : void{}
      
      public function show(param1:BattleSkillSkillInfo, param2:int) : void{}
      
      private function updateView() : void{}
      
      private function updateState() : void{}
      
      private function updateSkillCell() : void{}
      
      private function updateMaterialCell() : void{}
      
      private function __responseHandler(param1:FrameEvent) : void{}
      
      override public function dispose() : void{}
   }
}
