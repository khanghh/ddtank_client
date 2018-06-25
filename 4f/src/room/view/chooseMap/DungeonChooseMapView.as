package room.view.chooseMap{   import com.pickgliss.events.FrameEvent;   import com.pickgliss.loader.DisplayLoader;   import com.pickgliss.loader.LoadResourceManager;   import com.pickgliss.loader.LoaderEvent;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.LayerManager;   import com.pickgliss.ui.controls.Frame;   import com.pickgliss.ui.controls.ScrollPanel;   import com.pickgliss.ui.controls.SelectedButtonGroup;   import com.pickgliss.ui.controls.SelectedCheckButton;   import com.pickgliss.ui.controls.SelectedTextButton;   import com.pickgliss.ui.controls.TextInput;   import com.pickgliss.ui.controls.container.SimpleTileList;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.ui.image.MutipleImage;   import com.pickgliss.ui.image.ScaleBitmapImage;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.ui.text.TextArea;   import com.pickgliss.utils.ClassUtils;   import com.pickgliss.utils.ObjectUtils;   import ddt.command.StripTip;   import ddt.data.map.DungeonInfo;   import ddt.manager.LanguageMgr;   import ddt.manager.MapManager;   import ddt.manager.MessageTipManager;   import ddt.manager.PVEMapPermissionManager;   import ddt.manager.PathManager;   import ddt.manager.PlayerManager;   import ddt.manager.ServerConfigManager;   import ddt.manager.SoundManager;   import ddt.manager.TimeManager;   import ddt.utils.FilterWordManager;   import ddt.utils.PositionUtils;   import ddt.view.ShineSelectButton;   import flash.display.Bitmap;   import flash.display.MovieClip;   import flash.display.Sprite;   import flash.events.Event;   import flash.events.MouseEvent;   import flash.geom.Rectangle;   import flash.utils.Dictionary;   import kingBless.KingBlessManager;   import room.RoomManager;   import trainer.view.NewHandContainer;      public class DungeonChooseMapView extends Sprite implements Disposeable   {            public static const DUNGEON_NO:int = 13;            public static const DEFAULT_MAP:int = -1;                   private var _titleLoader:DisplayLoader;            private var _preViewLoader:DisplayLoader;            private var _modebg:ScaleBitmapImage;            private var _roomMode:Bitmap;            private var _roomName:FilterFrameText;            private var _roomPass:FilterFrameText;            private var _nameInput:TextInput;            private var _passInput:TextInput;            private var _checkBox:SelectedCheckButton;            private var _modeDescriptionTxt:FilterFrameText;            private var _getExpText:FilterFrameText;            private var _fbMode:FilterFrameText;            private var _topleftbg:ScaleBitmapImage;            private var _getExpBg:Bitmap;            private var _middlebg:MovieClip;            private var _mapbg:MutipleImage;            private var _chooseFB:Bitmap;            private var _dungeonList:SimpleTileList;            private var _maps:Array;            private var _dungeonListContainer:ScrollPanel;            private var _dungeonPreView:Sprite;            private var _descriptionBg:ScaleBitmapImage;            private var _descriptbg:ScaleBitmapImage;            private var _prvviewbg:ScaleBitmapImage;            private var _dungeonTitle:Sprite;            private var _dungeonDescriptionTxt:TextArea;            private var _btnGroup:SelectedButtonGroup;            private var _mapTypBtn_n:SelectedTextButton;            private var _mapTypBtn_s:SelectedTextButton;            private var _mapTypBtn_a:SelectedTextButton;            private var _mapTypBtn_nightmare:SelectedTextButton;            private var _mapTypBtn_single:SelectedTextButton;            private var _mapTypBtn_ad:SelectedTextButton;            private var _selectedDungeonType:int;            private var _enterNumDes:FilterFrameText;            private var _bgBottom:MutipleImage;            private var _diff:Bitmap;            private var _btns:Vector.<ShineSelectButton>;            private var _group:SelectedButtonGroup;            private var _easyBtn:ShineSelectButton;            private var _normalBtn:ShineSelectButton;            private var _hardBtn:ShineSelectButton;            private var _heroBtn:ShineSelectButton;            private var _epicBtn:ShineSelectButton;            private var _nightmareBtn:ShineSelectButton;            private var _bossBtn:SelectedCheckButton;            private var _bossIMG:Bitmap;            private var _bossBtnStrip:StripTip;            private var _grayFilters:Array;            private var _currentSelectedItem:DungeonMapItem;            private var _rect1:Rectangle;            private var _rect2:Rectangle;            private var _rect3:Rectangle;            private var _rect4:Rectangle;            private var _dungeonInfoList:Dictionary;            private var _selectedLevel:int = -1;            private var _freeOpenBossCountBg:Bitmap;            private var _freeOpenBossCountTxt:FilterFrameText;            public function DungeonChooseMapView() { super(); }
            private function initView() : void { }
            private function isBossBtnCanClick() : Boolean { return false; }
            private function refreshFreeOpenBossView() : void { }
            private function updateRoomInfo() : void { }
            private function initInfo() : void { }
            public function checkSelectItemAndLevel() : void { }
            private function initEvents() : void { }
            private function removeEvents() : void { }
            private function __changeHandler(event:Event) : void { }
            private function updateAdvancedItem() : void { }
            private function setBtnVisible(bool:Boolean = false) : void { }
            private function addEnterNumInfo() : void { }
            private function __soundPlay(event:MouseEvent) : void { }
            private function __checkBoxClick(event:MouseEvent) : void { }
            private function updateCommonItem() : void { }
            private function updateSpecialItem() : void { }
            private function updateActivityItem() : void { }
            private function updateNightmareItem() : void { }
            private function updateSingleItem() : void { }
            private function reset() : void { }
            private function InitChooseMapState() : void { }
            private function upadtePassTextBg() : void { }
            public function get roomName() : String { return null; }
            public function get roomPass() : String { return null; }
            public function get selectedDungeonType() : int { return 0; }
            public function get select() : Boolean { return false; }
            private function __onItemSelect(evt:Event) : void { }
            private function showAlert() : void { }
            private function __onPreResponse(event:FrameEvent) : void { }
            private function __btnClick(evt:MouseEvent) : void { }
            private function updateDescription() : void { }
            private function solveTitlePath() : String { return null; }
            private function updatePreView() : void { }
            private function solvePreViewPath() : String { return null; }
            private function setSpeBossBtnState(value:Boolean) : void { }
            private function setBossBtnState(value:Boolean) : void { }
            private function updateLevelBtn() : void { }
            private function adaptButtons(id:int) : void { }
            private function __onTitleComplete(evt:LoaderEvent) : void { }
            private function __onPreViewComplete(evt:LoaderEvent) : void { }
            public function updateActityAndSingleView() : void { }
            public function dispose() : void { }
            public function checkState() : Boolean { return false; }
            private function shineMap() : void { }
            private function stopShineMap() : void { }
            private function shineLevelBtn() : void { }
            private function stopShineLevelBtn() : void { }
            public function get selectedMapID() : int { return 0; }
            public function get isDouble() : Boolean { return false; }
            public function get selectedLevel() : int { return 0; }
   }}