package newTitle.view
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.loader.BaseLoader;
   import com.pickgliss.loader.LoadResourceManager;
   import com.pickgliss.loader.LoaderEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.SelectedCheckButton;
   import com.pickgliss.ui.controls.SelectedTextButton;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.events.EffortEvent;
   import ddt.manager.EffortManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PathManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import hall.event.NewHallEvent;
   import newTitle.NewTitleControl;
   import newTitle.NewTitleManager;
   import newTitle.event.NewTitleEvent;
   import newTitle.model.NewTitleModel;
   
   public class NewTitleFrame extends Frame
   {
       
      
      private var _titleBg:Bitmap;
      
      private var _currentTitle:Bitmap;
      
      private var _titleSprite:Sprite;
      
      private var _titleTxt:FilterFrameText;
      
      private var _hideBtn:SelectedCheckButton;
      
      private var _selectedButtonGroup:SelectedButtonGroup;
      
      private var _hasTitleBtn:SelectedTextButton;
      
      private var _allTitleBtn:SelectedTextButton;
      
      private var _titleList:NewTitleListView;
      
      private var _titleBottomBg:MutipleImage;
      
      private var _titleListBg:ScaleBitmapImage;
      
      private var _titleProBg:MutipleImage;
      
      private var _useBtnBg:ScaleBitmapImage;
      
      private var _useBtn:SimpleBitmapButton;
      
      private var _propertyText:FilterFrameText;
      
      private var _oldTitleText:FilterFrameText;
      
      private var _selectTitle:NewTitleModel;
      
      public function NewTitleFrame(){super();}
      
      private function initView() : void{}
      
      private function creatTitleSprite() : void{}
      
      private function initEvent() : void{}
      
      private function updateTitleList() : void{}
      
      public function __onSetSelectTitleForCurrent(param1:NewTitleEvent) : void{}
      
      protected function __onUseClick(param1:MouseEvent) : void{}
      
      protected function __onHideTitleClick(param1:MouseEvent) : void{}
      
      protected function __onItemClick(param1:NewTitleEvent) : void{}
      
      private function setPropertyText() : void{}
      
      private function isOwnTitle(param1:String) : Boolean{return false;}
      
      private function loadIcon(param1:NewTitleModel) : void{}
      
      protected function __onComplete(param1:LoaderEvent) : void{}
      
      protected function __onSelectChange(param1:Event) : void{}
      
      private function __upadteTitle(param1:EffortEvent) : void{}
      
      public function show() : void{}
      
      private function __frameEventHandler(param1:FrameEvent) : void{}
      
      private function removeEvent() : void{}
      
      override public function dispose() : void{}
   }
}
