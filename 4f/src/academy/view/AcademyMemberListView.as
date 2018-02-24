package academy.view
{
   import academy.AcademyController;
   import academy.AcademyEvent;
   import academy.AcademyManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.controls.TextInput;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ClassUtils;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.player.AcademyPlayerInfo;
   import ddt.manager.AcademyFrameManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import times.utils.timerManager.TimerJuggler;
   import times.utils.timerManager.TimerManager;
   
   public class AcademyMemberListView extends Sprite implements Disposeable
   {
      
      public static const ITEM_NUM:int = 12;
       
      
      private var _rightBg:Scale9CornerImage;
      
      private var _rightViewBg:MovieClip;
      
      private var _pagePreBg:ScaleBitmapImage;
      
      private var _pageLastBg:Scale9CornerImage;
      
      private var _searchBG:Scale9CornerImage;
      
      private var _masterTitle:SimpleBitmapButton;
      
      private var _apprenticeTitle:SimpleBitmapButton;
      
      private var _searchBtn:TextButton;
      
      private var _titleline1:ScaleBitmapImage;
      
      private var _titleline2:ScaleBitmapImage;
      
      private var _titleline3:ScaleBitmapImage;
      
      private var _preBtn:SimpleBitmapButton;
      
      private var _nextBtn:SimpleBitmapButton;
      
      private var _freeBtn:TextButton;
      
      private var _nameTitle:FilterFrameText;
      
      private var _levelTitle:FilterFrameText;
      
      private var _stateTitle:FilterFrameText;
      
      private var _fightpowerTitle:FilterFrameText;
      
      private var _pageTxt:FilterFrameText;
      
      private var _searchTxt:TextInput;
      
      private var _items:Vector.<AcademyMemberItem>;
      
      private var _list:VBox;
      
      private var _controller:AcademyController;
      
      private var _currentPage:int = 1;
      
      private var _selectedItem:AcademyMemberItem;
      
      private var _takeMasterBtn:BaseButton;
      
      private var _takeStudentBtn:BaseButton;
      
      private var _isShowSearchInfo:Boolean = false;
      
      private var _timer:TimerJuggler;
      
      public function AcademyMemberListView(param1:AcademyController){super();}
      
      private function init() : void{}
      
      private function initEvent() : void{}
      
      private function removeEvent() : void{}
      
      private function __selfDescribe(param1:Event) : void{}
      
      private function __searchTxtClick(param1:MouseEvent) : void{}
      
      private function creatItems() : void{}
      
      private function cleanItem() : void{}
      
      private function __updateList(param1:AcademyEvent) : void{}
      
      private function __takeMasterClick(param1:MouseEvent) : void{}
      
      private function __takeStudentClick(param1:MouseEvent) : void{}
      
      private function __freeBtnClick(param1:MouseEvent) : void{}
      
      private function __leafBtnClick(param1:MouseEvent) : void{}
      
      private function __register(param1:Event) : void{}
      
      private function updateLeafBtn() : void{}
      
      private function updateListBG() : void{}
      
      private function updateRegisterBtn() : void{}
      
      private function setButtonState(param1:Boolean, param2:Boolean) : void{}
      
      private function __searchBtnClick(param1:MouseEvent) : void{}
      
      private function __itemClick(param1:MouseEvent) : void{}
      
      public function dispose() : void{}
   }
}
