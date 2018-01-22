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
      
      public function ChallengeChooseMapView(){super();}
      
      private function init() : void{}
      
      private function updateItem(param1:int) : void{}
      
      private function __changeHandler(param1:Event) : void{}
      
      private function reset() : void{}
      
      private function updateRoomInfo() : void{}
      
      private function __checkBoxClick(param1:MouseEvent) : void{}
      
      private function upadtePassTextBg() : void{}
      
      private function __roundTimeClick(param1:MouseEvent) : void{}
      
      private function __frameEventHandler(param1:FrameEvent) : void{}
      
      public function set mapId(param1:int) : void{}
      
      private function updatePreview() : void{}
      
      private function updateDescription() : void{}
      
      private function __mapItemClick(param1:*) : void{}
      
      private function solvePreviewPath() : String{return null;}
      
      private function solveTitlePath() : String{return null;}
      
      private function __onPreviewComplete(param1:LoaderEvent) : void{}
      
      private function __onTitleComplete(param1:LoaderEvent) : void{}
      
      public function show() : void{}
      
      public function dispose() : void{}
   }
}
