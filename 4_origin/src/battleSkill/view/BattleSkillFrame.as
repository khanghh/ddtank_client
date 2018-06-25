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
      
      public function BattleSkillFrame()
      {
         _allCellsDic = new Dictionary();
         super();
      }
      
      override protected function init() : void
      {
         super.init();
         titleText = LanguageMgr.GetTranslation("ddt.battleSkill.titleTxt");
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatBitmap("asset.battleSkill.main.bg");
         addToContent(_bg);
         _initiativeSkillView = ComponentFactory.Instance.creat("battleSkill.mainView.initiativeSkillContainer",new Array(BattleSkillManager.instance.getInitiativeSkillList()));
         addToContent(_initiativeSkillView);
         _initiativeSkillView.createSkillGroup(_allCellsDic);
         _passiveSkillView = ComponentFactory.Instance.creat("battleSkill.mainView.passiveSkillContainer",new Array(BattleSkillManager.instance.getPassiveSkillList()));
         addToContent(_passiveSkillView);
         _passiveSkillView.createSkillGroup(_allCellsDic);
         _bringSkillView = new BringSkillCellGroupContainer();
         addToContent(_bringSkillView);
         _helpBtn = HelpFrameUtils.Instance.simpleHelpButton(this,"core.helpButtonSmall",null,LanguageMgr.GetTranslation("store.view.HelpButtonText"),"asset.battleSkill.help.descriptMc",404,488) as SimpleBitmapButton;
         PositionUtils.setPos(_helpBtn,"battleSkill.helpBtn.Pos");
      }
      
      public function get frameSkillCells() : Dictionary
      {
         return _allCellsDic;
      }
      
      public function get bringSkillView() : BringSkillCellGroupContainer
      {
         return _bringSkillView;
      }
      
      private function bringSkillComplete_Handler(evt:BattleSkillEvent) : void
      {
         var skill:Array = evt.data as Array;
         _bringSkillView.updateBringSkill(skill);
      }
      
      private function skillCellClick_Handler(evt:BattleSkillEvent) : void
      {
         if(evt && evt.data == null)
         {
            return;
         }
         var skillId:int = evt.data as int;
         if(!BattleSkillManager.instance.isActivateBySkillID(skillId))
         {
            return;
         }
         if(BattleSkillManager.instance.isSkillHasEquip(skillId))
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("horse.skillCannotEquipSame"));
            return;
         }
         var place:int = BattleSkillManager.instance.isEquipFull(skillId);
         if(place == 0)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("horse.skillEquipMax"));
            return;
         }
         GameInSocketOut.sendBringBattleSkill(skillId,place);
      }
      
      private function bringSkillCellClick_Handler(evt:BattleSkillEvent) : void
      {
         var skillId:int = evt.data as int;
         var bringSkills:Dictionary = BattleSkillManager.instance.getBringSkillList();
         var _loc6_:int = 0;
         var _loc5_:* = bringSkills;
         for(var place in bringSkills)
         {
            if(bringSkills[place] == skillId)
            {
               GameInSocketOut.sendBringBattleSkill(skillId,0);
               return;
            }
         }
      }
      
      private function initEvent() : void
      {
         _initiativeSkillView.addEventListener(BattleSkillEvent.SKILLCELL_CLICK,skillCellClick_Handler);
         _passiveSkillView.addEventListener(BattleSkillEvent.SKILLCELL_CLICK,skillCellClick_Handler);
         _bringSkillView.addEventListener(BattleSkillEvent.SKILLCELL_CLICK,bringSkillCellClick_Handler);
         BattleSkillManager.instance.addEventListener(BattleSkillEvent.BRIGHT_SKILL,bringSkillComplete_Handler);
      }
      
      private function removeEvent() : void
      {
         if(_initiativeSkillView)
         {
            _initiativeSkillView.removeEventListener(BattleSkillEvent.SKILLCELL_CLICK,skillCellClick_Handler);
         }
         if(_passiveSkillView)
         {
            _passiveSkillView.removeEventListener(BattleSkillEvent.SKILLCELL_CLICK,skillCellClick_Handler);
         }
         if(_passiveSkillView)
         {
            _bringSkillView.removeEventListener(BattleSkillEvent.SKILLCELL_CLICK,bringSkillCellClick_Handler);
         }
         BattleSkillManager.instance.removeEventListener(BattleSkillEvent.BRIGHT_SKILL,bringSkillComplete_Handler);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeAllChildren(_initiativeSkillView);
         ObjectUtils.disposeObject(_initiativeSkillView);
         _initiativeSkillView = null;
         ObjectUtils.disposeAllChildren(_passiveSkillView);
         ObjectUtils.disposeObject(_passiveSkillView);
         _passiveSkillView = null;
         ObjectUtils.disposeObject(_helpBtn);
         _helpBtn = null;
         super.dispose();
         _allCellsDic = null;
         if(this && this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}
