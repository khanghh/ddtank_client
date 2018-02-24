package wishingTree.views
{
   import baglocked.BaglockedManager;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.events.PkgEvent;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.ServerConfigManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.manager.TimeManager;
   import ddt.utils.HelpFrameUtils;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import road7th.comm.PackageIn;
   import road7th.utils.DateUtils;
   import wishingTree.components.PrizeAlterContainer;
   import wishingTree.components.PrizeDropList;
   import wishingTree.components.WishingTreeItem;
   import wonderfulActivity.WonderfulActivityManager;
   
   public class WishingTreeFrame extends Frame
   {
      
      private static const WISHING_CARD:int = 12502;
       
      
      private var _bg:Bitmap;
      
      private var _treeImg:Bitmap;
      
      private var _wishBtn:SimpleBitmapButton;
      
      private var _prizeDisplay:PrizeDropList;
      
      private var _border:Bitmap;
      
      private var _recordBtn:SimpleBitmapButton;
      
      private var _wishingCardCount:FilterFrameText;
      
      private var _wishingTimes:FilterFrameText;
      
      private var _remainDate:FilterFrameText;
      
      private var _vBox:VBox;
      
      private var _itemArr:Vector.<WishingTreeItem>;
      
      private var _glowMc:MovieClip;
      
      private var _alertContainer:PrizeAlterContainer;
      
      private var _mask:Sprite;
      
      private var _itemTxtArr:Array;
      
      private var _btnHelp:SimpleBitmapButton;
      
      private var _inputBg:Scale9CornerImage;
      
      private var _inputTxt:FilterFrameText;
      
      private var _maxBtn:SimpleBitmapButton;
      
      private var completeCount:int = 0;
      
      public function WishingTreeFrame(){super();}
      
      private function initView() : void{}
      
      private function addEvents() : void{}
      
      private function initTimer() : void{}
      
      private function timerHandler() : void{}
      
      protected function __wishResultHandler(param1:PkgEvent) : void{}
      
      protected function __dropListSmall(param1:Event) : void{}
      
      protected function __dropListLarge(param1:Event) : void{}
      
      protected function __updateFrameInfo(param1:PkgEvent) : void{}
      
      protected function __recordBtnClick(param1:MouseEvent) : void{}
      
      protected function __wishBtnClick(param1:MouseEvent) : void{}
      
      private function playMC(param1:Boolean, param2:String = "") : void{}
      
      protected function __alterContainerComplete(param1:Event) : void{}
      
      private function alertComplete() : void{}
      
      protected function __mcEnterFrame(param1:Event) : void{}
      
      private function addMask() : void{}
      
      private function removeMask() : void{}
      
      protected function __responseHandler(param1:FrameEvent) : void{}
      
      protected function __maxBtnClick(param1:MouseEvent) : void{}
      
      protected function __inputChange(param1:Event) : void{}
      
      private function removeEvents() : void{}
      
      override public function dispose() : void{}
   }
}
