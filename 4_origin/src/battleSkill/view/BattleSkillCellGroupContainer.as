package battleSkill.view
{
   import battleSkill.BattleSkillManager;
   import battleSkill.event.BattleSkillEvent;
   import battleSkill.info.BattleSkillSkillInfo;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.SoundManager;
   import flash.display.Sprite;
   import flash.utils.Dictionary;
   
   public class BattleSkillCellGroupContainer extends Sprite implements Disposeable
   {
       
      
      private var _skillSp:ScrollPanel;
      
      private var _skillSpri:Sprite;
      
      private var _data:Array;
      
      private var _cellsDic:Dictionary;
      
      private var _cellList:Vector.<BattleSkillCellGroup>;
      
      public function BattleSkillCellGroupContainer(param1:Array)
      {
         super();
         _data = param1;
         initView();
      }
      
      private function initView() : void
      {
         _skillSp = ComponentFactory.Instance.creatComponentByStylename("battleSkill.skillGroupView.scrollpanel");
         addChild(_skillSp);
         _skillSpri = new Sprite();
         _cellList = new Vector.<BattleSkillCellGroup>();
      }
      
      public function createSkillGroup(param1:Dictionary) : void
      {
         var _loc3_:* = null;
         var _loc5_:int = 0;
         _cellsDic = param1;
         if(_data == null)
         {
            return;
         }
         var _loc4_:Array = getFiltrationData();
         var _loc2_:int = _loc4_.length <= 12?12:_loc4_.length;
         _loc5_ = 0;
         while(_loc5_ < _loc2_)
         {
            if(_loc5_ < _loc4_.length)
            {
               _loc3_ = new BattleSkillCellGroup(_loc4_[_loc5_]);
               _cellsDic[_loc4_[_loc5_].SkillID] = _loc3_;
            }
            else
            {
               _loc3_ = new BattleSkillCellGroup();
            }
            _loc3_.x = _loc5_ % 6 * 46 + int(_loc5_ % 6) * 19;
            _loc3_.y = int(_loc5_ / 6) * 46 + int(_loc5_ / 6) * 34;
            _loc3_.addEventListener(BattleSkillEvent.SKILLCELL_CLICK,cellMouseClick_Handler);
            _skillSpri.addChild(_loc3_);
            _cellList.push(_loc3_);
            _loc5_++;
         }
         _skillSp.setView(_skillSpri);
         update();
      }
      
      private function getFiltrationData() : Array
      {
         var arr:Array = [];
         var _loc3_:int = 0;
         var _loc2_:* = _data;
         for each(info in _data)
         {
            if(info.Level == 1)
            {
               arr.push(info);
            }
         }
         arr.sort(function(param1:BattleSkillSkillInfo, param2:BattleSkillSkillInfo):int
         {
            if(param1.ID < param2.ID)
            {
               return -1;
            }
            return 1;
         });
         return arr;
      }
      
      private function update(param1:int = -1) : void
      {
         var _loc4_:* = null;
         var _loc3_:int = 0;
         var _loc2_:int = 0;
         _loc3_ = 0;
         while(_loc3_ < _cellList.length)
         {
            if(_cellList[_loc3_].info)
            {
               _loc2_ = param1 == -1?_cellList[_loc3_].info.Type:int(param1);
               _loc4_ = BattleSkillManager.instance.getActivateSkillInfoByType(_loc2_);
               if(_loc4_)
               {
                  _cellList[_loc3_].info = _loc4_;
                  crealListByType(_loc2_);
                  _cellsDic[_loc4_.SkillID] = _cellList[_loc3_];
                  if(param1 == _loc2_)
                  {
                     return;
                  }
               }
            }
            _loc3_++;
         }
      }
      
      private function crealListByType(param1:int) : void
      {
         var _loc4_:int = 0;
         var _loc3_:* = _cellsDic;
         for(var _loc2_ in _cellsDic)
         {
            if(_cellsDic[_loc2_].info.Type == param1)
            {
               return;
               §§push(delete _cellsDic[_loc2_]);
            }
            else
            {
               continue;
            }
         }
      }
      
      private function cellMouseClick_Handler(param1:BattleSkillEvent) : void
      {
         SoundManager.instance.playButtonSound();
         dispatchEvent(new BattleSkillEvent(BattleSkillEvent.SKILLCELL_CLICK,(param1.target as BattleSkillCellGroup).info.SkillID));
      }
      
      public function dispose() : void
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < _cellList.length)
         {
            _cellList[_loc1_].removeEventListener(BattleSkillEvent.SKILLCELL_CLICK,cellMouseClick_Handler);
            _cellList[_loc1_] = null;
            _loc1_++;
         }
         _cellList = null;
         if(_skillSpri)
         {
            ObjectUtils.disposeAllChildren(_skillSpri);
            ObjectUtils.disposeObject(_skillSpri);
         }
         if(_skillSp)
         {
            ObjectUtils.disposeObject(_skillSp);
         }
         if(this && this.parent)
         {
            this.parent.removeChild(this);
         }
         _skillSpri = null;
         _skillSp = null;
         _data = null;
         _cellsDic = null;
      }
   }
}
