package room.view
{
   import battleSkill.BattleSkillManager;
   import battleSkill.info.BattleSkillSkillInfo;
   import battleSkill.view.BattleSkillCell;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   
   public class RoomBattleSkillCell extends Sprite implements Disposeable
   {
       
      
      private var _switchGreen:Boolean = false;
      
      private var _xyz:FilterFrameText;
      
      private var _bg:Bitmap;
      
      private var _place:int;
      
      private var _skillInfo:BattleSkillSkillInfo;
      
      private var _skillCell:BattleSkillCell;
      
      public function RoomBattleSkillCell(param1:Boolean, param2:int = 0, param3:Boolean = true){super();}
      
      protected function initView() : void{}
      
      public function get place() : int{return 0;}
      
      public function set skillId(param1:int) : void{}
      
      public function get info() : BattleSkillSkillInfo{return null;}
      
      public function removeInfo() : void{}
      
      public function dispose() : void{}
   }
}
