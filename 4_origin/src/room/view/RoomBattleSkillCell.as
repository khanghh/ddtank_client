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
      
      public function RoomBattleSkillCell(switchGreen:Boolean, index:int = 0, showBg:Boolean = true)
      {
         super();
         _switchGreen = switchGreen;
         _place = index;
         initView();
      }
      
      protected function initView() : void
      {
         if(_switchGreen)
         {
            _bg = ComponentFactory.Instance.creatBitmap("asset.ddtroom.selfCellBgAsset");
            addChild(_bg);
            _xyz = ComponentFactory.Instance.creatComponentByStylename("asset.ddtroom.cellZXC");
            addChild(_xyz);
            switch(int(_place) - 1)
            {
               case 0:
                  _xyz.text = "z";
                  break;
               case 1:
                  _xyz.text = "x";
                  break;
               case 2:
                  _xyz.text = "c";
            }
         }
         else
         {
            _bg = ComponentFactory.Instance.creatBitmap("asset.ddtroom.storeCellBgAsset");
            addChild(_bg);
         }
      }
      
      public function get place() : int
      {
         return _place;
      }
      
      public function set skillId(skillId:int) : void
      {
         if(_skillCell)
         {
            ObjectUtils.disposeObject(_skillCell);
            _skillCell = null;
         }
         buttonMode = false;
         _skillInfo = BattleSkillManager.instance.getBattleSKillInfoBySkillID(skillId);
         if(_skillInfo == null)
         {
            return;
         }
         buttonMode = true;
         _skillCell = new BattleSkillCell(_place,false);
         _skillCell.x = -3;
         _skillCell.y = -2;
         _skillCell.info = _skillInfo;
         addChild(_skillCell);
      }
      
      public function get info() : BattleSkillSkillInfo
      {
         return _skillInfo;
      }
      
      public function removeInfo() : void
      {
         if(_skillCell)
         {
            ObjectUtils.disposeObject(_skillCell);
            _skillCell = null;
         }
         _skillInfo = null;
      }
      
      public function dispose() : void
      {
         if(_bg)
         {
            ObjectUtils.disposeObject(_bg);
         }
         if(_xyz)
         {
            ObjectUtils.disposeObject(_xyz);
         }
         if(_skillCell)
         {
            ObjectUtils.disposeObject(_skillCell);
         }
         _skillCell = null;
         _xyz = null;
         _bg = null;
      }
   }
}
