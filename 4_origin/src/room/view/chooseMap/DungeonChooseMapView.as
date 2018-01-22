package room.view.chooseMap
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.loader.DisplayLoader;
   import com.pickgliss.loader.LoadResourceManager;
   import com.pickgliss.loader.LoaderEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.SelectedCheckButton;
   import com.pickgliss.ui.controls.SelectedTextButton;
   import com.pickgliss.ui.controls.TextInput;
   import com.pickgliss.ui.controls.container.SimpleTileList;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.text.TextArea;
   import com.pickgliss.utils.ClassUtils;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.command.StripTip;
   import ddt.data.map.DungeonInfo;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MapManager;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PVEMapPermissionManager;
   import ddt.manager.PathManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.ServerConfigManager;
   import ddt.manager.SoundManager;
   import ddt.manager.TimeManager;
   import ddt.utils.FilterWordManager;
   import ddt.utils.PositionUtils;
   import ddt.view.ShineSelectButton;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import flash.utils.Dictionary;
   import kingBless.KingBlessManager;
   import room.RoomManager;
   import trainer.view.NewHandContainer;
   
   public class DungeonChooseMapView extends Sprite implements Disposeable
   {
      
      public static const DUNGEON_NO:int = 13;
      
      public static const DEFAULT_MAP:int = -1;
       
      
      private var _titleLoader:DisplayLoader;
      
      private var _preViewLoader:DisplayLoader;
      
      private var _modebg:ScaleBitmapImage;
      
      private var _roomMode:Bitmap;
      
      private var _roomName:FilterFrameText;
      
      private var _roomPass:FilterFrameText;
      
      private var _nameInput:TextInput;
      
      private var _passInput:TextInput;
      
      private var _checkBox:SelectedCheckButton;
      
      private var _modeDescriptionTxt:FilterFrameText;
      
      private var _getExpText:FilterFrameText;
      
      private var _fbMode:FilterFrameText;
      
      private var _topleftbg:ScaleBitmapImage;
      
      private var _getExpBg:Bitmap;
      
      private var _middlebg:MovieClip;
      
      private var _mapbg:MutipleImage;
      
      private var _chooseFB:Bitmap;
      
      private var _dungeonList:SimpleTileList;
      
      private var _maps:Array;
      
      private var _dungeonListContainer:ScrollPanel;
      
      private var _dungeonPreView:Sprite;
      
      private var _descriptionBg:ScaleBitmapImage;
      
      private var _descriptbg:ScaleBitmapImage;
      
      private var _prvviewbg:ScaleBitmapImage;
      
      private var _dungeonTitle:Sprite;
      
      private var _dungeonDescriptionTxt:TextArea;
      
      private var _btnGroup:SelectedButtonGroup;
      
      private var _mapTypBtn_n:SelectedTextButton;
      
      private var _mapTypBtn_s:SelectedTextButton;
      
      private var _mapTypBtn_a:SelectedTextButton;
      
      private var _mapTypBtn_nightmare:SelectedTextButton;
      
      private var _mapTypBtn_single:SelectedTextButton;
      
      private var _mapTypBtn_ad:SelectedTextButton;
      
      private var _selectedDungeonType:int;
      
      private var _enterNumDes:FilterFrameText;
      
      private var _bgBottom:MutipleImage;
      
      private var _diff:Bitmap;
      
      private var _btns:Vector.<ShineSelectButton>;
      
      private var _group:SelectedButtonGroup;
      
      private var _easyBtn:ShineSelectButton;
      
      private var _normalBtn:ShineSelectButton;
      
      private var _hardBtn:ShineSelectButton;
      
      private var _heroBtn:ShineSelectButton;
      
      private var _epicBtn:ShineSelectButton;
      
      private var _nightmareBtn:ShineSelectButton;
      
      private var _bossBtn:SelectedCheckButton;
      
      private var _bossIMG:Bitmap;
      
      private var _bossBtnStrip:StripTip;
      
      private var _grayFilters:Array;
      
      private var _currentSelectedItem:DungeonMapItem;
      
      private var _rect1:Rectangle;
      
      private var _rect2:Rectangle;
      
      private var _rect3:Rectangle;
      
      private var _rect4:Rectangle;
      
      private var _dungeonInfoList:Dictionary;
      
      private var _selectedLevel:int = -1;
      
      private var _freeOpenBossCountBg:Bitmap;
      
      private var _freeOpenBossCountTxt:FilterFrameText;
      
      public function DungeonChooseMapView()
      {
         super();
         initView();
         initEvents();
      }
      
      private function initView() : void
      {
         var _loc2_:int = 0;
         var _loc1_:* = null;
         _modebg = ComponentFactory.Instance.creatComponentByStylename("asset.ddtroom.dungeon.ChooseMap.modeBg");
         addChild(_modebg);
         _roomMode = ComponentFactory.Instance.creatBitmap("asset.ddtroom.setView.modeWord");
         addChild(_roomMode);
         PositionUtils.setPos(_roomMode,"asset.ddtroom.dungeon.roomModePos");
         _roomName = ComponentFactory.Instance.creatComponentByStylename("asset.ddtMatchRoom.setView.name");
         addChild(_roomName);
         PositionUtils.setPos(_roomName,"asset.ddtroom.dungeon.roomNamePos");
         _roomName.text = LanguageMgr.GetTranslation("ddt.matchRoom.setView.roomname");
         _roomPass = ComponentFactory.Instance.creatComponentByStylename("asset.ddtMatchRoom.setView.password");
         addChild(_roomPass);
         PositionUtils.setPos(_roomPass,"asset.ddtroom.dungeon.roomPassPos");
         _roomPass.text = LanguageMgr.GetTranslation("ddt.matchRoom.setView.password");
         _nameInput = ComponentFactory.Instance.creatComponentByStylename("asset.ddtRoom.dungeon.ChooseMap.nameInput");
         addChild(_nameInput);
         _nameInput.textField.multiline = false;
         _nameInput.textField.wordWrap = false;
         _nameInput.textField.tabEnabled = false;
         _passInput = ComponentFactory.Instance.creatComponentByStylename("asset.ddtRoom.dungeon.ChooseMap.passInput");
         addChild(_passInput);
         _passInput.textField.restrict = "0-9 A-Z a-z";
         _checkBox = ComponentFactory.Instance.creatComponentByStylename("asset.ddtMatchRoom.setView.selectBtn");
         addChild(_checkBox);
         PositionUtils.setPos(_checkBox,"asset.ddtroom.dungeon.chockBoxPos");
         _topleftbg = ComponentFactory.Instance.creatComponentByStylename("asset.ddtroom.dungeon.ChooseMap.fbmodebg");
         addChild(_topleftbg);
         _fbMode = ComponentFactory.Instance.creatComponentByStylename("asset.ddtroom.dungeon.ChooseMap.fbmode");
         addChild(_fbMode);
         _fbMode.text = LanguageMgr.GetTranslation("ddt.dungeonroom.choseMap.fbmode");
         _modeDescriptionTxt = ComponentFactory.Instance.creatComponentByStylename("asset.ddtroom.dungeon.ChooseMap.descript");
         addChild(_modeDescriptionTxt);
         _modeDescriptionTxt.text = LanguageMgr.GetTranslation("room.view.chooseMap.DungeonChooseMapView.dungeonModeDescription");
         _getExpBg = ComponentFactory.Instance.creat("asset.room.view.getExpBg");
         addChild(_getExpBg);
         _getExpText = ComponentFactory.Instance.creatComponentByStylename("asset.ddtroom.dungeon.ChooseMap.getExpdescript");
         addChild(_getExpText);
         _getExpText.text = LanguageMgr.GetTranslation("room.view.chooseMap.DungeonChooseMapView.dungeonGetExpDescription",PlayerManager.Instance.Self.DungeonExpReceiveNum,PlayerManager.Instance.Self.DungeonExpTotalNum);
         _middlebg = ClassUtils.CreatInstance("asset.ddtroom.dungeonChoose.middleBg") as MovieClip;
         addChild(_middlebg);
         PositionUtils.setPos(_middlebg,"asset.ddtroom.dungeon.middleBgPos");
         _mapbg = ComponentFactory.Instance.creatComponentByStylename("asset.ddtRoom.dungeon.ChooseMap.mapBg");
         addChild(_mapbg);
         _chooseFB = ComponentFactory.Instance.creatBitmap("asset.ddtroom.dungeonChoose.chooseFB");
         addChild(_chooseFB);
         _dungeonList = ComponentFactory.Instance.creat("asset.room.view.chooseMap.mapList",[4]);
         _maps = [];
         _loc2_ = 0;
         while(_loc2_ < 13)
         {
            if(PathManager.solveDungeonOpenList && PathManager.solveDungeonOpenList.indexOf(String(_loc2_)) != -1 || PathManager.solveDungeonOpenList == null)
            {
               _loc1_ = new DungeonMapItem();
               _dungeonList.addChild(_loc1_);
               _loc1_.addEventListener("select",__onItemSelect);
               _maps.push(_loc1_);
            }
            _loc2_++;
         }
         _dungeonListContainer = ComponentFactory.Instance.creatComponentByStylename("asset.ddtroom.dungeonMapSetScrollPanel");
         _dungeonListContainer.vScrollProxy = 0;
         addChild(_dungeonListContainer);
         _dungeonListContainer.setView(_dungeonList);
         _descriptionBg = ComponentFactory.Instance.creatComponentByStylename("asset.ddtroom.dungeon.ChooseMap.FBexplainBg");
         addChild(_descriptionBg);
         _descriptbg = ComponentFactory.Instance.creatComponentByStylename("asset.ddtroom.dungeon.ChooseMap.descriptsmallbg");
         addChild(_descriptbg);
         _prvviewbg = ComponentFactory.Instance.creatComponentByStylename("asset.ddtroom.dungeon.ChooseMap.previewbg");
         addChild(_prvviewbg);
         _dungeonDescriptionTxt = ComponentFactory.Instance.creatComponentByStylename("asset.ddtroom.dungeon.ChooseMap.descriptArea");
         addChild(_dungeonDescriptionTxt);
         _dungeonDescriptionTxt.textField.selectable = false;
         _dungeonTitle = ComponentFactory.Instance.creatCustomObject("asset.ddtroom.chooseDungeonTitle");
         addChild(_dungeonTitle);
         _dungeonPreView = ComponentFactory.Instance.creatCustomObject("asset.ddtroom.chooseDungeonPreView");
         addChild(_dungeonPreView);
         _mapTypBtn_n = ComponentFactory.Instance.creatComponentByStylename("asset.ddtroom.dungeon.ChooseMap.FBType1");
         _mapTypBtn_n.text = LanguageMgr.GetTranslation("ddt.dungeonroom.type.normal");
         _mapTypBtn_s = ComponentFactory.Instance.creatComponentByStylename("asset.ddtroom.dungeon.ChooseMap.FBType2");
         _mapTypBtn_s.text = LanguageMgr.GetTranslation("ddt.dungeonroom.type.spaciel");
         _mapTypBtn_a = ComponentFactory.Instance.creatComponentByStylename("asset.ddtroom.dungeon.ChooseMap.FBType3");
         _mapTypBtn_a.text = LanguageMgr.GetTranslation("ddt.dungeonroom.type.activity");
         _mapTypBtn_nightmare = ComponentFactory.Instance.creatComponentByStylename("asset.ddtroom.dungeon.ChooseMap.FBType4");
         _mapTypBtn_nightmare.text = LanguageMgr.GetTranslation("ddt.dungeonroom.type.nightmare");
         _mapTypBtn_single = ComponentFactory.Instance.creatComponentByStylename("asset.ddtroom.dungeon.ChooseMap.FBType5");
         _mapTypBtn_single.text = LanguageMgr.GetTranslation("ddt.dungeonroom.type.single");
         addChild(_mapTypBtn_n);
         addChild(_mapTypBtn_s);
         addChild(_mapTypBtn_a);
         addChild(_mapTypBtn_nightmare);
         addChild(_mapTypBtn_single);
         _btnGroup = new SelectedButtonGroup();
         _btnGroup.addSelectItem(_mapTypBtn_n);
         _btnGroup.addSelectItem(_mapTypBtn_s);
         _btnGroup.addSelectItem(_mapTypBtn_a);
         _btnGroup.addSelectItem(_mapTypBtn_nightmare);
         _btnGroup.addSelectItem(_mapTypBtn_single);
         if(PathManager.advancedEnable)
         {
            _mapTypBtn_ad = ComponentFactory.Instance.creatComponentByStylename("asset.ddtroom.dungeon.ChooseMap.FBType6");
            _mapTypBtn_ad.text = LanguageMgr.GetTranslation("ddt.dungeonroom.type.advanced");
            addChild(_mapTypBtn_ad);
            _btnGroup.addSelectItem(_mapTypBtn_ad);
         }
         _btnGroup.selectIndex = 0;
         _bgBottom = ComponentFactory.Instance.creatComponentByStylename("asset.ddtRoom.dungeon.ChooseMap.diffChooseBg");
         addChild(_bgBottom);
         _diff = ComponentFactory.Instance.creatBitmap("asset.ddtroom.dungeonChoose.diff");
         addChild(_diff);
         _btns = new Vector.<ShineSelectButton>();
         _group = new SelectedButtonGroup();
         _easyBtn = ComponentFactory.Instance.creatCustomObject("asset.ddtroom.easyButton");
         addChild(_easyBtn);
         _btns.push(_easyBtn);
         _group.addSelectItem(_easyBtn);
         _normalBtn = ComponentFactory.Instance.creatCustomObject("asset.ddtroom.normalButton");
         addChild(_normalBtn);
         _btns.push(_normalBtn);
         _group.addSelectItem(_normalBtn);
         _hardBtn = ComponentFactory.Instance.creatCustomObject("asset.ddtroom.hardButton");
         addChild(_hardBtn);
         _btns.push(_hardBtn);
         _group.addSelectItem(_hardBtn);
         _heroBtn = ComponentFactory.Instance.creatCustomObject("asset.ddtroom.heroButton");
         addChild(_heroBtn);
         _btns.push(_heroBtn);
         _group.addSelectItem(_heroBtn);
         _epicBtn = ComponentFactory.Instance.creatCustomObject("asset.ddtroom.epicButton");
         addChild(_epicBtn);
         _btns.push(_epicBtn);
         _group.addSelectItem(_epicBtn);
         _nightmareBtn = ComponentFactory.Instance.creatCustomObject("asset.ddtroom.nightmareButton");
         addChild(_nightmareBtn);
         _btns.push(_nightmareBtn);
         _group.addSelectItem(_nightmareBtn);
         _easyBtn.text = LanguageMgr.GetTranslation("ddt.dungeonRoom.level0");
         _normalBtn.text = LanguageMgr.GetTranslation("ddt.dungeonRoom.level1");
         _hardBtn.text = LanguageMgr.GetTranslation("ddt.dungeonRoom.level2");
         _heroBtn.text = LanguageMgr.GetTranslation("ddt.dungeonRoom.level3");
         _epicBtn.text = LanguageMgr.GetTranslation("ddt.dungeonRoom.level5");
         _nightmareBtn.text = LanguageMgr.GetTranslation("ddt.dungeonRoom.level4");
         _bossBtn = ComponentFactory.Instance.creatComponentByStylename("ddt.dungeonRoom.bossBtn");
         _bossIMG = ComponentFactory.Instance.creatBitmap("asset.ddtroom.dungeonChoose.boss");
         _bossBtn.addChild(_bossIMG);
         _bossBtn.tipData = LanguageMgr.GetTranslation("ddt.dungeonRoom.bossBtn.tiptext");
         addChild(_bossBtn);
         _bossBtnStrip = ComponentFactory.Instance.creatCustomObject("ddt.dungeonRoom.bossBtnStrip");
         _bossBtnStrip.tipData = LanguageMgr.GetTranslation("ddt.dungeonRoom.bossBtn.tiptext");
         PositionUtils.setPos(_bossBtnStrip,"ddt.dungeonRoom.bossBtnStripPos");
         if(!isBossBtnCanClick())
         {
            addChild(_bossBtnStrip);
         }
         _freeOpenBossCountBg = ComponentFactory.Instance.creatBitmap("asset.room.kingbless.freeOpenBossCountBg");
         _freeOpenBossCountTxt = ComponentFactory.Instance.creatComponentByStylename("room.kingbless.freeOpenBossCountTxt");
         addChild(_freeOpenBossCountBg);
         addChild(_freeOpenBossCountTxt);
         _grayFilters = ComponentFactory.Instance.creatFilters("grayFilter");
         _rect1 = ComponentFactory.Instance.creatCustomObject("asset.ddtroom.levelBtnPos1");
         _rect2 = ComponentFactory.Instance.creatCustomObject("asset.ddtroom.levelBtnPos2");
         _rect3 = ComponentFactory.Instance.creatCustomObject("asset.ddtroom.levelBtnPos3");
         _rect4 = ComponentFactory.Instance.creatCustomObject("asset.ddtroom.levelBtnPos4");
         _selectedDungeonType = RoomManager.Instance.current.dungeonType;
         updateDescription();
         updatePreView();
         updateLevelBtn();
         updateRoomInfo();
         initInfo();
         if(isBossBtnCanClick() && _btnGroup.selectIndex != 1)
         {
            if(_currentSelectedItem && _currentSelectedItem.mapId == 31)
            {
               setBtnVisible();
            }
            else
            {
               setBtnVisible(true);
            }
         }
         else
         {
            setBossBtnState(false);
         }
         refreshFreeOpenBossView();
         if(_btnGroup.selectIndex == 1 || _btnGroup.selectIndex == 2 || _btnGroup.selectIndex == 3 || _btnGroup.selectIndex == 4)
         {
            setBtnVisible();
         }
      }
      
      private function isBossBtnCanClick() : Boolean
      {
         if(PlayerManager.Instance.Self.VIPLevel >= 7 && PlayerManager.Instance.Self.IsVIP)
         {
            return true;
         }
         if(KingBlessManager.instance.openType > 0)
         {
            return true;
         }
         return false;
      }
      
      private function refreshFreeOpenBossView() : void
      {
         var _loc1_:int = KingBlessManager.instance.getOneBuffData(5);
         if(_loc1_ <= 0)
         {
            _freeOpenBossCountTxt.text = _loc1_.toString();
            _freeOpenBossCountBg.visible = false;
            _freeOpenBossCountTxt.visible = false;
         }
         else
         {
            _freeOpenBossCountTxt.text = _loc1_.toString();
            _freeOpenBossCountBg.visible = true;
            _freeOpenBossCountTxt.visible = true;
         }
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
      
      private function initInfo() : void
      {
         switch(int(RoomManager.Instance.current.dungeonType) - 1)
         {
            case 0:
               _btnGroup.selectIndex = 0;
               updateCommonItem();
               break;
            case 1:
               _btnGroup.selectIndex = 1;
               updateSpecialItem();
               break;
            case 2:
               _btnGroup.selectIndex = 2;
               updateActivityItem();
               break;
            case 3:
               if(PlayerManager.Instance.Self.Grade < 45)
               {
                  _btnGroup.selectIndex = 0;
                  updateCommonItem();
                  MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("nightmare.enterMap"));
                  return;
               }
               _btnGroup.selectIndex = 3;
               updateNightmareItem();
               break;
            case 4:
               _btnGroup.selectIndex = 4;
               updateSingleItem();
         }
         checkSelectItemAndLevel();
      }
      
      public function checkSelectItemAndLevel() : void
      {
         var _loc1_:int = RoomManager.Instance.current.mapId;
         if(_loc1_ > 0 && _loc1_ != -1)
         {
            var _loc4_:int = 0;
            var _loc3_:* = _maps;
            for each(var _loc2_ in _maps)
            {
               if(_loc2_.mapId == _loc1_)
               {
                  _currentSelectedItem = _loc2_;
                  _currentSelectedItem.selected = true;
               }
            }
            switch(int(RoomManager.Instance.current.hardLevel))
            {
               case 0:
                  _group.selectIndex = 0;
                  _selectedLevel = 0;
                  break;
               case 1:
                  _group.selectIndex = 1;
                  _selectedLevel = 1;
                  break;
               case 2:
                  _group.selectIndex = 2;
                  _selectedLevel = 2;
                  break;
               case 3:
                  _group.selectIndex = 3;
                  _selectedLevel = 3;
            }
         }
      }
      
      private function initEvents() : void
      {
         _btnGroup.addEventListener("change",__changeHandler);
         _mapTypBtn_n.addEventListener("click",__soundPlay);
         _mapTypBtn_s.addEventListener("click",__soundPlay);
         _mapTypBtn_a.addEventListener("click",__soundPlay);
         _mapTypBtn_nightmare.addEventListener("click",__soundPlay);
         _mapTypBtn_single.addEventListener("click",__soundPlay);
         if(_mapTypBtn_ad)
         {
            _mapTypBtn_ad.addEventListener("click",__soundPlay);
         }
         _easyBtn.addEventListener("click",__btnClick);
         _normalBtn.addEventListener("click",__btnClick);
         _hardBtn.addEventListener("click",__btnClick);
         _heroBtn.addEventListener("click",__btnClick);
         _epicBtn.addEventListener("click",__btnClick);
         _nightmareBtn.addEventListener("click",__btnClick);
         _bossBtn.addEventListener("click",__checkBoxClick);
         _checkBox.addEventListener("click",__checkBoxClick);
      }
      
      private function removeEvents() : void
      {
         _btnGroup.removeEventListener("change",__changeHandler);
         _mapTypBtn_n.removeEventListener("click",__soundPlay);
         _mapTypBtn_s.removeEventListener("click",__soundPlay);
         _mapTypBtn_a.removeEventListener("click",__soundPlay);
         _mapTypBtn_nightmare.removeEventListener("click",__soundPlay);
         _mapTypBtn_single.removeEventListener("click",__soundPlay);
         if(_mapTypBtn_ad)
         {
            _mapTypBtn_ad.removeEventListener("click",__soundPlay);
         }
         _easyBtn.removeEventListener("click",__btnClick);
         _normalBtn.removeEventListener("click",__btnClick);
         _hardBtn.removeEventListener("click",__btnClick);
         _heroBtn.removeEventListener("click",__btnClick);
         _epicBtn.removeEventListener("click",__btnClick);
         _nightmareBtn.removeEventListener("click",__btnClick);
         _bossBtn.removeEventListener("click",__checkBoxClick);
         _checkBox.removeEventListener("click",__checkBoxClick);
         if(_titleLoader != null)
         {
            _titleLoader.removeEventListener("complete",__onTitleComplete);
         }
         if(_preViewLoader != null)
         {
            _preViewLoader.removeEventListener("complete",__onPreViewComplete);
         }
      }
      
      private function __changeHandler(param1:Event) : void
      {
         if(_enterNumDes)
         {
            _enterNumDes.visible = false;
         }
         _selectedDungeonType = _btnGroup.selectIndex + 1;
         if(_btnGroup.selectIndex == 0)
         {
            if(_currentSelectedItem && _currentSelectedItem.mapId == 31)
            {
               setBtnVisible();
            }
            else if(isBossBtnCanClick())
            {
               setBtnVisible(true);
            }
            setBtnVisible(true);
            refreshFreeOpenBossView();
            if(isBossBtnCanClick())
            {
               setBossBtnState(true);
            }
            updateCommonItem();
         }
         else if(_btnGroup.selectIndex == 1)
         {
            refreshFreeOpenBossView();
            setBtnVisible();
            setBossBtnState(false);
            updateSpecialItem();
         }
         else if(_btnGroup.selectIndex == 2)
         {
            setBtnVisible();
            updateActivityItem();
         }
         else if(_btnGroup.selectIndex == 3)
         {
            if(PlayerManager.Instance.Self.Grade < 45)
            {
               _btnGroup.selectIndex = 0;
               setBtnVisible(true);
               refreshFreeOpenBossView();
               if(isBossBtnCanClick())
               {
                  setBossBtnState(true);
               }
               updateCommonItem();
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("nightmare.enterMap"));
               return;
            }
            setBtnVisible();
            updateNightmareItem();
         }
         else if(_btnGroup.selectIndex == 4)
         {
            setBtnVisible();
            updateSingleItem();
         }
         else
         {
            if(isBossBtnCanClick())
            {
               refreshFreeOpenBossView();
               setBossBtnState(true);
            }
            else
            {
               setBossBtnState(false);
            }
            updateAdvancedItem();
         }
      }
      
      private function updateAdvancedItem() : void
      {
         var _loc3_:int = 0;
         var _loc1_:* = null;
         reset();
         var _loc2_:int = 0;
         _loc3_ = 1;
         while(_loc3_ < 13)
         {
            if(MapManager.getByOrderingAdvancedDungeonInfo(_loc3_))
            {
               _loc2_++;
               _loc1_ = _maps[_loc2_] as DungeonMapItem;
               _loc1_.isNightmare = false;
               _loc1_.mapId = MapManager.getByOrderingAdvancedDungeonInfo(_loc3_).ID;
            }
            _loc3_++;
         }
      }
      
      private function setBtnVisible(param1:Boolean = false) : void
      {
         var _loc2_:int = KingBlessManager.instance.getOneBuffData(5);
         _bossBtn.visible = param1;
         _bossBtnStrip.visible = param1;
         _freeOpenBossCountBg.visible = param1 && _loc2_ > 0;
         _freeOpenBossCountTxt.visible = param1 && _loc2_ > 0;
      }
      
      private function addEnterNumInfo() : void
      {
         var _loc1_:int = 0;
         var _loc5_:int = 0;
         var _loc4_:int = 0;
         var _loc7_:int = 0;
         var _loc3_:int = 0;
         var _loc2_:int = 0;
         var _loc6_:int = 0;
         ObjectUtils.disposeObject(_enterNumDes);
         var _loc8_:* = _currentSelectedItem.mapId;
         if(70001 !== _loc8_)
         {
            if(12016 !== _loc8_)
            {
               if(27 !== _loc8_)
               {
                  if(30 !== _loc8_)
                  {
                     if(70020 !== _loc8_)
                     {
                        if(15001 !== _loc8_)
                        {
                           if(16001 !== _loc8_)
                           {
                              if(2 !== _loc8_)
                              {
                                 if(7 !== _loc8_)
                                 {
                                 }
                              }
                              if(_currentSelectedItem.isNightmare)
                              {
                                 _enterNumDes = ComponentFactory.Instance.creatComponentByStylename("room.tanabata.enterCountTxt");
                                 _loc1_ = ServerConfigManager.instance.nightmareDungeonLimitTimes - PlayerManager.Instance.Self.getDungeonCount(_currentSelectedItem.mapId);
                                 _enterNumDes.text = LanguageMgr.GetTranslation("ddt.dungeonRoom.todayEnterNum",_loc1_,ServerConfigManager.instance.nightmareDungeonLimitTimes);
                                 addChild(_enterNumDes);
                              }
                           }
                           else
                           {
                              _enterNumDes = ComponentFactory.Instance.creatComponentByStylename("room.tanabata.enterCountTxt");
                              _loc6_ = PlayerManager.Instance.Self.getBag(1).getItemCountByTemplateId(201629);
                              _enterNumDes.text = LanguageMgr.GetTranslation("ddt.dungeonRoom.enterTicketCount",_loc6_,"1");
                              addChild(_enterNumDes);
                           }
                        }
                     }
                     else
                     {
                        _loc4_ = ServerConfigManager.instance.getDesertFreeEnterCount();
                        _loc7_ = ServerConfigManager.instance.getDesertFeeEnterCount();
                        _loc3_ = PlayerManager.Instance.Self.desertEnterCount;
                        if(_loc3_ < _loc4_)
                        {
                           _enterNumDes = ComponentFactory.Instance.creatComponentByStylename("room.tanabata.freeEnterCountTxt");
                           _enterNumDes.text = LanguageMgr.GetTranslation("ddt.dungeonRoom.freeCount",_loc4_ - _loc3_);
                           addChild(_enterNumDes);
                        }
                        else
                        {
                           _enterNumDes = ComponentFactory.Instance.creatComponentByStylename("room.tanabata.feeEnterCountTxt");
                           _enterNumDes.text = LanguageMgr.GetTranslation("ddt.dungeonRoom.enterPriceAndCount",_loc7_ + _loc4_ - _loc3_);
                           addChild(_enterNumDes);
                        }
                     }
                     _enterNumDes = ComponentFactory.Instance.creatComponentByStylename("room.tanabata.enterCountTxt");
                     _loc2_ = PlayerManager.Instance.Self.getBag(1).getItemCountByTemplateId(201628);
                     _enterNumDes.text = LanguageMgr.GetTranslation("ddt.dungeonRoom.enterTicketCount",_loc2_,"1");
                     addChild(_enterNumDes);
                  }
                  else
                  {
                     _enterNumDes = ComponentFactory.Instance.creatComponentByStylename("room.tanabata.enterCountTxt");
                     _loc1_ = ServerConfigManager.instance.battleDungeonLimitCount - PlayerManager.Instance.Self.getDungeonCount(30);
                     _enterNumDes.text = LanguageMgr.GetTranslation("ddt.dungeonRoom.todayEnterNum",_loc1_,ServerConfigManager.instance.battleDungeonLimitCount);
                     addChild(_enterNumDes);
                     setSpeBossBtnState(true);
                  }
               }
               else
               {
                  _enterNumDes = ComponentFactory.Instance.creatComponentByStylename("room.tanabata.enterCountTxt");
                  _loc1_ = ServerConfigManager.instance.battleDungeonLimitCount - PlayerManager.Instance.Self.getDungeonCount(27);
                  _enterNumDes.text = LanguageMgr.GetTranslation("ddt.dungeonRoom.todayEnterNum",_loc1_,ServerConfigManager.instance.battleDungeonLimitCount);
                  addChild(_enterNumDes);
                  setSpeBossBtnState(true);
               }
            }
            else
            {
               _enterNumDes = ComponentFactory.Instance.creatComponentByStylename("room.tanabata.enterCountTxt");
               _loc5_ = PlayerManager.Instance.Self.getBag(1).getItemCountByTemplateId(11742);
               _enterNumDes.text = LanguageMgr.GetTranslation("ddt.dungeonRoom.enterTicketCount",_loc5_,"1");
               addChild(_enterNumDes);
            }
         }
         else
         {
            _enterNumDes = ComponentFactory.Instance.creatComponentByStylename("room.tanabata.enterCountTxt");
            _enterNumDes.text = LanguageMgr.GetTranslation("ddt.dungeonRoom.todayEnterNum",PlayerManager.Instance.Self.activityTanabataNum.toString(),ServerConfigManager.instance.activityEnterNum.toString());
            addChild(_enterNumDes);
         }
      }
      
      private function __soundPlay(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
      }
      
      private function __checkBoxClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         var _loc2_:* = param1.currentTarget;
         if(_checkBox !== _loc2_)
         {
            if(_bossBtn === _loc2_)
            {
               checkState();
            }
         }
         else
         {
            upadtePassTextBg();
         }
      }
      
      private function updateCommonItem() : void
      {
         var _loc3_:int = 0;
         var _loc1_:* = null;
         var _loc2_:* = null;
         reset();
         _loc3_ = 1;
         while(_loc3_ < 13)
         {
            _loc1_ = MapManager.getByOrderingDungeonInfo(_loc3_);
            if(_loc1_)
            {
               _loc2_ = _maps[_loc3_ - 1] as DungeonMapItem;
               _loc2_.isNightmare = false;
               _loc2_.mapId = _loc1_.ID;
               _loc2_.setLimitLevel(_loc1_.MinLv,_loc1_.MaxLv);
            }
            _loc3_++;
         }
      }
      
      private function updateSpecialItem() : void
      {
         var _loc3_:int = 0;
         var _loc1_:* = null;
         var _loc2_:* = null;
         reset();
         _loc3_ = 1;
         while(_loc3_ < 13)
         {
            _loc1_ = MapManager.getByOrderingAcademyDungeonInfo(_loc3_);
            if(_loc1_)
            {
               _loc2_ = _maps[_loc3_ - 1] as DungeonMapItem;
               _loc2_.isNightmare = false;
               _loc2_.mapId = MapManager.getByOrderingAcademyDungeonInfo(_loc3_).ID;
               _loc2_.setLimitLevel(_loc1_.MinLv,_loc1_.MaxLv);
            }
            _loc3_++;
         }
      }
      
      private function updateActivityItem() : void
      {
         var _loc8_:int = 0;
         var _loc2_:* = null;
         var _loc4_:* = null;
         var _loc6_:* = null;
         var _loc1_:* = null;
         var _loc5_:* = null;
         reset();
         var _loc7_:Number = TimeManager.Instance.Now().time;
         var _loc3_:int = 1;
         _loc8_ = 1;
         while(_loc8_ < 13)
         {
            _loc2_ = MapManager.getByOrderingActivityDungeonInfo(_loc8_);
            if(_loc2_)
            {
               _loc4_ = _maps[_loc3_ - 1] as DungeonMapItem;
               if(MapManager.Instance.activeDoubleIds.indexOf(_loc2_.ID) != -1)
               {
                  _loc6_ = MapManager.Instance.activeDoubleDic[_loc2_.ID];
                  if(_loc6_)
                  {
                     _loc1_ = _loc6_.startDate;
                     _loc5_ = _loc6_.endDate;
                     if(_loc7_ >= _loc1_.time && _loc7_ < _loc5_.time)
                     {
                        _loc4_.isDouble = _loc6_.isDouble;
                        _loc4_.isNightmare = false;
                        _loc4_.mapId = _loc2_.ID;
                        _loc4_.setLimitLevel(_loc2_.MinLv,_loc2_.MaxLv);
                        _loc3_++;
                     }
                  }
               }
               else
               {
                  _loc4_.isNightmare = false;
                  _loc4_.mapId = MapManager.getByOrderingActivityDungeonInfo(_loc8_).ID;
                  _loc4_.setLimitLevel(_loc2_.MinLv,_loc2_.MaxLv);
                  _loc3_++;
               }
            }
            _loc8_++;
         }
      }
      
      private function updateNightmareItem() : void
      {
         var _loc5_:int = 0;
         var _loc1_:* = null;
         var _loc3_:* = null;
         var _loc4_:* = null;
         var _loc2_:* = null;
         reset();
         _loc5_ = 1;
         while(_loc5_ < 13)
         {
            _loc1_ = MapManager.getByOrderingNightmareDungeonInfo(_loc5_);
            if(_loc1_)
            {
               _loc3_ = _maps[_loc5_ - 1] as DungeonMapItem;
               _loc3_.isNightmare = true;
               _loc3_.mapId = MapManager.getByOrderingNightmareDungeonInfo(_loc5_).ID;
               _loc4_ = _loc1_.AdviceTips.split("|");
               if(_loc4_.length >= 4 + 1)
               {
                  _loc2_ = _loc4_[4].split("-");
                  _loc3_.setLimitLevel(_loc2_[0],_loc2_[1]);
               }
            }
            _loc5_++;
         }
      }
      
      private function updateSingleItem() : void
      {
         var _loc8_:int = 0;
         var _loc2_:* = null;
         var _loc4_:* = null;
         var _loc6_:* = null;
         var _loc1_:* = null;
         var _loc5_:* = null;
         reset();
         var _loc7_:Number = TimeManager.Instance.Now().time;
         var _loc3_:int = 1;
         _loc8_ = 1;
         while(_loc8_ < 13)
         {
            _loc2_ = MapManager.getByOrderingSingleDungeonInfo(_loc8_);
            if(_loc2_)
            {
               _loc4_ = _maps[_loc3_ - 1] as DungeonMapItem;
               if(MapManager.Instance.singleDoubleIds.indexOf(_loc2_.ID) != -1)
               {
                  _loc6_ = MapManager.Instance.singleDoubleDic[_loc2_.ID];
                  if(_loc6_)
                  {
                     _loc1_ = _loc6_.startDate;
                     _loc5_ = _loc6_.endDate;
                     if(_loc7_ >= _loc1_.time && _loc7_ < _loc5_.time)
                     {
                        _loc4_.isDouble = _loc6_.isDouble;
                        _loc4_.isNightmare = false;
                        _loc4_.mapId = _loc2_.ID;
                        _loc4_.setLimitLevel(_loc2_.MinLv,_loc2_.MaxLv);
                        _loc3_++;
                     }
                  }
               }
               else
               {
                  _loc4_.isNightmare = false;
                  _loc4_.mapId = _loc2_.ID;
                  _loc4_.setLimitLevel(_loc2_.MinLv,_loc2_.MaxLv);
                  _loc3_++;
               }
            }
            _loc8_++;
         }
      }
      
      private function reset() : void
      {
         var _loc3_:int = 0;
         var _loc1_:* = null;
         var _loc2_:int = 0;
         InitChooseMapState();
         _loc3_ = 1;
         while(_loc3_ < _maps.length)
         {
            _loc1_ = _maps[_loc3_ - 1] as DungeonMapItem;
            _loc1_.selected = false;
            _loc1_.stopShine();
            _loc1_.mapId = -1;
            _loc1_.isDouble = false;
            _loc3_++;
         }
         _loc2_ = 0;
         while(_loc2_ < _btns.length)
         {
            _btns[_loc2_].selected = false;
            _btns[_loc2_].stopShine();
            _loc2_++;
         }
      }
      
      private function InitChooseMapState() : void
      {
         _currentSelectedItem = null;
         var _loc1_:* = true;
         _nightmareBtn.visible = _loc1_;
         _loc1_ = _loc1_;
         _heroBtn.visible = _loc1_;
         _loc1_ = _loc1_;
         _hardBtn.visible = _loc1_;
         _normalBtn.visible = _loc1_;
         _epicBtn.visible = false;
         _loc1_ = false;
         _nightmareBtn.visible = _loc1_;
         _loc1_ = _loc1_;
         _heroBtn.enable = _loc1_;
         _loc1_ = _loc1_;
         _hardBtn.enable = _loc1_;
         _normalBtn.enable = _loc1_;
         _epicBtn.enable = false;
         adaptButtons(0);
         ObjectUtils.disposeAllChildren(_dungeonPreView);
         if(_preViewLoader)
         {
            _preViewLoader.removeEventListener("complete",__onPreViewComplete);
            _preViewLoader = null;
         }
         _preViewLoader = LoadResourceManager.Instance.createLoader(PathManager.SITE_MAIN + "image/map/10000/samll_map.png",0);
         _preViewLoader.addEventListener("complete",__onPreViewComplete);
         LoadResourceManager.Instance.startLoad(_preViewLoader);
         if(_titleLoader != null)
         {
            _titleLoader.removeEventListener("complete",__onTitleComplete);
         }
         _titleLoader = LoadResourceManager.Instance.createLoader(PathManager.SITE_MAIN + "image/map/10000/icon.png",0);
         _titleLoader.addEventListener("complete",__onTitleComplete);
         LoadResourceManager.Instance.startLoad(_titleLoader);
         _dungeonDescriptionTxt.text = LanguageMgr.GetTranslation("tank.manager.selectDuplicate");
      }
      
      private function upadtePassTextBg() : void
      {
         if(_checkBox.selected)
         {
            _passInput.mouseChildren = true;
            _passInput.mouseEnabled = true;
            _passInput.setFocus();
         }
         else
         {
            _passInput.mouseChildren = false;
            _passInput.mouseEnabled = false;
            _passInput.text = "";
         }
      }
      
      public function get roomName() : String
      {
         return _nameInput.text;
      }
      
      public function get roomPass() : String
      {
         return _passInput.text;
      }
      
      public function get selectedDungeonType() : int
      {
         return _selectedDungeonType;
      }
      
      public function get select() : Boolean
      {
         return _bossBtn.selected;
      }
      
      private function __onItemSelect(param1:Event) : void
      {
         var _loc3_:DungeonMapItem = param1.target as DungeonMapItem;
         _bossBtn.selected = false;
         if(_loc3_.mapId == 31)
         {
            setBtnVisible();
         }
         else if(_btnGroup.selectIndex == 0 && isBossBtnCanClick())
         {
            setBtnVisible(true);
         }
         if(_btnGroup.selectIndex == 2)
         {
            setBtnVisible(false);
         }
         if(_currentSelectedItem && _currentSelectedItem != _loc3_)
         {
            _currentSelectedItem.selected = false;
         }
         _currentSelectedItem = _loc3_;
         stopShineMap();
         stopShineLevelBtn();
         var _loc5_:int = 0;
         var _loc4_:* = _btns;
         for each(var _loc2_ in _btns)
         {
            _loc2_.selected = false;
         }
         _selectedLevel = -1;
         updateDescription();
         updatePreView();
         updateLevelBtn();
         addEnterNumInfo();
         if(!PlayerManager.Instance.Self.isDungeonGuideFinish(122))
         {
            NewHandContainer.Instance.showArrow(130,0,"guide.dungeon.step4ArrowPos","asset.trainer.dungeonGuide4Txt","guide.dungeon.step4TipPos",LayerManager.Instance.getLayerByType(2));
         }
      }
      
      private function showAlert() : void
      {
         var _loc1_:Frame = ComponentFactory.Instance.creat("room.FifthPreview");
         _loc1_.addEventListener("response",__onPreResponse);
         _loc1_.escEnable = true;
         LayerManager.Instance.addToLayer(_loc1_,2,false,1);
      }
      
      private function __onPreResponse(param1:FrameEvent) : void
      {
         var _loc2_:Frame = param1.target as Frame;
         _loc2_.removeEventListener("response",__onPreResponse);
         _loc2_.dispose();
      }
      
      private function __btnClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         stopShineLevelBtn();
         var _loc2_:* = param1.currentTarget;
         if(_easyBtn !== _loc2_)
         {
            if(_normalBtn !== _loc2_)
            {
               if(_hardBtn !== _loc2_)
               {
                  if(_heroBtn !== _loc2_)
                  {
                     if(_epicBtn !== _loc2_)
                     {
                        if(_nightmareBtn === _loc2_)
                        {
                           _selectedLevel = 4;
                        }
                     }
                     else
                     {
                        _selectedLevel = 5;
                     }
                  }
                  else
                  {
                     _selectedLevel = 3;
                  }
               }
               else
               {
                  _selectedLevel = 2;
               }
            }
            else
            {
               _selectedLevel = 1;
            }
         }
         else
         {
            _selectedLevel = 0;
         }
         if(!PlayerManager.Instance.Self.isDungeonGuideFinish(122))
         {
            NewHandContainer.Instance.showArrow(130,0,"guide.dungeon.step5ArrowPos","","",LayerManager.Instance.getLayerByType(2));
         }
      }
      
      private function updateDescription() : void
      {
         if(_titleLoader != null)
         {
            _titleLoader.removeEventListener("complete",__onTitleComplete);
         }
         _titleLoader = LoadResourceManager.Instance.createLoader(solveTitlePath(),0);
         _titleLoader.addEventListener("complete",__onTitleComplete);
         LoadResourceManager.Instance.startLoad(_titleLoader);
         if(_currentSelectedItem)
         {
            _dungeonDescriptionTxt.text = MapManager.getDungeonInfo(_currentSelectedItem.mapId).Description;
         }
         else
         {
            _dungeonDescriptionTxt.text = LanguageMgr.GetTranslation("tank.manager.selectDuplicate");
         }
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
            _loc1_ = _loc1_ + "10000/icon.png";
         }
         return _loc1_;
      }
      
      private function updatePreView() : void
      {
         ObjectUtils.disposeAllChildren(_dungeonPreView);
         if(_preViewLoader)
         {
            _preViewLoader.removeEventListener("complete",__onPreViewComplete);
            _preViewLoader = null;
         }
         _preViewLoader = LoadResourceManager.Instance.createLoader(solvePreViewPath(),0);
         _preViewLoader.addEventListener("complete",__onPreViewComplete);
         LoadResourceManager.Instance.startLoad(_preViewLoader);
      }
      
      private function solvePreViewPath() : String
      {
         var _loc1_:String = PathManager.SITE_MAIN + "image/map/";
         if(_currentSelectedItem)
         {
            if(_currentSelectedItem.isNightmare)
            {
               _loc1_ = _loc1_ + (_currentSelectedItem.mapId.toString() + "/samll_map_e.png");
            }
            else
            {
               _loc1_ = _loc1_ + (_currentSelectedItem.mapId.toString() + "/samll_map.png");
            }
         }
         else
         {
            _loc1_ = _loc1_ + "10000/samll_map.png";
         }
         return _loc1_;
      }
      
      private function setSpeBossBtnState(param1:Boolean) : void
      {
         _bossBtn.visible = true;
         _bossBtnStrip.visible = true;
         _freeOpenBossCountBg.visible = false;
         _freeOpenBossCountTxt.visible = false;
         if(PlayerManager.Instance.Self.VIPLevel >= 7 && PlayerManager.Instance.Self.IsVIP && param1)
         {
            _bossBtnStrip.visible = false;
            var _loc2_:Boolean = true;
            _bossBtn.buttonMode = _loc2_;
            _bossBtn.mouseEnabled = _loc2_;
            _bossBtn.filters = null;
         }
         else
         {
            _bossBtnStrip.visible = true;
            _loc2_ = false;
            _bossBtn.buttonMode = _loc2_;
            _bossBtn.mouseEnabled = _loc2_;
            _bossBtn.filters = _grayFilters;
         }
         _bossBtn.selected = false;
      }
      
      private function setBossBtnState(param1:Boolean) : void
      {
         _bossBtn.visible = true;
         if(param1)
         {
            _bossBtnStrip.visible = false;
            var _loc2_:Boolean = true;
            _bossBtn.buttonMode = _loc2_;
            _bossBtn.mouseEnabled = _loc2_;
            _bossBtn.filters = null;
         }
         else
         {
            _bossBtnStrip.visible = true;
            _loc2_ = false;
            _bossBtn.buttonMode = _loc2_;
            _bossBtn.mouseEnabled = _loc2_;
            _bossBtn.filters = _grayFilters;
         }
         _bossBtn.selected = false;
      }
      
      private function updateLevelBtn() : void
      {
         var _loc1_:* = true;
         _nightmareBtn.visible = _loc1_;
         _loc1_ = _loc1_;
         _heroBtn.visible = _loc1_;
         _loc1_ = _loc1_;
         _hardBtn.visible = _loc1_;
         _loc1_ = _loc1_;
         _normalBtn.visible = _loc1_;
         _easyBtn.visible = _loc1_;
         _epicBtn.visible = false;
         _loc1_ = false;
         _nightmareBtn.enable = _loc1_;
         _loc1_ = _loc1_;
         _heroBtn.enable = _loc1_;
         _loc1_ = _loc1_;
         _hardBtn.enable = _loc1_;
         _loc1_ = _loc1_;
         _normalBtn.enable = _loc1_;
         _easyBtn.enable = _loc1_;
         _epicBtn.enable = false;
         if(_currentSelectedItem && MapManager.getDungeonInfo(_currentSelectedItem.mapId).isOpen)
         {
            adaptButtons(_currentSelectedItem.mapId);
            if(_currentSelectedItem.mapId != 70001 && _currentSelectedItem.mapId != 12016)
            {
               _easyBtn.enable = PlayerManager.Instance.Self.getPveMapPermission(_currentSelectedItem.mapId,0);
               _normalBtn.enable = PlayerManager.Instance.Self.getPveMapPermission(_currentSelectedItem.mapId,1);
               _hardBtn.enable = PlayerManager.Instance.Self.getPveMapPermission(_currentSelectedItem.mapId,2);
               _heroBtn.enable = PlayerManager.Instance.Self.getPveMapPermission(_currentSelectedItem.mapId,3);
               _epicBtn.enable = PVEMapPermissionManager.Instance.getPveMapEpicPermission(_currentSelectedItem.mapId,PlayerManager.Instance.Self.PveEpicPermission);
               _nightmareBtn.enable = PlayerManager.Instance.Self.getPveMapPermission(_currentSelectedItem.mapId,4);
            }
         }
         else
         {
            adaptButtons(0);
         }
      }
      
      private function adaptButtons(param1:int) : void
      {
         var _loc4_:int = 0;
         var _loc2_:DungeonInfo = MapManager.getDungeonInfo(param1);
         if(!_loc2_)
         {
            _easyBtn.visible = false;
            _nightmareBtn.visible = false;
            _normalBtn.x = _rect3.x;
            _hardBtn.x = _rect3.y;
            _heroBtn.x = _rect3.width;
            return;
         }
         if(_btnGroup.selectIndex == 3)
         {
            var _loc5_:* = false;
            _nightmareBtn.visible = _loc5_;
            _loc5_ = _loc5_;
            _heroBtn.visible = _loc5_;
            _loc5_ = _loc5_;
            _hardBtn.visible = _loc5_;
            _loc5_ = _loc5_;
            _normalBtn.visible = _loc5_;
            _easyBtn.visible = _loc5_;
            _selectedLevel = 4;
            return;
         }
         _easyBtn.visible = _loc2_.SimpleTemplateIds != "";
         _normalBtn.visible = _loc2_.NormalTemplateIds != "";
         _hardBtn.visible = _loc2_.HardTemplateIds != "";
         _heroBtn.visible = _loc2_.TerrorTemplateIds != "";
         _epicBtn.visible = _loc2_.EpicTemplateIds != "";
         if(_loc2_.ID == 27 || _loc2_.ID == 30)
         {
            _nightmareBtn.visible = _loc2_.NightmareTemplateIds != "";
         }
         else
         {
            _nightmareBtn.visible = false;
         }
         var _loc3_:Vector.<ShineSelectButton> = new Vector.<ShineSelectButton>();
         _loc4_ = 0;
         while(_loc4_ < _btns.length)
         {
            if(_btns[_loc4_].visible)
            {
               _loc3_.push(_btns[_loc4_]);
            }
            _loc4_++;
         }
         switch(int(_loc3_.length))
         {
            case 0:
               break;
            case 1:
               _loc3_[0].visible = false;
               _loc5_ = _loc3_[0];
               if(_easyBtn !== _loc5_)
               {
                  if(_normalBtn !== _loc5_)
                  {
                     if(_hardBtn !== _loc5_)
                     {
                        if(_heroBtn !== _loc5_)
                        {
                           if(_nightmareBtn === _loc5_)
                           {
                              _selectedLevel = 4;
                           }
                        }
                        else
                        {
                           _selectedLevel = 3;
                        }
                     }
                     else
                     {
                        _selectedLevel = 2;
                     }
                  }
                  else
                  {
                     _selectedLevel = 1;
                  }
               }
               else
               {
                  _selectedLevel = 0;
               }
               break;
            case 2:
               _loc3_[0].x = _rect2.x;
               _loc3_[1].x = _rect2.y;
               break;
            case 3:
               _loc3_[0].x = _rect3.x;
               _loc3_[1].x = _rect3.y;
               _loc3_[2].x = _rect3.width;
               break;
            case 4:
               _loc3_[0].x = _rect1.x;
               _loc3_[1].x = _rect1.y;
               _loc3_[2].x = _rect1.width;
               _loc3_[3].x = _rect1.height;
               break;
            case 5:
               _loc3_[0].x = _rect4.x;
               _loc3_[1].x = _rect4.y;
               _loc3_[2].x = _rect4.width;
               _loc3_[3].x = _rect4.height;
         }
      }
      
      private function __onTitleComplete(param1:LoaderEvent) : void
      {
         if(_dungeonTitle && _titleLoader && _titleLoader.content)
         {
            ObjectUtils.disposeAllChildren(_dungeonTitle);
            _dungeonTitle.addChild(Bitmap(_titleLoader.content));
            _titleLoader.removeEventListener("complete",__onTitleComplete);
            _titleLoader = null;
         }
      }
      
      private function __onPreViewComplete(param1:LoaderEvent) : void
      {
         if(_dungeonPreView && _preViewLoader && _preViewLoader.content)
         {
            ObjectUtils.disposeAllChildren(_dungeonPreView);
            _dungeonPreView.addChild(Bitmap(_preViewLoader.content));
            _preViewLoader.removeEventListener("complete",__onPreViewComplete);
            _preViewLoader = null;
         }
      }
      
      public function updateActityAndSingleView() : void
      {
         if(_btnGroup.selectIndex == 2)
         {
            updateActivityItem();
         }
         else if(_btnGroup.selectIndex == 4)
         {
            updateSingleItem();
         }
      }
      
      public function dispose() : void
      {
         var _loc2_:int = 0;
         removeEvents();
         var _loc4_:int = 0;
         var _loc3_:* = _maps;
         for each(var _loc1_ in _maps)
         {
            _loc1_.removeEventListener("select",__onItemSelect);
         }
         _titleLoader = null;
         _preViewLoader = null;
         if(_modebg)
         {
            ObjectUtils.disposeObject(_modebg);
         }
         _modebg = null;
         if(_roomMode)
         {
            ObjectUtils.disposeObject(_roomMode);
         }
         _roomMode = null;
         if(_roomName)
         {
            ObjectUtils.disposeObject(_roomName);
         }
         _roomName = null;
         if(_roomPass)
         {
            ObjectUtils.disposeObject(_roomPass);
         }
         _roomPass = null;
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
         if(_modeDescriptionTxt)
         {
            ObjectUtils.disposeObject(_modeDescriptionTxt);
         }
         _modeDescriptionTxt = null;
         if(_fbMode)
         {
            ObjectUtils.disposeObject(_fbMode);
         }
         _fbMode = null;
         if(_topleftbg)
         {
            ObjectUtils.disposeObject(_topleftbg);
         }
         _topleftbg = null;
         if(_getExpText)
         {
            ObjectUtils.disposeObject(_getExpText);
         }
         _getExpText = null;
         if(_middlebg)
         {
            ObjectUtils.disposeObject(_middlebg);
         }
         _middlebg = null;
         if(_mapbg)
         {
            ObjectUtils.disposeObject(_mapbg);
         }
         _mapbg = null;
         if(_chooseFB)
         {
            ObjectUtils.disposeObject(_chooseFB);
         }
         _chooseFB = null;
         if(_dungeonList)
         {
            ObjectUtils.disposeObject(_dungeonList);
         }
         _dungeonList = null;
         if(_dungeonListContainer)
         {
            ObjectUtils.disposeObject(_dungeonListContainer);
         }
         _dungeonListContainer = null;
         if(_dungeonPreView)
         {
            ObjectUtils.disposeObject(_dungeonPreView);
         }
         _dungeonPreView = null;
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
         if(_dungeonTitle)
         {
            ObjectUtils.disposeObject(_dungeonTitle);
         }
         _dungeonTitle = null;
         if(_dungeonDescriptionTxt)
         {
            ObjectUtils.disposeObject(_dungeonDescriptionTxt);
         }
         _dungeonDescriptionTxt = null;
         if(_btnGroup)
         {
            ObjectUtils.disposeObject(_btnGroup);
         }
         _btnGroup = null;
         if(_mapTypBtn_n)
         {
            ObjectUtils.disposeObject(_mapTypBtn_n);
         }
         _mapTypBtn_n = null;
         if(_mapTypBtn_s)
         {
            ObjectUtils.disposeObject(_mapTypBtn_s);
         }
         _mapTypBtn_s = null;
         if(_mapTypBtn_a)
         {
            ObjectUtils.disposeObject(_mapTypBtn_a);
         }
         _mapTypBtn_a = null;
         if(_mapTypBtn_nightmare)
         {
            ObjectUtils.disposeObject(_mapTypBtn_nightmare);
         }
         _mapTypBtn_nightmare = null;
         if(_mapTypBtn_single)
         {
            ObjectUtils.disposeObject(_mapTypBtn_single);
         }
         _mapTypBtn_single = null;
         if(_mapTypBtn_ad)
         {
            ObjectUtils.disposeObject(_mapTypBtn_ad);
         }
         _mapTypBtn_ad = null;
         if(_enterNumDes)
         {
            ObjectUtils.disposeObject(_enterNumDes);
         }
         _enterNumDes = null;
         if(_bgBottom)
         {
            ObjectUtils.disposeObject(_bgBottom);
         }
         _bgBottom = null;
         if(_diff)
         {
            ObjectUtils.disposeObject(_diff);
         }
         _diff = null;
         if(_group)
         {
            ObjectUtils.disposeObject(_group);
         }
         _group = null;
         if(_easyBtn)
         {
            ObjectUtils.disposeObject(_easyBtn);
         }
         _easyBtn = null;
         if(_normalBtn)
         {
            ObjectUtils.disposeObject(_normalBtn);
         }
         _normalBtn = null;
         if(_hardBtn)
         {
            ObjectUtils.disposeObject(_hardBtn);
         }
         _hardBtn = null;
         if(_heroBtn)
         {
            ObjectUtils.disposeObject(_heroBtn);
         }
         _heroBtn = null;
         if(_epicBtn)
         {
            ObjectUtils.disposeObject(_epicBtn);
         }
         _epicBtn = null;
         if(_nightmareBtn)
         {
            ObjectUtils.disposeObject(_nightmareBtn);
         }
         _nightmareBtn = null;
         if(_bossBtn)
         {
            ObjectUtils.disposeObject(_bossBtn);
         }
         _bossBtn = null;
         if(_bossBtnStrip)
         {
            ObjectUtils.disposeObject(_bossBtnStrip);
         }
         _bossBtnStrip = null;
         _loc2_ = 0;
         while(_loc2_ < _btns.length)
         {
            if(_btns[_loc2_])
            {
               ObjectUtils.disposeObject(_btns[_loc2_]);
            }
            _btns[_loc2_] = null;
            _loc2_++;
         }
         _btns = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
      
      public function checkState() : Boolean
      {
         if(!_currentSelectedItem)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.manager.selectDuplicate"));
            _bossBtn.selected = false;
            shineMap();
            return false;
         }
         if(!MapManager.getDungeonInfo(_currentSelectedItem.mapId).isOpen)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.room.duplicate.notOpen"));
            return false;
         }
         if(_selectedLevel < 0)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.room.RoomMapSetPanelDuplicate.choicePermissionType"));
            _bossBtn.selected = false;
            shineLevelBtn();
            return false;
         }
         if(FilterWordManager.IsNullorEmpty(_nameInput.text))
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.roomlist.RoomListIICreateRoomView.name"));
            SoundManager.instance.play("008");
            return false;
         }
         if(FilterWordManager.isGotForbiddenWords(_nameInput.text,"name"))
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.roomlist.RoomListIICreateRoomView.string"));
            SoundManager.instance.play("008");
            return false;
         }
         if(_checkBox.selected && FilterWordManager.IsNullorEmpty(_passInput.text))
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.roomlist.RoomListIICreateRoomView.set"));
            SoundManager.instance.play("008");
            return false;
         }
         return true;
      }
      
      private function shineMap() : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = _maps;
         for each(var _loc1_ in _maps)
         {
            if(_loc1_.mapId > 0)
            {
               _loc1_.shine();
            }
         }
      }
      
      private function stopShineMap() : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = _maps;
         for each(var _loc1_ in _maps)
         {
            _loc1_.stopShine();
         }
      }
      
      private function shineLevelBtn() : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = _btns;
         for each(var _loc1_ in _btns)
         {
            if(_loc1_.enable)
            {
               _loc1_.shine();
            }
         }
      }
      
      private function stopShineLevelBtn() : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = _btns;
         for each(var _loc1_ in _btns)
         {
            _loc1_.stopShine();
         }
      }
      
      public function get selectedMapID() : int
      {
         return !!_currentSelectedItem?_currentSelectedItem.mapId:0;
      }
      
      public function get isDouble() : Boolean
      {
         return !!_currentSelectedItem?_currentSelectedItem.isDouble:false;
      }
      
      public function get selectedLevel() : int
      {
         return _selectedLevel;
      }
   }
}
