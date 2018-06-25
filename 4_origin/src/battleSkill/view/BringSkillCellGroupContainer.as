package battleSkill.view
{
   import battleSkill.BattleSkillManager;
   import battleSkill.event.BattleSkillEvent;
   import battleSkill.info.BattleSkillSkillInfo;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.SoundManager;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.utils.Dictionary;
   import horse.HorseManager;
   import horse.data.HorseSkillVo;
   import room.RoomManager;
   
   public class BringSkillCellGroupContainer extends Sprite implements Disposeable
   {
      
      private static const CELL_NUM:int = 6;
       
      
      private var _hBox:HBox;
      
      private var _initiativeSpri:Sprite;
      
      private var _passiveSpri:Sprite;
      
      public var _allCells:Dictionary;
      
      private var _zFilterTxt:FilterFrameText;
      
      private var _xFilterTxt:FilterFrameText;
      
      private var _cFilterFtxt:FilterFrameText;
      
      private var cell:BattleSkillCell;
      
      private var info:BattleSkillSkillInfo;
      
      public function BringSkillCellGroupContainer()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _hBox = ComponentFactory.Instance.creatComponentByStylename("battleSkill.bringSkill.cellBoxAsset");
         addChild(_hBox);
         _initiativeSpri = new Sprite();
         _passiveSpri = new Sprite();
         _hBox.addChild(_initiativeSpri);
         _hBox.addChild(_passiveSpri);
         _allCells = new Dictionary();
         _zFilterTxt = ComponentFactory.Instance.creatComponentByStylename("battleSkill.cellKey.ZXC");
         _zFilterTxt.x = 33;
         _zFilterTxt.y = 415;
         _zFilterTxt.text = "Z";
         addChild(_zFilterTxt);
         _xFilterTxt = ComponentFactory.Instance.creatComponentByStylename("battleSkill.cellKey.ZXC");
         _xFilterTxt.text = "X";
         _xFilterTxt.x = 96;
         _xFilterTxt.y = 415;
         addChild(_xFilterTxt);
         _cFilterFtxt = ComponentFactory.Instance.creatComponentByStylename("battleSkill.cellKey.ZXC");
         _cFilterFtxt.text = "C";
         _cFilterFtxt.x = 158;
         _cFilterFtxt.y = 415;
         addChild(_cFilterFtxt);
      }
      
      public function initBringSkillCellGroup() : void
      {
         var skillId:int = 0;
         var skillInfo:* = null;
         var bringSkills:Dictionary = BattleSkillManager.instance.getBringSkillList();
         var _loc6_:int = 0;
         var _loc5_:* = bringSkills;
         for(var place in bringSkills)
         {
            skillId = bringSkills[place];
            if(skillId != 0)
            {
               if(RoomManager.Instance.current && 123 == RoomManager.Instance.current.type)
               {
                  skillInfo = HorseManager.instance.getHorseSkillInfoById(skillId);
                  if(skillInfo && skillInfo.GameType != 0)
                  {
                     continue;
                  }
               }
               createSkillCell(skillId,int(place));
            }
         }
      }
      
      public function updateBringSkill(skillArr:Array) : void
      {
         var skillId:int = skillArr[0];
         var place:int = skillArr[1];
         var isBring:Boolean = true;
         var temCell:* = null;
         var _loc8_:int = 0;
         var _loc7_:* = _allCells;
         for each(var cell in _allCells)
         {
            if(cell.info.SkillID == skillId && place == 0)
            {
               isBring = false;
               temCell = cell;
               break;
            }
         }
         if(isBring)
         {
            createSkillCell(skillId,place);
         }
         else
         {
            delete _allCells[temCell.info.SkillID];
            if(_initiativeSpri.contains(temCell))
            {
               _initiativeSpri.removeChild(temCell);
            }
            if(_passiveSpri.contains(temCell))
            {
               _passiveSpri.removeChild(temCell);
            }
            ObjectUtils.disposeObject(temCell);
            temCell = null;
         }
      }
      
      private function createSkillCell(skillId:int, place:int) : void
      {
         if(_allCells && _allCells[skillId])
         {
            return;
         }
         info = BattleSkillManager.instance.getBattleSKillInfoBySkillID(skillId);
         cell = new BattleSkillCell();
         cell.info = info;
         cell.x = (int(place - 1)) % 3 * 46 + (place - 1) % 3 * 15;
         cell.addEventListener("click",cellMouseClick_Handler);
         if(_initiativeSpri != null && _passiveSpri != null)
         {
            place <= 3?_initiativeSpri.addChild(cell):_passiveSpri.addChild(cell);
         }
         _allCells[info.SkillID] = cell;
      }
      
      private function cellMouseClick_Handler(evt:MouseEvent) : void
      {
         var skillId:int = 0;
         SoundManager.instance.playButtonSound();
         if(evt.target is BattleSkillCell)
         {
            skillId = (evt.target as BattleSkillCell).info.SkillID;
         }
         else if(evt.target.parent is BattleSkillCell)
         {
            skillId = (evt.target.parent as BattleSkillCell).info.SkillID;
         }
         this.dispatchEvent(new BattleSkillEvent(BattleSkillEvent.SKILLCELL_CLICK,skillId));
      }
      
      public function dispose() : void
      {
         if(_initiativeSpri)
         {
            ObjectUtils.disposeAllChildren(_initiativeSpri);
            ObjectUtils.disposeObject(_initiativeSpri);
         }
         if(_passiveSpri)
         {
            ObjectUtils.disposeAllChildren(_passiveSpri);
            ObjectUtils.disposeObject(_passiveSpri);
         }
         if(_hBox)
         {
            _hBox.removeAllChild();
            ObjectUtils.disposeObject(_hBox);
         }
         _allCells = null;
         info = null;
         cell = null;
         _initiativeSpri = null;
         _passiveSpri = null;
         _hBox = null;
         if(this && this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}
