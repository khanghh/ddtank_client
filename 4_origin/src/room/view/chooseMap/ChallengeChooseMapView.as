package room.view.chooseMap
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.loader.DisplayLoader;
   import com.pickgliss.loader.LoadResourceManager;
   import com.pickgliss.loader.LoaderEvent;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.SelectedButton;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.SelectedCheckButton;
   import com.pickgliss.ui.controls.TextInput;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.controls.container.SimpleTileList;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.text.TextArea;
   import com.pickgliss.ui.vo.AlertInfo;
   import com.pickgliss.utils.ClassUtils;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.map.MapInfo;
   import ddt.manager.GameInSocketOut;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MapManager;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PathManager;
   import ddt.manager.SoundManager;
   import ddt.utils.FilterWordManager;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import road7th.data.DictionaryData;
   import room.RoomManager;
   
   public class ChallengeChooseMapView extends Sprite implements Disposeable
   {
      
      public static const DEFAULT_MODE:int = 2;
      
      public static const OTHER_MODE:int = 60;
      
      public static const TEST_MODE:int = 120;
       
      
      private var _frame:BaseAlerFrame;
      
      private var _roomMode:Bitmap;
      
      private var _challenge:Bitmap;
      
      private var _roomModeBg:ScaleBitmapImage;
      
      private var _namePassBg:ScaleBitmapImage;
      
      private var _roomName:FilterFrameText;
      
      private var _roomPass:FilterFrameText;
      
      private var _nameInput:TextInput;
      
      private var _passInput:TextInput;
      
      private var _checkBox:SelectedCheckButton;
      
      private var _timeBg:ScaleBitmapImage;
      
      private var _timebtnBg:ScaleBitmapImage;
      
      private var _time:Bitmap;
      
      private var _roundTime5sec:SelectedButton;
      
      private var _roundTime7sec:SelectedButton;
      
      private var _roundTime10sec:SelectedButton;
      
      private var _roundTimeGroup:SelectedButtonGroup;
      
      private var _chooseMapBg:MovieClip;
      
      private var _mapsBg:MutipleImage;
      
      private var _mapList:SimpleTileList;
      
      private var _srollPanel:ScrollPanel;
      
      private var _descriptionBg:ScaleBitmapImage;
      
      private var _descriptbg:ScaleBitmapImage;
      
      private var _prvviewbg:ScaleBitmapImage;
      
      private var _mapDecription:TextArea;
      
      private var _mapPreview:Sprite;
      
      private var _titlePreview:Sprite;
      
      private var _previewLoader:DisplayLoader;
      
      private var _titleLoader:DisplayLoader;
      
      private var _currentSelectedItem:BaseMapItem;
      
      private var _mapInfoList:DictionaryData;
      
      private var _mapId:int;
      
      private var _isReset:Boolean;
      
      private var _isChanged:Boolean = false;
      
      private var _defaultModeBtn:SelectedButton;
      
      private var _otherModeBtn:SelectedButton;
      
      private var _testModeBtn:SelectedButton;
      
      private var _btnGroup:SelectedButtonGroup;
      
      private var _curMode:int = -1;
      
      public function ChallengeChooseMapView()
      {
         super();
         init();
      }
      
      private function init() : void
      {
         _frame = ComponentFactory.Instance.creatComponentByStylename("asset.ddtChallengeRoom.chooseMapFrame");
         var _loc1_:AlertInfo = new AlertInfo();
         _loc1_.title = LanguageMgr.GetTranslation("tank.room.RoomIIMapSetPanel.room");
         var _loc3_:* = false;
         _loc1_.moveEnable = _loc3_;
         _loc1_.showCancel = _loc3_;
         _loc1_.submitLabel = LanguageMgr.GetTranslation("ok");
         _frame.info = _loc1_;
         _titlePreview = new Sprite();
         _mapInfoList = new DictionaryData();
         _roundTimeGroup = new SelectedButtonGroup();
         _roomModeBg = ComponentFactory.Instance.creatComponentByStylename("asset.ddtroom.challenge.modebg");
         _namePassBg = ComponentFactory.Instance.creatComponentByStylename("asset.ddtroom.challenge.namePassbg");
         _roomMode = ComponentFactory.Instance.creatBitmap("asset.ddtroom.challenge.roomMode");
         _challenge = ComponentFactory.Instance.creatBitmap("asset.ddtroom.challenge.challenge");
         _roomName = ComponentFactory.Instance.creatComponentByStylename("asset.ddtMatchRoom.setView.name");
         PositionUtils.setPos(_roomName,"asset.ddtroom.challenge.chooseMap.roomName");
         _roomName.text = LanguageMgr.GetTranslation("ddt.matchRoom.setView.roomname");
         _roomPass = ComponentFactory.Instance.creatComponentByStylename("asset.ddtMatchRoom.setView.password");
         PositionUtils.setPos(_roomPass,"asset.ddtroom.challenge.chooseMap.roomPass");
         _roomPass.text = LanguageMgr.GetTranslation("ddt.matchRoom.setView.password");
         _nameInput = ComponentFactory.Instance.creatComponentByStylename("asset.ddtRoom.dungeon.ChooseMap.nameInput");
         _nameInput.textField.multiline = false;
         _nameInput.textField.wordWrap = false;
         _nameInput.textField.tabEnabled = false;
         PositionUtils.setPos(_nameInput,"asset.ddtroom.challenge.chooseMap.nameInput");
         _passInput = ComponentFactory.Instance.creatComponentByStylename("asset.ddtRoom.dungeon.ChooseMap.passInput");
         _passInput.textField.restrict = "0-9 A-Z a-z";
         PositionUtils.setPos(_passInput,"asset.ddtroom.challenge.chooseMap.passInput");
         _checkBox = ComponentFactory.Instance.creatComponentByStylename("asset.ddtMatchRoom.setView.selectBtn");
         PositionUtils.setPos(_checkBox,"asset.ddtroom.challenge.chooseMap.chockBox");
         _time = ComponentFactory.Instance.creatBitmap("asset.ddtroom.challenge.time");
         _timeBg = ComponentFactory.Instance.creatComponentByStylename("asset.ddtroom.challenge.modebg");
         PositionUtils.setPos(_timeBg,"asset.ddtroom.challenge.chooseMap.timeBgPos");
         _timebtnBg = ComponentFactory.Instance.creatComponentByStylename("asset.ddtroom.challenge.namePassbg");
         PositionUtils.setPos(_timebtnBg,"asset.ddtroom.challenge.chooseMap.timeBtnBgPos");
         _roundTime5sec = ComponentFactory.Instance.creatComponentByStylename("asset.ddtroom.challenge.chooseMap.5SecondSBtn");
         _roundTime7sec = ComponentFactory.Instance.creatComponentByStylename("asset.ddtroom.challenge.chooseMap.7SecondSBtn");
         _roundTime10sec = ComponentFactory.Instance.creatComponentByStylename("asset.ddtroom.challenge.chooseMap.10SecondSBtn");
         _loc3_ = false;
         _roundTime10sec.displacement = _loc3_;
         _loc3_ = _loc3_;
         _roundTime7sec.displacement = _loc3_;
         _roundTime5sec.displacement = _loc3_;
         _roundTimeGroup.addSelectItem(_roundTime5sec);
         _roundTimeGroup.addSelectItem(_roundTime7sec);
         _roundTimeGroup.addSelectItem(_roundTime10sec);
         _roundTimeGroup.selectIndex = RoomManager.Instance.current.timeType == -1?1:Number(RoomManager.Instance.current.timeType - 1);
         _frame.addToContent(_roomModeBg);
         _frame.addToContent(_namePassBg);
         _frame.addToContent(_roomMode);
         _frame.addToContent(_challenge);
         _frame.addToContent(_roomName);
         _frame.addToContent(_roomPass);
         _frame.addToContent(_nameInput);
         _frame.addToContent(_passInput);
         _frame.addToContent(_checkBox);
         _frame.addToContent(_timeBg);
         _frame.addToContent(_time);
         _frame.addToContent(_timebtnBg);
         _frame.addToContent(_roundTime5sec);
         _frame.addToContent(_roundTime7sec);
         _frame.addToContent(_roundTime10sec);
         _chooseMapBg = ClassUtils.CreatInstance("asset.ddtroom.dungeonChoose.middleBg") as MovieClip;
         PositionUtils.setPos(_chooseMapBg,"asset.ddtroom.challenge.chooseMap.bgPos");
         _mapsBg = ComponentFactory.Instance.creatComponentByStylename("asset.ddtroom.challenge.chooseMap.mapsBg");
         _mapList = new SimpleTileList(4);
         _loc3_ = -9;
         _mapList.hSpace = _loc3_;
         _mapList.vSpace = _loc3_;
         _mapList.startPos = ComponentFactory.Instance.creatCustomObject("asset.ddtroom.challenge.chooseMap.listPos");
         _srollPanel = ComponentFactory.Instance.creatComponentByStylename("asset.ddtroom.challengeMapSetScrollPanel");
         _srollPanel.setView(_mapList);
         _descriptionBg = ComponentFactory.Instance.creatComponentByStylename("asset.ddtroom.dungeon.ChooseMap.FBexplainBg");
         PositionUtils.setPos(_descriptionBg,"asset.ddtroom.challenge.chooseMap.descriptionBgPos");
         _descriptbg = ComponentFactory.Instance.creatComponentByStylename("asset.ddtroom.dungeon.ChooseMap.descriptsmallbg");
         PositionUtils.setPos(_descriptbg,"asset.ddtroom.challenge.chooseMap.descriptbgPos");
         _prvviewbg = ComponentFactory.Instance.creatComponentByStylename("asset.ddtroom.dungeon.ChooseMap.previewbg");
         PositionUtils.setPos(_prvviewbg,"asset.ddtroom.challenge.chooseMap.prvviewbgPos");
         _mapDecription = ComponentFactory.Instance.creatComponentByStylename("asset.ddtroom.dungeon.ChooseMap.descriptArea");
         _mapDecription.textField.selectable = false;
         PositionUtils.setPos(_mapDecription,"asset.ddtroom.challenge.chooseMap.mapDecriptionPos");
         _titlePreview = ComponentFactory.Instance.creatCustomObject("asset.ddtroom.chooseDungeonTitle");
         PositionUtils.setPos(_titlePreview,"asset.ddtroom.challenge.chooseMap.titlePreviewPos");
         _mapPreview = ComponentFactory.Instance.creatCustomObject("asset.ddtroom.chooseDungeonPreView");
         PositionUtils.setPos(_mapPreview,"asset.ddtroom.challenge.chooseMap.mapPreviewPos");
         var _loc2_:HBox = new HBox();
         _loc2_.spacing = 25;
         PositionUtils.setPos(_loc2_,"ddtroom.challenge.chooseMap.modeBtnPos");
         _defaultModeBtn = ComponentFactory.Instance.creatComponentByStylename("ddtroom.challenge.chooseMap.defaultModeBtn");
         _otherModeBtn = ComponentFactory.Instance.creatComponentByStylename("ddtroom.challenge.chooseMap.otherModeBtn");
         _testModeBtn = ComponentFactory.Instance.creatComponentByStylename("ddtroom.challenge.chooseMap.testModeBtn");
         _loc2_.addChild(_defaultModeBtn);
         _loc2_.addChild(_testModeBtn);
         _loc2_.addChild(_otherModeBtn);
         _btnGroup = new SelectedButtonGroup();
         _frame.addToContent(_chooseMapBg);
         _frame.addToContent(_mapsBg);
         _frame.addToContent(_srollPanel);
         _frame.addToContent(_descriptionBg);
         _frame.addToContent(_descriptbg);
         _frame.addToContent(_prvviewbg);
         _frame.addToContent(_mapDecription);
         _frame.addToContent(_titlePreview);
         _frame.addToContent(_mapPreview);
         _frame.addToContent(_loc2_);
         _btnGroup.addSelectItem(_defaultModeBtn);
         _btnGroup.addSelectItem(_testModeBtn);
         _btnGroup.addSelectItem(_otherModeBtn);
         _btnGroup.selectIndex = -1;
         addChild(_frame);
         _roundTime5sec.addEventListener("click",__roundTimeClick);
         _roundTime7sec.addEventListener("click",__roundTimeClick);
         _roundTime10sec.addEventListener("click",__roundTimeClick);
         _checkBox.addEventListener("click",__checkBoxClick);
         _frame.addEventListener("response",__frameEventHandler);
         _btnGroup.addEventListener("change",__changeHandler);
      }
      
      private function updateItem(param1:int) : void
      {
         var _loc2_:* = null;
         if(_mapInfoList.length < 3)
         {
            return;
         }
         var _loc3_:Vector.<MapInfo> = _mapInfoList[param1] as Vector.<MapInfo>;
         var _loc6_:int = 0;
         var _loc5_:* = _loc3_;
         for each(var _loc4_ in _loc3_)
         {
            if(!(_loc4_.Type != 0 && _loc4_.Type != 1 && _loc4_.Type != 3))
            {
               if(_loc4_.canSelect)
               {
                  _loc2_ = new BaseMapItem();
                  _loc2_.selected = false;
                  if(_loc4_.ID == RoomManager.Instance.current.mapId)
                  {
                     _loc2_.selected = true;
                     _currentSelectedItem = _loc2_;
                     mapId = _loc4_.ID;
                  }
                  _loc2_.mapId = _loc4_.ID;
                  _loc2_.addEventListener("select",__mapItemClick);
                  _mapList.addChild(_loc2_);
               }
            }
         }
         if(_currentSelectedItem == null && _mapList.numChildren > 0)
         {
            _currentSelectedItem = _mapList.getChildAt(0) as BaseMapItem;
            _currentSelectedItem.selected = true;
            mapId = _currentSelectedItem.mapId;
         }
      }
      
      private function __changeHandler(param1:Event) : void
      {
         reset();
         switch(int(_btnGroup.selectIndex))
         {
            case 0:
               _curMode = 2;
               updateItem(0);
               break;
            case 1:
               _curMode = 120;
               updateItem(1);
               break;
            case 2:
               _curMode = 60;
               updateItem(2);
         }
         updatePreview();
         updateDescription();
         updateRoomInfo();
      }
      
      private function reset() : void
      {
         var _loc1_:* = null;
         if(_mapList == null)
         {
            return;
         }
         if(_currentSelectedItem)
         {
            _currentSelectedItem.selected = false;
         }
         while(_mapList.numChildren)
         {
            _loc1_ = _mapList.getChildAt(0) as BaseMapItem;
            _loc1_.removeEventListener("select",__mapItemClick);
            _mapList.removeChild(_loc1_);
            ObjectUtils.disposeObject(_loc1_);
         }
         _currentSelectedItem = null;
      }
      
      private function updateRoomInfo() : void
      {
         _nameInput.text = RoomManager.Instance.current.Name;
         if(RoomManager.Instance.current.roomPass)
         {
            _checkBox.selected = true;
            _passInput.text = RoomManager.Instance.current.roomPass;
         }
         else
         {
            _checkBox.selected = false;
         }
         upadtePassTextBg();
      }
      
      private function __checkBoxClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         upadtePassTextBg();
      }
      
      private function upadtePassTextBg() : void
      {
         if(_checkBox.selected)
         {
            _passInput.setFocus();
            _passInput.mouseChildren = true;
            _passInput.mouseEnabled = true;
         }
         else
         {
            _passInput.text = "";
            _passInput.mouseChildren = false;
            _passInput.mouseEnabled = false;
         }
      }
      
      private function __roundTimeClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
      }
      
      private function __frameEventHandler(param1:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               dispose();
               break;
            default:
               dispose();
               break;
            case 3:
               if(FilterWordManager.IsNullorEmpty(_nameInput.text))
               {
                  MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.roomlist.RoomListIICreateRoomView.name"));
                  SoundManager.instance.play("008");
               }
               else if(FilterWordManager.isGotForbiddenWords(_nameInput.text,"name"))
               {
                  MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.roomlist.RoomListIICreateRoomView.string"));
                  SoundManager.instance.play("008");
               }
               else if(_checkBox.selected && FilterWordManager.IsNullorEmpty(_passInput.text))
               {
                  MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.roomlist.RoomListIICreateRoomView.set"));
                  SoundManager.instance.play("008");
               }
               else
               {
                  GameInSocketOut.sendGameRoomSetUp(_mapId,1,false,_passInput.text,_nameInput.text,_roundTimeGroup.selectIndex + 1,0,0,false,0,false,_curMode);
                  RoomManager.Instance.current.roomName = _nameInput.text;
                  RoomManager.Instance.current.roomPass = _passInput.text;
                  dispose();
               }
         }
      }
      
      public function set mapId(param1:int) : void
      {
         if(param1 != _mapId)
         {
            _mapId = param1;
         }
      }
      
      private function updatePreview() : void
      {
         ObjectUtils.disposeAllChildren(_mapPreview);
         _previewLoader = LoadResourceManager.Instance.createLoader(solvePreviewPath(),0);
         _previewLoader.addEventListener("complete",__onPreviewComplete);
         LoadResourceManager.Instance.startLoad(_previewLoader);
      }
      
      private function updateDescription() : void
      {
         ObjectUtils.disposeAllChildren(_titlePreview);
         _titleLoader = LoadResourceManager.Instance.createLoader(solveTitlePath(),0);
         _titleLoader.addEventListener("complete",__onTitleComplete);
         LoadResourceManager.Instance.startLoad(_titleLoader);
         if(_currentSelectedItem)
         {
            _mapDecription.text = MapManager.getMapInfo(_currentSelectedItem.mapId).Description;
         }
         else
         {
            _mapDecription.text = LanguageMgr.GetTranslation("tank.manager.MapManager.random");
         }
      }
      
      private function __mapItemClick(param1:*) : void
      {
         var _loc2_:BaseMapItem = param1.target as BaseMapItem;
         if(_currentSelectedItem && _currentSelectedItem != _loc2_)
         {
            _currentSelectedItem.selected = false;
         }
         mapId = _loc2_.mapId;
         _currentSelectedItem = _loc2_;
         updateDescription();
         updatePreview();
      }
      
      private function solvePreviewPath() : String
      {
         var _loc1_:String = PathManager.SITE_MAIN + "image/map/";
         if(_currentSelectedItem)
         {
            _loc1_ = _loc1_ + (_currentSelectedItem.mapId.toString() + "/samll_map.png");
         }
         else
         {
            _loc1_ = _loc1_ + "10000/samll_map.png";
         }
         return _loc1_;
      }
      
      private function solveTitlePath() : String
      {
         var _loc1_:String = PathManager.SITE_MAIN + "image/map/";
         if(_currentSelectedItem)
         {
            _loc1_ = _loc1_ + (_currentSelectedItem.mapId.toString() + "/icon.png");
         }
         else
         {
            _loc1_ = _loc1_ + "0/icon.png";
         }
         return _loc1_;
      }
      
      private function __onPreviewComplete(param1:LoaderEvent) : void
      {
         if(param1.currentTarget.isSuccess)
         {
            if(_mapPreview)
            {
               _mapPreview.addChild(Bitmap(param1.currentTarget.content));
            }
         }
      }
      
      private function __onTitleComplete(param1:LoaderEvent) : void
      {
         if(param1.currentTarget.isSuccess)
         {
            if(_titlePreview)
            {
               _titlePreview.addChild(Bitmap(param1.currentTarget.content));
            }
         }
      }
      
      public function show() : void
      {
         reset();
         var _loc2_:int = RoomManager.Instance.current.dungeonMode;
         var _loc1_:int = 0;
         _mapInfoList = MapManager.getListByType(25);
         if(_mapInfoList == null || _mapInfoList.length <= 0)
         {
            return;
         }
         var _loc3_:* = _loc2_;
         if(2 !== _loc3_)
         {
            if(120 !== _loc3_)
            {
               if(60 !== _loc3_)
               {
                  _loc1_ = 0;
               }
               else
               {
                  _loc1_ = 2;
               }
            }
            else
            {
               _loc1_ = 1;
            }
         }
         else
         {
            _loc1_ = 0;
         }
         _curMode = _loc2_;
         _btnGroup.selectIndex = _loc1_;
         LayerManager.Instance.addToLayer(this,3,true,1);
         StageReferance.stage.focus = _frame;
      }
      
      public function dispose() : void
      {
         var _loc1_:* = null;
         while(_mapList.numChildren)
         {
            _loc1_ = _mapList.getChildAt(0) as BaseMapItem;
            _loc1_.removeEventListener("select",__mapItemClick);
            _mapList.removeChild(_loc1_);
         }
         _roundTime5sec.removeEventListener("click",__roundTimeClick);
         _roundTime7sec.removeEventListener("click",__roundTimeClick);
         _roundTime10sec.removeEventListener("click",__roundTimeClick);
         _frame.removeEventListener("response",__frameEventHandler);
         _btnGroup.removeEventListener("change",__changeHandler);
         _previewLoader.removeEventListener("complete",__onPreviewComplete);
         _titleLoader.removeEventListener("complete",__onTitleComplete);
         _checkBox.removeEventListener("click",__checkBoxClick);
         if(_roomPass)
         {
            ObjectUtils.disposeObject(_roomPass);
         }
         _roomPass = null;
         if(_roomMode)
         {
            ObjectUtils.disposeObject(_roomMode);
         }
         _roomMode = null;
         if(_challenge)
         {
            ObjectUtils.disposeObject(_challenge);
         }
         _challenge = null;
         if(_roomModeBg)
         {
            ObjectUtils.disposeObject(_roomModeBg);
         }
         _roomModeBg = null;
         if(_namePassBg)
         {
            ObjectUtils.disposeObject(_namePassBg);
         }
         _namePassBg = null;
         if(_roomName)
         {
            ObjectUtils.disposeObject(_roomName);
         }
         _roomName = null;
         if(_nameInput)
         {
            ObjectUtils.disposeObject(_nameInput);
         }
         _nameInput = null;
         if(_passInput)
         {
            ObjectUtils.disposeObject(_passInput);
         }
         _passInput = null;
         if(_checkBox)
         {
            ObjectUtils.disposeObject(_checkBox);
         }
         _checkBox = null;
         if(_timeBg)
         {
            ObjectUtils.disposeObject(_timeBg);
         }
         _timeBg = null;
         if(_timebtnBg)
         {
            ObjectUtils.disposeObject(_timebtnBg);
         }
         _timebtnBg = null;
         if(_time)
         {
            ObjectUtils.disposeObject(_time);
         }
         _time = null;
         _roundTimeGroup.dispose();
         _roundTimeGroup = null;
         if(_roundTime5sec)
         {
            ObjectUtils.disposeObject(_roundTime5sec);
         }
         _roundTime5sec = null;
         if(_roundTime7sec)
         {
            ObjectUtils.disposeObject(_roundTime7sec);
         }
         _roundTime7sec = null;
         if(_roundTime10sec)
         {
            ObjectUtils.disposeObject(_roundTime10sec);
         }
         _roundTime10sec = null;
         if(_chooseMapBg)
         {
            ObjectUtils.disposeObject(_chooseMapBg);
         }
         _chooseMapBg = null;
         if(_mapsBg)
         {
            ObjectUtils.disposeObject(_mapsBg);
         }
         _mapsBg = null;
         if(_mapList)
         {
            ObjectUtils.disposeObject(_mapList);
         }
         _mapList = null;
         if(_srollPanel)
         {
            ObjectUtils.disposeObject(_srollPanel);
         }
         _srollPanel = null;
         if(_descriptionBg)
         {
            ObjectUtils.disposeObject(_descriptionBg);
         }
         _descriptionBg = null;
         if(_descriptbg)
         {
            ObjectUtils.disposeObject(_descriptbg);
         }
         _descriptbg = null;
         if(_prvviewbg)
         {
            ObjectUtils.disposeObject(_prvviewbg);
         }
         _prvviewbg = null;
         if(_mapDecription)
         {
            ObjectUtils.disposeObject(_mapDecription);
         }
         _mapDecription = null;
         if(_mapPreview)
         {
            ObjectUtils.disposeObject(_mapPreview);
         }
         _mapPreview = null;
         if(_titlePreview)
         {
            ObjectUtils.disposeObject(_titlePreview);
         }
         _titlePreview = null;
         if(_currentSelectedItem)
         {
            ObjectUtils.disposeObject(_currentSelectedItem);
         }
         _currentSelectedItem = null;
         ObjectUtils.disposeObject(_defaultModeBtn);
         _defaultModeBtn = null;
         ObjectUtils.disposeObject(_otherModeBtn);
         _otherModeBtn = null;
         ObjectUtils.disposeObject(_testModeBtn);
         _testModeBtn = null;
         ObjectUtils.disposeObject(_btnGroup);
         _btnGroup = null;
         _previewLoader = null;
         _titleLoader = null;
         if(_frame)
         {
            ObjectUtils.disposeObject(_frame);
         }
         _frame = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
