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
      
      private function openSkillView_Handler(evt:BattleSkillEvent) : void
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
      
      private function battleSkillInfo_Handler(evt:BattleSkillEvent) : void
      {
         if(_skillFrame == null)
         {
            return;
         }
         initActivateSkillView();
         initBringSkillView();
      }
      
      private function refreshMainView_Handler(evt:BattleSkillEvent) : void
      {
         var oldID:int = BattleSkillManager.instance.curUpSkillId;
         var newID:int = evt.data as int;
         var info:BattleSkillSkillInfo = BattleSkillManager.instance.getBattleSKillInfoBySkillID(newID);
         updateSkillList(oldID,info);
         updateBringList(oldID,info);
      }
      
      private function updateSkillList(skillId:int, newSkillInfo:BattleSkillSkillInfo) : void
      {
         var cellsDic:Dictionary = _skillFrame.frameSkillCells;
         var _loc6_:int = 0;
         var _loc5_:* = cellsDic;
         for each(var cell in cellsDic)
         {
            if(cell.info.SkillID == skillId)
            {
               cell.updateSkillState(newSkillInfo);
               return;
            }
         }
      }
      
      private function updateBringList(skillId:int, newSkillInfo:BattleSkillSkillInfo) : void
      {
         var view:BringSkillCellGroupContainer = _skillFrame.bringSkillView;
         var cells:Dictionary = view._allCells;
         var _loc7_:int = 0;
         var _loc6_:* = cells;
         for each(var cell in cells)
         {
            if(cell.info.SkillID == skillId)
            {
               cell.info = newSkillInfo;
               return;
            }
         }
      }
      
      private function initActivateSkillView() : void
      {
         var info:* = null;
         var i:int = 0;
         var activateSkillArr:Array = BattleSkillManager.instance.getActivatedSkillArr();
         var cellsDic:Dictionary = _skillFrame.frameSkillCells;
         for(i = 0; i < activateSkillArr.length; )
         {
            info = BattleSkillManager.instance.getBattleSKillInfoBySkillID(activateSkillArr[i]);
            if(info == null)
            {
               return;
            }
            var _loc7_:int = 0;
            var _loc6_:* = cellsDic;
            for each(var cell in cellsDic)
            {
               if(cell.info.Type == info.Type)
               {
                  cell.updateSkillState(info);
                  break;
               }
            }
            i++;
         }
      }
      
      private function initBringSkillView() : void
      {
         var view:BringSkillCellGroupContainer = _skillFrame.bringSkillView;
         view.initBringSkillCellGroup();
      }
      
      private function __responseHandler(evt:FrameEvent) : void
      {
         if(evt.responseCode == 0 || evt.responseCode == 1)
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
