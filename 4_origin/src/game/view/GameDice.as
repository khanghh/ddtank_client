package game.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ClassUtils;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.geom.Point;
   import flash.utils.Timer;
   import trainer.view.NewHandContainer;
   
   public class GameDice extends Sprite implements Disposeable
   {
       
      
      private var _bg:Bitmap;
      
      private var _countDown:Bitmap;
      
      private var _time:Timer;
      
      private var countTime:int = 5;
      
      private var numSprite:Sprite;
      
      private var diceMc:MovieClip;
      
      private var _beginBtn:BaseButton;
      
      public var diceNum:int;
      
      public var leaderId:int;
      
      public function GameDice()
      {
         super();
         init();
      }
      
      private function init() : void
      {
         _bg = ComponentFactory.Instance.creatBitmap("asset.game.dice.bg");
         addChild(_bg);
         _countDown = ComponentFactory.Instance.creatBitmap("asset.game.dice.countDown");
         addChild(_countDown);
         _time = new Timer(1000);
         _time.addEventListener("timer",_timerHandler);
         _time.start();
         diceMc = ClassUtils.CreatInstance("asset.game.dice.mc");
         diceMc.x = 376;
         diceMc.y = 313;
         addChild(diceMc);
         diceMc.gotoAndStop(1);
         diceMc.visible = false;
         diceMc.addEventListener("diceJump",diceJumpHandler);
         _beginBtn = ComponentFactory.Instance.creatComponentByStylename("game.dice.beginBtn");
         addChild(_beginBtn);
         _beginBtn.addEventListener("click",_beginBtnHandler);
         numSprite = new Sprite();
         addChild(numSprite);
         NewHandContainer.Instance.showArrow(333,180,new Point(511,452),"asset.game.dice.tips","game.dice.tips.Pos",this,0,true);
      }
      
      private function _beginBtnHandler(param1:MouseEvent) : void
      {
         if(leaderId != PlayerManager.Instance.Self.ID)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.game.dice.leaderOnly"));
            return;
         }
         SocketManager.Instance.out.rollGameDice();
         if(_time)
         {
            _time.removeEventListener("timer",_timerHandler);
            _time.stop();
            _time = null;
         }
      }
      
      public function roll() : void
      {
         _beginBtn.visible = false;
         NewHandContainer.Instance.clearArrowByID(-1);
         diceMc.visible = true;
         diceMc.gotoAndPlay(1);
      }
      
      private function _timerHandler(param1:TimerEvent) : void
      {
         while(numSprite.numChildren > 0)
         {
            numSprite.removeChildAt(0);
         }
         var _loc2_:Sprite = ComponentFactory.Instance.creatNumberSprite(countTime,"asset.game.dice.num");
         _loc2_.x = 568;
         _loc2_.y = 233;
         countTime = Number(countTime) - 1;
         numSprite.addChild(_loc2_);
         if(countTime == 0)
         {
            _time.removeEventListener("timer",_timerHandler);
            _time.stop();
            _time = null;
         }
      }
      
      private function diceJumpHandler(param1:Event) : void
      {
         diceMc.gotoAndStop(20 + diceNum);
      }
      
      public function dispose() : void
      {
         NewHandContainer.Instance.clearArrowByID(-1);
         diceMc.removeEventListener("diceJump",diceJumpHandler);
         _beginBtn.removeEventListener("click",_beginBtnHandler);
         if(_time)
         {
            _time.removeEventListener("timer",_timerHandler);
            _time.stop();
            _time = null;
         }
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_countDown);
         _countDown = null;
         ObjectUtils.disposeObject(numSprite);
         numSprite = null;
         ObjectUtils.disposeObject(diceMc);
         diceMc = null;
         ObjectUtils.disposeObject(_beginBtn);
         _beginBtn = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
