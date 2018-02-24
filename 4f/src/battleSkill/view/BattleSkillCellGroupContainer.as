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
      
      public function BattleSkillCellGroupContainer(param1:Array){super();}
      
      private function initView() : void{}
      
      public function createSkillGroup(param1:Dictionary) : void{}
      
      private function getFiltrationData() : Array{return null;}
      
      private function update(param1:int = -1) : void{}
      
      private function crealListByType(param1:int) : void{}
      
      private function cellMouseClick_Handler(param1:BattleSkillEvent) : void{}
      
      public function dispose() : void{}
   }
}
