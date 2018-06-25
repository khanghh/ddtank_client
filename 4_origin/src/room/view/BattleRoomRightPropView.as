package room.view
{
   import battleGroud.BattleGroudControl;
   import battleSkill.BattleSkillManager;
   import battleSkill.event.BattleSkillEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ClassUtils;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.events.CEvent;
   import ddt.manager.LanguageMgr;
   import ddt.manager.ServerConfigManager;
   import ddt.manager.ServerManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.utils.Dictionary;
   import road7th.data.DictionaryData;
   import room.RoomManager;
   import room.model.RoomInfo;
   
   public class BattleRoomRightPropView extends RoomRightPropView
   {
       
      
      private var _watchIco:Bitmap;
      
      private var _watchBg:Bitmap;
      
      private var _downContainer:HBox;
      
      protected var _combatskillIcon:BaseButton;
      
      protected var _lastFightNumTxt:FilterFrameText;
      
      protected var _lastFightValueTxt:FilterFrameText;
      
      protected var _upSkillCells:DictionaryData;
      
      protected var _allSkillCells:DictionaryData;
      
      private var _downCells:DictionaryData;
      
      public function BattleRoomRightPropView()
      {
         super();
      }
      
      override protected function initView() : void
      {
         _bg = ClassUtils.CreatInstance("asset.background.room.left") as MovieClip;
         addChild(_bg);
         _secBg = ComponentFactory.Instance.creatComponentByStylename("asset.ddtroom.battleRoomRightPropView.secbg");
         addChild(_secBg);
         _watchBg = ComponentFactory.Instance.creatBitmap("asset.ddtroom.watch.bg");
         _watchBg.x = 12;
         _watchBg.y = 328;
         addChild(_watchBg);
         _combatskillIcon = ComponentFactory.Instance.creatComponentByStylename("asset.ddtroom.battleSkillBtn");
         addChild(_combatskillIcon);
         _lastFightNumTxt = ComponentFactory.Instance.creatComponentByStylename("asset.ddtroom.battleRoomCountText");
         addChild(_lastFightNumTxt);
         _lastFightNumTxt.text = LanguageMgr.GetTranslation("ddt.battleRoom.lastFightNum.TxtMsg");
         _lastFightValueTxt = ComponentFactory.Instance.creatComponentByStylename("asset.ddtroom.battleRoomCountValueText");
         addChild(_lastFightValueTxt);
         _upCellsContainer = ComponentFactory.Instance.creatCustomObject("asset.ddtroom.upCellsContainer");
         addChild(_upCellsContainer);
         _downContainer = ComponentFactory.Instance.creatCustomObject("asset.ddtroom.upCellsContainer");
         PositionUtils.setPos(_downContainer,"ddtroom.upCellsContainerPos");
         addChild(_downContainer);
         _allSkillCells = new DictionaryData();
         createChanelName();
         createRoomName();
         createInitiativeSkillList();
         createPassiveSkillList();
      }
      
      protected function createInitiativeSkillList() : void
      {
         var i:int = 0;
         var cell:* = null;
         _upSkillCells = new DictionaryData();
         for(i = 1; i <= 3; )
         {
            cell = new RoomBattleSkillCell(true,i);
            _upCellsContainer.addChild(cell);
            _upSkillCells[i] = cell;
            _allSkillCells[i] = cell;
            i++;
         }
      }
      
      protected function createPassiveSkillList() : void
      {
         var j:int = 0;
         var cell1:* = null;
         _downCells = new DictionaryData();
         for(j = 4; j <= 6; )
         {
            cell1 = new RoomBattleSkillCell(true,j);
            cell1.x = 2 + j % 3 * 65;
            cell1.y = 2 + int(j / 3) * 49;
            _downContainer.addChild(cell1);
            _downCells[j] = cell1;
            _allSkillCells[j] = cell1;
            j++;
         }
      }
      
      protected function createChanelName() : void
      {
         _chanelNameTxt = ComponentFactory.Instance.creatComponentByStylename("asset.ddtroom.ChanelNameText");
         addChild(_chanelNameTxt);
         _chanelNameTxt.text = ServerManager.Instance.current.Name;
      }
      
      protected function createRoomName() : void
      {
         _roomNameTxt = ComponentFactory.Instance.creatComponentByStylename("asset.ddtroom.roomNameText");
         addChild(_roomNameTxt);
         _roomIdTxt = ComponentFactory.Instance.creatComponentByStylename("room.roomID.text");
         addChild(_roomIdTxt);
         var roomInfo:RoomInfo = RoomManager.Instance.current;
         if(roomInfo)
         {
            _roomIdTxt.text = roomInfo.ID.toString();
            _roomNameTxt.text = RoomManager.Instance.current.Name;
         }
      }
      
      private function updateRemainCount() : void
      {
         _lastFightValueTxt.text = getFightRemainData;
      }
      
      private function get getFightRemainData() : String
      {
         var str:String = "";
         var prestigeTimes:int = BattleGroudControl.Instance.orderdata.prestigeTimes;
         str = (prestigeTimes < 0?0:prestigeTimes) + "/" + ServerConfigManager.instance.getPrestigeTimes + "\n\n";
         return str + BattleGroudControl.Instance.orderdata.addDayPrestge.toString() + "/" + ServerConfigManager.instance.getDayMaxAddPrestige;
      }
      
      override protected function initEvents() : void
      {
         _combatskillIcon.addEventListener("click",openBattleSkillFrame);
         RoomManager.Instance.addEventListener("update_battle_remain",__updateBattleRemainData);
         BattleSkillManager.instance.addEventListener(BattleSkillEvent.BRIGHT_SKILL,updateProView);
         BattleSkillManager.instance.addEventListener(BattleSkillEvent.BATTLESKILL_INFO,updateProView);
         BattleSkillManager.instance.addEventListener(BattleSkillEvent.UPDATE_SKILL,updateProView);
      }
      
      protected function updateProView(evt:BattleSkillEvent) : void
      {
         var cellPlace:int = 0;
         var skillDic:Dictionary = BattleSkillManager.instance.getBringSkillList();
         var _loc6_:int = 0;
         var _loc5_:* = _allSkillCells;
         for(var key in _allSkillCells)
         {
            cellPlace = _allSkillCells[key].place;
            if(skillDic[cellPlace] == 0)
            {
               _allSkillCells[key].removeInfo();
            }
            else
            {
               _allSkillCells[key].skillId = skillDic[cellPlace];
            }
         }
      }
      
      protected function __updateBattleRemainData(e:CEvent) : void
      {
         updateRemainCount();
      }
      
      override protected function removeEvents() : void
      {
         _combatskillIcon.removeEventListener("click",openBattleSkillFrame);
         RoomManager.Instance.removeEventListener("update_battle_remain",__updateBattleRemainData);
         BattleSkillManager.instance.removeEventListener(BattleSkillEvent.BRIGHT_SKILL,updateProView);
         BattleSkillManager.instance.removeEventListener(BattleSkillEvent.BATTLESKILL_INFO,updateProView);
         BattleSkillManager.instance.removeEventListener(BattleSkillEvent.UPDATE_SKILL,updateProView);
      }
      
      override protected function creatTipShapeTip() : void
      {
         _upCellsStripTip = ComponentFactory.Instance.creatCustomObject("asset.ddtroom.upRightPropTip");
         _downCellsStripTip = ComponentFactory.Instance.creatCustomObject("asset.ddtroom.downRightPropTip");
         _upCellsStripTip.tipData = LanguageMgr.GetTranslation("room.roomRightPropView.uppropTip");
         _downCellsStripTip.tipData = LanguageMgr.GetTranslation("room.roomRightPropView.downpropTip");
         addChild(_upCellsStripTip);
         addChild(_downCellsStripTip);
      }
      
      override protected function updateSkillStatus(event:Event) : void
      {
      }
      
      private function openBattleSkillFrame(evt:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
         BattleSkillManager.instance.show();
      }
      
      override public function dispose() : void
      {
         removeEvents();
         if(_bg)
         {
            ObjectUtils.disposeObject(_bg);
         }
         _bg = null;
         if(_secBg)
         {
            ObjectUtils.disposeObject(_secBg);
         }
         _secBg = null;
         if(_watchBg)
         {
            ObjectUtils.disposeObject(_watchBg);
         }
         _watchBg = null;
         if(_combatskillIcon)
         {
            ObjectUtils.disposeObject(_combatskillIcon);
         }
         _combatskillIcon = null;
         if(_lastFightNumTxt)
         {
            ObjectUtils.disposeObject(_lastFightNumTxt);
         }
         _lastFightNumTxt = null;
         if(_lastFightValueTxt)
         {
            ObjectUtils.disposeObject(_lastFightValueTxt);
         }
         _lastFightValueTxt = null;
         if(_roomIdTxt)
         {
            _roomIdTxt.dispose();
            _roomIdTxt = null;
         }
         if(_downCells)
         {
            _downCells.clear();
         }
         if(_upSkillCells)
         {
            _upSkillCells.clear();
         }
         if(_allSkillCells)
         {
            _allSkillCells.clear();
         }
         _upSkillCells = null;
         _allSkillCells = null;
         _downCells = null;
         _upCellsContainer.dispose();
         _upCellsContainer = null;
         _downContainer.dispose();
         _downContainer = null;
         _chanelNameTxt.dispose();
         _chanelNameTxt = null;
         _roomNameTxt.dispose();
         _roomNameTxt = null;
         if(_upCellsStripTip)
         {
            ObjectUtils.disposeObject(_upCellsStripTip);
         }
         _upCellsStripTip = null;
         if(_downCellsStripTip)
         {
            ObjectUtils.disposeObject(_downCellsStripTip);
         }
         _downCellsStripTip = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
