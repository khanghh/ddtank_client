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
      
      private function bringSkillComplete_Handler(param1:BattleSkillEvent) : void
      {
         var _loc2_:Array = param1.data as Array;
         _bringSkillView.updateBringSkill(_loc2_);
      }
      
      private function skillCellClick_Handler(param1:BattleSkillEvent) : void
      {
         if(param1 && param1.data == null)
         {
            return;
         }
         var _loc2_:int = param1.data as int;
         if(!BattleSkillManager.instance.isActivateBySkillID(_loc2_))
         {
            return;
         }
         if(BattleSkillManager.instance.isSkillHasEquip(_loc2_))
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("horse.skillCannotEquipSame"));
            return;
         }
         var _loc3_:int = BattleSkillManager.instance.isEquipFull(_loc2_);
         if(_loc3_ == 0)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("horse.skillEquipMax"));
            return;
         }
         GameInSocketOut.sendBringBattleSkill(_loc2_,_loc3_);
      }
      
      private function bringSkillCellClick_Handler(param1:BattleSkillEvent) : void
      {
         var _loc2_:int = param1.data as int;
         var _loc4_:Dictionary = BattleSkillManager.instance.getBringSkillList();
         var _loc6_:int = 0;
         var _loc5_:* = _loc4_;
         for(var _loc3_ in _loc4_)
         {
            if(_loc4_[_loc3_] == _loc2_)
            {
               GameInSocketOut.sendBringBattleSkill(_loc2_,0);
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
