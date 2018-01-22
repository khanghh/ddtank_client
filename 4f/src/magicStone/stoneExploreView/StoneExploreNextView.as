package magicStone.stoneExploreView
{
   import bagAndInfo.cell.BagCell;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.manager.ChatManager;
   import ddt.manager.GameInSocketOut;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.StateManager;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import game.GameManager;
   import gameCommon.GameControl;
   
   public class StoneExploreNextView extends Sprite
   {
       
      
      private var ACTIVITYDUNGEONPOINTSNUM:String = "asset.game.nextView.count_";
      
      private var _numBitmapArray:Array;
      
      private var _cdData:Number = 0;
      
      private var _id:int;
      
      private var _bg:Bitmap;
      
      private var _nextBtn:BaseButton;
      
      private var _quitBtn:BaseButton;
      
      private var _hBox:HBox;
      
      private var _isNext:Boolean;
      
      private var _playerBlood:int;
      
      private var _quiTxt:FilterFrameText;
      
      private var _posStr:String = "333,-302|307,-302|277,-302|243,-302|210,-302|165,-302|127,-302";
      
      public function StoneExploreNextView(param1:int, param2:Boolean = false){super();}
      
      private function initView() : void{}
      
      public function setQuitPos() : void{}
      
      private function initEvent() : void{}
      
      private function __startLoading(param1:Event) : void{}
      
      private function __nextBtnHandler(param1:MouseEvent) : void{}
      
      private function __quitBtnHandler(param1:MouseEvent) : void{}
      
      public function setData(param1:Array) : void{}
      
      public function setBtnEnable() : void{}
      
      public function dispose() : void{}
      
      public function get Id() : int{return 0;}
   }
}
