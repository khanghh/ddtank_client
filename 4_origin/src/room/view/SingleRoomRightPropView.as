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
       
      
      public function SingleRoomRightPropView(isEqual:Boolean = false)
      {
         super(isEqual);
      }
      
      override protected function initView() : void
      {
         var i:int = 0;
         var cell:* = null;
         var j:int = 0;
         var cell1:* = null;
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
         for(i = 0; i < 3; )
         {
            if(equalitySkill)
            {
               cell = new RoomEqualityPropCell(true,i);
            }
            else
            {
               cell = new RoomPropCell(true,i);
            }
            _upCellsContainer.addChild(cell);
            _upCells.push(cell);
            i++;
         }
         _downCellsSprite = new Sprite();
         var tmpHasSkillList:Vector.<HorseSkillExpVo> = null;
         if(equalitySkill)
         {
            tmpHasSkillList = HorseManager.instance.curHasBattleSkillList;
         }
         else
         {
            tmpHasSkillList = HorseManager.instance.curHasSkillList;
         }
         var tmpLen:int = tmpHasSkillList.length;
         for(j = 0; j < tmpLen; )
         {
            if(equalitySkill)
            {
               cell1 = new RoomEqualityPropCell(false,i);
            }
            else
            {
               cell1 = new RoomPropCell(false,i);
            }
            cell1.x = 2 + j % 3 * 54;
            cell1.y = 2 + int(j / 3) * 49;
            _downCellsSprite.addChild(cell1);
            cell1.skillId = tmpHasSkillList[j].skillId;
            j++;
         }
         _downCellsScrollPanel.setView(_downCellsSprite);
         _chanelNameTxt = ComponentFactory.Instance.creatComponentByStylename("asset.ddtroom.ChanelNameText");
         addChild(_chanelNameTxt);
         _roomNameTxt = ComponentFactory.Instance.creatComponentByStylename("asset.ddtroom.roomNameText");
         addChild(_roomNameTxt);
         var tmpUseSkillList:DictionaryData = null;
         if(equalitySkill)
         {
            tmpUseSkillList = HorseManager.instance.curUseBattleSkillList;
         }
         else
         {
            tmpUseSkillList = HorseManager.instance.curUseSkillList;
         }
         var _loc10_:int = 0;
         var _loc9_:* = tmpUseSkillList;
         for(var place in tmpUseSkillList)
         {
            _upCells[int(place) - 1].skillId = tmpUseSkillList[place];
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
      
      override protected function _roomNameChanged(evt:RoomEvent) : void
      {
      }
   }
}
