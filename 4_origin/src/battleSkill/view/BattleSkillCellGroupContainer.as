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
      
      public function BattleSkillCellGroupContainer(data:Array)
      {
         super();
         _data = data;
         initView();
      }
      
      private function initView() : void
      {
         _skillSp = ComponentFactory.Instance.creatComponentByStylename("battleSkill.skillGroupView.scrollpanel");
         addChild(_skillSp);
         _skillSpri = new Sprite();
         _cellList = new Vector.<BattleSkillCellGroup>();
      }
      
      public function createSkillGroup(cellsDic:Dictionary) : void
      {
         var cell:* = null;
         var i:int = 0;
         _cellsDic = cellsDic;
         if(_data == null)
         {
            return;
         }
         var data:Array = getFiltrationData();
         var cellNum:int = data.length <= 12?12:data.length;
         for(i = 0; i < cellNum; )
         {
            if(i < data.length)
            {
               cell = new BattleSkillCellGroup(data[i]);
               _cellsDic[data[i].SkillID] = cell;
            }
            else
            {
               cell = new BattleSkillCellGroup();
            }
            cell.x = i % 6 * 46 + int(i % 6) * 19;
            cell.y = int(i / 6) * 46 + int(i / 6) * 34;
            cell.addEventListener(BattleSkillEvent.SKILLCELL_CLICK,cellMouseClick_Handler);
            _skillSpri.addChild(cell);
            _cellList.push(cell);
            i++;
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
         arr.sort(function(a:BattleSkillSkillInfo, b:BattleSkillSkillInfo):int
         {
            if(a.ID < b.ID)
            {
               return -1;
            }
            return 1;
         });
         return arr;
      }
      
      private function update(type:int = -1) : void
      {
         var info:* = null;
         var i:int = 0;
         var real:int = 0;
         for(i = 0; i < _cellList.length; )
         {
            if(_cellList[i].info)
            {
               real = type == -1?_cellList[i].info.Type:int(type);
               info = BattleSkillManager.instance.getActivateSkillInfoByType(real);
               if(info)
               {
                  _cellList[i].info = info;
                  crealListByType(real);
                  _cellsDic[info.SkillID] = _cellList[i];
                  if(type == real)
                  {
                     return;
                  }
               }
            }
            i++;
         }
      }
      
      private function crealListByType(type:int) : void
      {
         var _loc4_:int = 0;
         var _loc3_:* = _cellsDic;
         for(var id in _cellsDic)
         {
            if(_cellsDic[id].info.Type == type)
            {
               delete _cellsDic[id];
               return;
            }
         }
      }
      
      private function cellMouseClick_Handler(evt:BattleSkillEvent) : void
      {
         SoundManager.instance.playButtonSound();
         dispatchEvent(new BattleSkillEvent(BattleSkillEvent.SKILLCELL_CLICK,(evt.target as BattleSkillCellGroup).info.SkillID));
      }
      
      public function dispose() : void
      {
         var i:int = 0;
         for(i = 0; i < _cellList.length; )
         {
            _cellList[i].removeEventListener(BattleSkillEvent.SKILLCELL_CLICK,cellMouseClick_Handler);
            _cellList[i] = null;
            i++;
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
