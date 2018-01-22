package battleSkill
{
   import battleSkill.event.BattleSkillEvent;
   import battleSkill.info.BattleSkillSkillInfo;
   import battleSkill.view.BattleSkillCell;
   import battleSkill.view.BattleSkillCellGroup;
   import battleSkill.view.BattleSkillFrame;
   import battleSkill.view.BringSkillCellGroupContainer;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.CoreController;
   import ddt.manager.GameInSocketOut;
   import ddt.manager.SoundManager;
   import flash.utils.Dictionary;
   
   public class BattleSkillController extends CoreController
   {
      
      private static var _controller:BattleSkillController;
       
      
      private var _skillFrame:BattleSkillFrame;
      
      public function BattleSkillController()
      {
         super();
      }
      
      public static function get instance() : BattleSkillController
      {
         if(!_controller)
         {
            _controller = new BattleSkillController();
         }
         return _controller;
      }
      
      public function setup() : void
      {
         addEventsMap([[BattleSkillEvent.OPEN_SKILL_VIEW,openSkillView_Handler],[BattleSkillEvent.BATTLESKILL_INFO,battleSkillInfo_Handler],[BattleSkillEvent.UPDATE_SKILL,refreshMainView_Handler]],_manager);
      }
      
      private function openSkillView_Handler(param1:BattleSkillEvent) : void
      {
         if(_skillFrame)
         {
            ObjectUtils.disposeObject(_skillFrame);
            _skillFrame = null;
         }
         _skillFrame = ComponentFactory.Instance.creatComponentByStylename("battleSkill.battleSkillView");
         _skillFrame.addEventListener("response",__responseHandler);
         LayerManager.Instance.addToLayer(_skillFrame,3,true,1);
         GameInSocketOut.sendGetBattleSkillInfo();
      }
      
      private function battleSkillInfo_Handler(param1:BattleSkillEvent) : void
      {
         if(_skillFrame == null)
         {
            return;
         }
         initActivateSkillView();
         initBringSkillView();
      }
      
      private function refreshMainView_Handler(param1:BattleSkillEvent) : void
      {
         var _loc2_:int = BattleSkillManager.instance.curUpSkillId;
         var _loc3_:int = param1.data as int;
         var _loc4_:BattleSkillSkillInfo = BattleSkillManager.instance.getBattleSKillInfoBySkillID(_loc3_);
         updateSkillList(_loc2_,_loc4_);
         updateBringList(_loc2_,_loc4_);
      }
      
      private function updateSkillList(param1:int, param2:BattleSkillSkillInfo) : void
      {
         var _loc4_:Dictionary = _skillFrame.frameSkillCells;
         var _loc6_:int = 0;
         var _loc5_:* = _loc4_;
         for each(var _loc3_ in _loc4_)
         {
            if(_loc3_.info.SkillID == param1)
            {
               _loc3_.updateSkillState(param2);
               return;
            }
         }
      }
      
      private function updateBringList(param1:int, param2:BattleSkillSkillInfo) : void
      {
         var _loc5_:BringSkillCellGroupContainer = _skillFrame.bringSkillView;
         var _loc3_:Dictionary = _loc5_._allCells;
         var _loc7_:int = 0;
         var _loc6_:* = _loc3_;
         for each(var _loc4_ in _loc3_)
         {
            if(_loc4_.info.SkillID == param1)
            {
               _loc4_.info = param2;
               return;
            }
         }
      }
      
      private function initActivateSkillView() : void
      {
         var _loc5_:* = null;
         var _loc4_:int = 0;
         var _loc3_:Array = BattleSkillManager.instance.getActivatedSkillArr();
         var _loc2_:Dictionary = _skillFrame.frameSkillCells;
         _loc4_ = 0;
         while(_loc4_ < _loc3_.length)
         {
            _loc5_ = BattleSkillManager.instance.getBattleSKillInfoBySkillID(_loc3_[_loc4_]);
            if(_loc5_ == null)
            {
               return;
            }
            var _loc7_:int = 0;
            var _loc6_:* = _loc2_;
            for each(var _loc1_ in _loc2_)
            {
               if(_loc1_.info.Type == _loc5_.Type)
               {
                  _loc1_.updateSkillState(_loc5_);
                  break;
               }
            }
            _loc4_++;
         }
      }
      
      private function initBringSkillView() : void
      {
         var _loc1_:BringSkillCellGroupContainer = _skillFrame.bringSkillView;
         _loc1_.initBringSkillCellGroup();
      }
      
      private function __responseHandler(param1:FrameEvent) : void
      {
         if(param1.responseCode == 0 || param1.responseCode == 1)
         {
            SoundManager.instance.play("008");
            if(_skillFrame)
            {
               ObjectUtils.disposeObject(_skillFrame);
            }
            _skillFrame = null;
         }
      }
      
      private function get _manager() : BattleSkillManager
      {
         return BattleSkillManager.instance;
      }
   }
}
