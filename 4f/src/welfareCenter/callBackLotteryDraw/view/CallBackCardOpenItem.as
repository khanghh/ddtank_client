package welfareCenter.callBackLotteryDraw.view
{
   import bagAndInfo.cell.BagCell;
   import baglocked.BaglockedManager;
   import com.greensock.TweenLite;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.UICreatShortcut;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.events.CEvent;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.CheckMoneyUtils;
   import ddt.utils.PositionUtils;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import welfareCenter.callBackLotteryDraw.CallBackLotteryDrawController;
   import welfareCenter.callBackLotteryDraw.CallBackLotteryDrawManager;
   
   public class CallBackCardOpenItem extends Sprite implements Disposeable
   {
       
      
      private var _index:int;
      
      private var _mc:MovieClip;
      
      private var _bagCell:BagCell;
      
      private var _orglX:int;
      
      private var _orglY:int;
      
      private var _border:MovieClip;
      
      private var _borderTweenLite:TweenLite;
      
      private var _tweenLite:TweenLite;
      
      private var _isClick:Boolean = false;
      
      private var _hasFlipOver:Boolean = false;
      
      private var _buyBtn:SimpleBitmapButton;
      
      private var _manager:CallBackLotteryDrawManager;
      
      private var _award:Object;
      
      private var _maskSp:Sprite;
      
      public function CallBackCardOpenItem(param1:int, param2:int, param3:int){super();}
      
      private function onCardOpenMCMouseHandler(param1:MouseEvent) : void{}
      
      public function playCardOpen() : void{}
      
      private function onCardOpenEnterFrame(param1:Event) : void{}
      
      public function getMCTotalFrames() : int{return 0;}
      
      private function onBuy(param1:CEvent) : void{}
      
      public function dispose() : void{}
   }
}
