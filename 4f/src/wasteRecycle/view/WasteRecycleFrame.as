package wasteRecycle.view
{
   import baglocked.BaglockedManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.SelectedCheckButton;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.bagStore.BagStore;
   import ddt.events.BagEvent;
   import ddt.events.PkgEvent;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.manager.TimeManager;
   import ddt.utils.PositionUtils;
   import ddt.view.caddyII.LookTrophy;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import invite.InviteManager;
   import wasteRecycle.WasteRecycleController;
   import wasteRecycle.WasteRecycleManager;
   
   public class WasteRecycleFrame extends Frame
   {
       
      
      private var _bg:Bitmap;
      
      private var _frameBg:ScaleBitmapImage;
      
      private var _recycleBtn:SimpleBitmapButton;
      
      private var _recycleCell:WasteRecycleGoodsCell;
      
      private var _startBtn:SimpleBitmapButton;
      
      private var _awardShowBtn:SimpleBitmapButton;
      
      private var _recycleTips:FilterFrameText;
      
      private var _scoreText:FilterFrameText;
      
      private var _bagView:WasteRecycleBagView;
      
      private var _turnView:WasteRecycleTurnView;
      
      private var _lookTrophy:LookTrophy;
      
      private var _limitText:FilterFrameText;
      
      private var _currentScore:int;
      
      private var _currentCount:int;
      
      private var _continuousOpenBtn:SelectedCheckButton;
      
      private var _btnHelp:BaseButton;
      
      public function WasteRecycleFrame(){super();}
      
      public function show() : void{}
      
      override protected function init() : void{}
      
      override protected function addChildren() : void{}
      
      private function __onRecycleClick(param1:MouseEvent) : void{}
      
      private function __onHelpClick(param1:MouseEvent) : void{}
      
      private function __onComplete(param1:Event) : void{}
      
      private function __onStartClick(param1:MouseEvent) : void{}
      
      private function __onAwardClick(param1:MouseEvent) : void{}
      
      private function updateLottery(param1:int, param2:int) : void{}
      
      override protected function onResponse(param1:int) : void{}
      
      override protected function onFrameClose() : void{}
      
      private function __onStartTurn(param1:PkgEvent) : void{}
      
      private function __onUpdateScore(param1:PkgEvent) : void{}
      
      private function __updateGoods(param1:BagEvent) : void{}
      
      private function initEvent() : void{}
      
      private function removeEvent() : void{}
      
      private function cellBg() : Sprite{return null;}
      
      override public function dispose() : void{}
   }
}
