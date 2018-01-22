package room.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.utils.ClassUtils;
   import ddt.events.RoomEvent;
   import ddt.manager.PlayerManager;
   import ddt.manager.ServerManager;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import horse.HorseManager;
   import horse.data.HorseSkillExpVo;
   import road7th.data.DictionaryData;
   
   public class SingleRoomRightPropView extends RoomRightPropView
   {
       
      
      public function SingleRoomRightPropView(param1:Boolean = false)
      {
         super(param1);
      }
      
      override protected function initView() : void
      {
         var _loc8_:int = 0;
         var _loc4_:* = null;
         var _loc7_:int = 0;
         var _loc5_:* = null;
         _bg = ClassUtils.CreatInstance("asset.background.room.left") as MovieClip;
         addChild(_bg);
         _secBg = ComponentFactory.Instance.creatComponentByStylename("asset.ddtroom.roomRightPropView.secbg");
         addChild(_secBg);
         _upCellsContainer = ComponentFactory.Instance.creatCustomObject("asset.ddtroom.upCellsContainer");
         addChild(_upCellsContainer);
         _downCellsContainer = ComponentFactory.Instance.creatCustomObject("asset.ddtroom.downCellsContainer",[3]);
         _downCellsScrollPanel = ComponentFactory.Instance.creatComponentByStylename("asset.ddtroom.downCellsScrollPanel");
         addChild(_downCellsScrollPanel);
         _upCells = new Vector.<RoomPropCell>();
         _loc8_ = 0;
         while(_loc8_ < 3)
         {
            if(equalitySkill)
            {
               _loc4_ = new RoomEqualityPropCell(true,_loc8_);
            }
            else
            {
               _loc4_ = new RoomPropCell(true,_loc8_);
            }
            _upCellsContainer.addChild(_loc4_);
            _upCells.push(_loc4_);
            _loc8_++;
         }
         _downCellsSprite = new Sprite();
         var _loc1_:Vector.<HorseSkillExpVo> = null;
         if(equalitySkill)
         {
            _loc1_ = HorseManager.instance.curHasBattleSkillList;
         }
         else
         {
            _loc1_ = HorseManager.instance.curHasSkillList;
         }
         var _loc3_:int = _loc1_.length;
         _loc7_ = 0;
         while(_loc7_ < _loc3_)
         {
            if(equalitySkill)
            {
               _loc5_ = new RoomEqualityPropCell(false,_loc8_);
            }
            else
            {
               _loc5_ = new RoomPropCell(false,_loc8_);
            }
            _loc5_.x = 2 + _loc7_ % 3 * 54;
            _loc5_.y = 2 + int(_loc7_ / 3) * 49;
            _downCellsSprite.addChild(_loc5_);
            _loc5_.skillId = _loc1_[_loc7_].skillId;
            _loc7_++;
         }
         _downCellsScrollPanel.setView(_downCellsSprite);
         _chanelNameTxt = ComponentFactory.Instance.creatComponentByStylename("asset.ddtroom.ChanelNameText");
         addChild(_chanelNameTxt);
         _roomNameTxt = ComponentFactory.Instance.creatComponentByStylename("asset.ddtroom.roomNameText");
         addChild(_roomNameTxt);
         var _loc2_:DictionaryData = null;
         if(equalitySkill)
         {
            _loc2_ = HorseManager.instance.curUseBattleSkillList;
         }
         else
         {
            _loc2_ = HorseManager.instance.curUseSkillList;
         }
         var _loc10_:int = 0;
         var _loc9_:* = _loc2_;
         for(var _loc6_ in _loc2_)
         {
            _upCells[int(_loc6_) - 1].skillId = _loc2_[_loc6_];
         }
         _chanelNameTxt.text = ServerManager.Instance.current.Name;
         creatTipShapeTip();
         _bg.parent.removeChild(_bg);
         _secBg.parent.removeChild(_secBg);
         _roomNameTxt.parent.removeChild(_roomNameTxt);
         _chanelNameTxt.parent.removeChild(_chanelNameTxt);
      }
      
      override protected function initEvents() : void
      {
         PlayerManager.Instance.Self.addEventListener("propertychange",__updateGold);
         HorseManager.instance.addEventListener("horseTakeUpDownSkill",updateSkillStatus);
      }
      
      override protected function removeEvents() : void
      {
         PlayerManager.Instance.Self.removeEventListener("propertychange",__updateGold);
         HorseManager.instance.removeEventListener("horseTakeUpDownSkill",updateSkillStatus);
      }
      
      override protected function _roomNameChanged(param1:RoomEvent) : void
      {
      }
   }
}
