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
         var _loc1_:int = 0;
         var _loc3_:* = null;
         var _loc4_:Dictionary = BattleSkillManager.instance.getBringSkillList();
         var _loc6_:int = 0;
         var _loc5_:* = _loc4_;
         for(var _loc2_ in _loc4_)
         {
            _loc1_ = _loc4_[_loc2_];
            if(_loc1_ != 0)
            {
               if(RoomManager.Instance.current && 123 == RoomManager.Instance.current.type)
               {
                  _loc3_ = HorseManager.instance.getHorseSkillInfoById(_loc1_);
                  if(_loc3_ && _loc3_.GameType != 0)
                  {
                     continue;
                  }
               }
               createSkillCell(_loc1_,int(_loc2_));
            }
         }
      }
      
      public function updateBringSkill(param1:Array) : void
      {
         var _loc5_:int = param1[0];
         var _loc6_:int = param1[1];
         var _loc2_:Boolean = true;
         var _loc4_:* = null;
         var _loc8_:int = 0;
         var _loc7_:* = _allCells;
         for each(var _loc3_ in _allCells)
         {
            if(_loc3_.info.SkillID == _loc5_ && _loc6_ == 0)
            {
               _loc2_ = false;
               _loc4_ = _loc3_;
               break;
            }
         }
         if(_loc2_)
         {
            createSkillCell(_loc5_,_loc6_);
         }
         else
         {
            delete _allCells[_loc4_.info.SkillID];
            if(_initiativeSpri.contains(_loc4_))
            {
               _initiativeSpri.removeChild(_loc4_);
            }
            if(_passiveSpri.contains(_loc4_))
            {
               _passiveSpri.removeChild(_loc4_);
            }
            ObjectUtils.disposeObject(_loc4_);
            _loc4_ = null;
         }
      }
      
      private function createSkillCell(param1:int, param2:int) : void
      {
         if(_allCells && _allCells[param1])
         {
            return;
         }
         info = BattleSkillManager.instance.getBattleSKillInfoBySkillID(param1);
         cell = new BattleSkillCell();
         cell.info = info;
         cell.x = (int(param2 - 1)) % 3 * 46 + (param2 - 1) % 3 * 15;
         cell.addEventListener("click",cellMouseClick_Handler);
         if(_initiativeSpri != null && _passiveSpri != null)
         {
            param2 <= 3?_initiativeSpri.addChild(cell):_passiveSpri.addChild(cell);
         }
         _allCells[info.SkillID] = cell;
      }
      
      private function cellMouseClick_Handler(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         SoundManager.instance.playButtonSound();
         if(param1.target is BattleSkillCell)
         {
            _loc2_ = (param1.target as BattleSkillCell).info.SkillID;
         }
         else if(param1.target.parent is BattleSkillCell)
         {
            _loc2_ = (param1.target.parent as BattleSkillCell).info.SkillID;
         }
         this.dispatchEvent(new BattleSkillEvent(BattleSkillEvent.SKILLCELL_CLICK,_loc2_));
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
