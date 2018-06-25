package room.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.controls.container.SimpleTileList;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ClassUtils;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.command.StripTip;
   import ddt.events.PlayerPropertyEvent;
   import ddt.events.RoomEvent;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.ServerManager;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import horse.HorseManager;
   import horse.data.HorseSkillExpVo;
   import road7th.data.DictionaryData;
   import room.RoomManager;
   import room.model.RoomInfo;
   
   public class RoomRightPropView extends Sprite implements Disposeable
   {
      
      public static const UPCELLS_NUMBER:int = 3;
       
      
      protected var _bg:MovieClip;
      
      protected var _secBg:MutipleImage;
      
      protected var _upCells:Vector.<RoomPropCell>;
      
      protected var _upCellsContainer:HBox;
      
      protected var _downCellsContainer:SimpleTileList;
      
      protected var _downCellsSprite:Sprite;
      
      protected var _downCellsScrollPanel:ScrollPanel;
      
      protected var _roomIdTxt:FilterFrameText;
      
      protected var _chanelNameTxt:FilterFrameText;
      
      protected var _goldInfoTxt:FilterFrameText;
      
      protected var _roomNameTxt:FilterFrameText;
      
      protected var _upCellsStripTip:StripTip;
      
      protected var _downCellsStripTip:StripTip;
      
      protected var _energySprite:Sprite;
      
      protected var _energyBitmap:Bitmap;
      
      protected var _energyNum:FilterFrameText;
      
      protected var equalitySkill:Boolean;
      
      public function RoomRightPropView(isEqual:Boolean = false)
      {
         equalitySkill = isEqual;
         super();
         initView();
         initEvents();
      }
      
      protected function initView() : void
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
            cell = new RoomPropCell(true,i);
            _upCellsContainer.addChild(cell);
            _upCells.push(cell);
            i++;
         }
         _downCellsSprite = new Sprite();
         var tmpHasSkillList:Vector.<HorseSkillExpVo> = HorseManager.instance.curHasSkillList;
         var tmpLen:int = tmpHasSkillList.length;
         for(j = 0; j < tmpLen; )
         {
            cell1 = new RoomPropCell(false,i);
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
         _energySprite = new Sprite();
         addChild(_energySprite);
         PositionUtils.setPos(_energySprite,"asset.room.lastEnergyPos");
         _energyBitmap = ComponentFactory.Instance.creat("asset.ddtroom.lastEnergy");
         _energySprite.addChild(_energyBitmap);
         _energyNum = ComponentFactory.Instance.creatComponentByStylename("room.lastEnergy.numText");
         _energyNum.text = PlayerManager.Instance.Self.energy.toString();
         _energySprite.addChild(_energyNum);
         var tmpUseSkillList:DictionaryData = HorseManager.instance.curUseSkillList;
         var _loc11_:int = 0;
         var _loc10_:* = tmpUseSkillList;
         for(var place in tmpUseSkillList)
         {
            _upCells[int(place) - 1].skillId = tmpUseSkillList[place];
         }
         var roomInfo:RoomInfo = RoomManager.Instance.current;
         if(roomInfo)
         {
            _roomIdTxt = ComponentFactory.Instance.creatComponentByStylename("room.roomID.text");
            _roomIdTxt.text = roomInfo.ID.toString();
            addChild(_roomIdTxt);
            if(roomInfo.type != 4 && roomInfo.type != 123)
            {
               _roomNameTxt.text = roomInfo.Name;
               _energySprite.visible = false;
            }
            else
            {
               _energySprite.visible = true;
               _roomNameTxt.text = "";
            }
         }
         _chanelNameTxt.text = ServerManager.Instance.current.Name;
         creatTipShapeTip();
      }
      
      protected function initEvents() : void
      {
         PlayerManager.Instance.Self.addEventListener("propertychange",__updateGold);
         HorseManager.instance.addEventListener("horseTakeUpDownSkill",updateSkillStatus);
         if(RoomManager.Instance.current)
         {
            RoomManager.Instance.current.addEventListener("roomNameChanged",_roomNameChanged);
         }
      }
      
      protected function removeEvents() : void
      {
         PlayerManager.Instance.Self.removeEventListener("propertychange",__updateGold);
         HorseManager.instance.removeEventListener("horseTakeUpDownSkill",updateSkillStatus);
         if(RoomManager.Instance.current)
         {
            RoomManager.Instance.current.removeEventListener("roomNameChanged",_roomNameChanged);
         }
      }
      
      protected function _roomNameChanged(evt:RoomEvent) : void
      {
         if(RoomManager.Instance.current.type != 4 && RoomManager.Instance.current.type != 123)
         {
            _roomNameTxt.text = RoomManager.Instance.current.Name;
         }
      }
      
      protected function creatTipShapeTip() : void
      {
         _upCellsStripTip = ComponentFactory.Instance.creatCustomObject("asset.ddtroom.upRightPropTip");
         _downCellsStripTip = ComponentFactory.Instance.creatCustomObject("asset.ddtroom.downRightPropTip");
         _upCellsStripTip.tipData = LanguageMgr.GetTranslation("room.roomRightPropView.uppropTip");
         _downCellsStripTip.tipData = LanguageMgr.GetTranslation("room.roomRightPropView.downpropTip");
         addChild(_upCellsStripTip);
         addChild(_downCellsStripTip);
      }
      
      protected function __updateGold(evt:PlayerPropertyEvent) : void
      {
         if(!evt.changedProperties["Gold"])
         {
         }
      }
      
      protected function updateSkillStatus(event:Event) : void
      {
         var tmpUseSkillList:* = null;
         var i:int = 0;
         var tmpKey:* = null;
         if(equalitySkill)
         {
            tmpUseSkillList = HorseManager.instance.curUseBattleSkillList;
         }
         else
         {
            tmpUseSkillList = HorseManager.instance.curUseSkillList;
         }
         var tmplen:int = _upCells.length;
         for(i = 0; i < tmplen; )
         {
            tmpKey = (i + 1).toString();
            if(tmpUseSkillList.hasKey(tmpKey))
            {
               _upCells[i].skillId = tmpUseSkillList[tmpKey];
            }
            else
            {
               _upCells[i].skillId = 0;
            }
            i++;
         }
      }
      
      public function dispose() : void
      {
         removeEvents();
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         if(_secBg)
         {
            ObjectUtils.disposeObject(_secBg);
         }
         _secBg = null;
         if(_roomIdTxt)
         {
            _roomIdTxt.dispose();
            _roomIdTxt = null;
         }
         _upCells = null;
         _upCellsContainer.dispose();
         _upCellsContainer = null;
         _downCellsContainer.dispose();
         _downCellsContainer = null;
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
         ObjectUtils.disposeAllChildren(_downCellsSprite);
         ObjectUtils.disposeObject(_downCellsSprite);
         _downCellsSprite = null;
         ObjectUtils.disposeObject(_downCellsScrollPanel);
         _downCellsScrollPanel = null;
         ObjectUtils.disposeObject(_energyBitmap);
         _energyBitmap = null;
         ObjectUtils.disposeObject(_energyNum);
         _energyNum = null;
         ObjectUtils.disposeObject(_energySprite);
         _energySprite = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
