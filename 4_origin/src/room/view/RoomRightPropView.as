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
      
      public function RoomRightPropView(param1:Boolean = false)
      {
         equalitySkill = param1;
         super();
         initView();
         initEvents();
      }
      
      protected function initView() : void
      {
         var _loc9_:int = 0;
         var _loc5_:* = null;
         var _loc8_:int = 0;
         var _loc6_:* = null;
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
         _loc9_ = 0;
         while(_loc9_ < 3)
         {
            _loc5_ = new RoomPropCell(true,_loc9_);
            _upCellsContainer.addChild(_loc5_);
            _upCells.push(_loc5_);
            _loc9_++;
         }
         _downCellsSprite = new Sprite();
         var _loc1_:Vector.<HorseSkillExpVo> = HorseManager.instance.curHasSkillList;
         var _loc3_:int = _loc1_.length;
         _loc8_ = 0;
         while(_loc8_ < _loc3_)
         {
            _loc6_ = new RoomPropCell(false,_loc9_);
            _loc6_.x = 2 + _loc8_ % 3 * 54;
            _loc6_.y = 2 + int(_loc8_ / 3) * 49;
            _downCellsSprite.addChild(_loc6_);
            _loc6_.skillId = _loc1_[_loc8_].skillId;
            _loc8_++;
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
         var _loc2_:DictionaryData = HorseManager.instance.curUseSkillList;
         var _loc11_:int = 0;
         var _loc10_:* = _loc2_;
         for(var _loc7_ in _loc2_)
         {
            _upCells[int(_loc7_) - 1].skillId = _loc2_[_loc7_];
         }
         var _loc4_:RoomInfo = RoomManager.Instance.current;
         if(_loc4_)
         {
            _roomIdTxt = ComponentFactory.Instance.creatComponentByStylename("room.roomID.text");
            _roomIdTxt.text = _loc4_.ID.toString();
            addChild(_roomIdTxt);
            if(_loc4_.type != 4 && _loc4_.type != 123)
            {
               _roomNameTxt.text = _loc4_.Name;
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
      
      protected function _roomNameChanged(param1:RoomEvent) : void
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
      
      protected function __updateGold(param1:PlayerPropertyEvent) : void
      {
         if(!param1.changedProperties["Gold"])
         {
         }
      }
      
      protected function updateSkillStatus(param1:Event) : void
      {
         var _loc4_:* = null;
         var _loc5_:int = 0;
         var _loc2_:* = null;
         if(equalitySkill)
         {
            _loc4_ = HorseManager.instance.curUseBattleSkillList;
         }
         else
         {
            _loc4_ = HorseManager.instance.curUseSkillList;
         }
         var _loc3_:int = _upCells.length;
         _loc5_ = 0;
         while(_loc5_ < _loc3_)
         {
            _loc2_ = (_loc5_ + 1).toString();
            if(_loc4_.hasKey(_loc2_))
            {
               _upCells[_loc5_].skillId = _loc4_[_loc2_];
            }
            else
            {
               _upCells[_loc5_].skillId = 0;
            }
            _loc5_++;
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
