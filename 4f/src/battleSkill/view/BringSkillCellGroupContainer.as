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
      
      public function BringSkillCellGroupContainer(){super();}
      
      private function initView() : void{}
      
      public function initBringSkillCellGroup() : void{}
      
      public function updateBringSkill(param1:Array) : void{}
      
      private function createSkillCell(param1:int, param2:int) : void{}
      
      private function cellMouseClick_Handler(param1:MouseEvent) : void{}
      
      public function dispose() : void{}
   }
}
