package littleGame.object
{
   import com.greensock.TweenLite;
   import com.greensock.easing.Bounce;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.ChatManager;
   import flash.display.DisplayObject;
   import flash.display.Graphics;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.geom.Point;
   import flash.utils.Dictionary;
   import flash.utils.Timer;
   import littleGame.LittleGameManager;
   import littleGame.actions.LittleLivingDieAction;
   import littleGame.interfaces.ILittleObject;
   import littleGame.model.LittleLiving;
   import littleGame.model.LittleSelf;
   import littleGame.model.Scenario;
   import littleGame.view.GameLittleLiving;
   import littleGame.view.GameScene;
   import littleGame.view.MarkShape;
   import road7th.comm.PackageIn;
   
   public class NormalBoguInhaled extends Sprite implements ILittleObject
   {
      
      public static var NoteCount:int;
      
      private static const MaxNoteCount:int = 3;
      
      private static var littleObjectCount:int = 0;
       
      
      private var _id:int;
      
      protected var _giveup:MovieClip;
      
      protected var _giveupAni:MovieClip;
      
      protected var _scene:Scenario;
      
      protected var _target:LittleLiving;
      
      protected var _self:LittleSelf;
      
      protected var _totalClick:int = 20;
      
      protected var _totalScore:int = 1000;
      
      protected var _clickScore:int;
      
      protected var _clickCount:int = 0;
      
      protected var _time:int;
      
      protected var _score:int;
      
      protected var _timer:Timer;
      
      protected var _inhaleAsset:MovieClip;
      
      protected var _gameLivings:Dictionary;
      
      protected var _markBar:MarkShape;
      
      protected var _running:Boolean = true;
      
      protected var _removed:Boolean = false;
      
      private var _mouseNote:DisplayObject;
      
      public function NormalBoguInhaled()
      {
         super();
         littleObjectCount = Number(littleObjectCount) + 1;
         _id = Number(littleObjectCount);
         mouseChildren = false;
      }
      
      public function get id() : int
      {
         return _id;
      }
      
      public function get type() : String
      {
         return "normalbogu";
      }
      
      override public function toString() : String
      {
         var _loc1_:String = "[NormalBoguInhaled:(";
         return _loc1_ + ")]";
      }
      
      public function initialize(param1:Scenario, param2:PackageIn) : void
      {
         var _loc6_:int = 0;
         var _loc5_:int = 0;
         var _loc3_:* = null;
         _scene = param1;
         _id = param2.readInt();
         _self = _scene.findLiving(param2.readInt()) as LittleSelf;
         _target = _scene.findLiving(param2.readInt());
         _totalClick = param2.readInt();
         _totalScore = param2.readInt();
         _clickScore = param2.readInt();
         _time = param2.readInt();
         var _loc7_:int = param2.readInt();
         var _loc4_:GameScene = LittleGameManager.Instance.gameScene;
         _gameLivings = new Dictionary();
         _gameLivings[_target.id] = _loc4_.findGameLiving(_target.id);
         _loc6_ = 0;
         while(_loc6_ < _loc7_)
         {
            _loc5_ = param2.readInt();
            _loc3_ = _loc4_.findGameLiving(_loc5_);
            if(_loc3_)
            {
               _gameLivings[_loc5_] = _loc3_;
            }
            _loc6_++;
         }
         drawInhaleAsset();
         execute();
      }
      
      protected function drawInhaleAsset() : void
      {
      }
      
      protected function lockLivings() : void
      {
         var _loc2_:* = null;
         var _loc1_:* = null;
         var _loc6_:* = null;
         var _loc5_:int = 0;
         var _loc3_:Array = [];
         var _loc8_:int = 0;
         var _loc7_:* = _gameLivings;
         for(var _loc4_ in _gameLivings)
         {
            _loc2_ = _gameLivings[_loc4_];
            if(_loc2_ && _loc2_.parent && _loc2_.inGame)
            {
               _loc2_.lock = true;
               _loc6_ = _loc2_.parent.localToGlobal(new Point(_loc2_.living.dx * _loc2_.living.speed,_loc2_.living.dy * _loc2_.living.speed));
               _loc6_ = globalToLocal(_loc6_);
               _loc2_.x = _loc6_.x;
               _loc2_.y = _loc6_.y;
               _loc3_.push(_loc2_);
            }
         }
         _loc3_.sortOn("y",16);
         _loc5_ = _loc3_.length;
         while(_loc5_ > 0)
         {
            addChildAt(_loc3_[_loc5_ - 1],0);
            _loc5_--;
         }
      }
      
      protected function releaseLivings() : void
      {
         var _loc2_:* = null;
         var _loc5_:* = null;
         var _loc1_:* = null;
         var _loc7_:int = 0;
         var _loc4_:Array = [];
         var _loc9_:int = 0;
         var _loc8_:* = _gameLivings;
         for(var _loc6_ in _gameLivings)
         {
            _loc2_ = _gameLivings[_loc6_];
            if(_loc2_)
            {
               _loc2_.setInhaled(false);
            }
            if(_loc2_.inGame)
            {
               _loc2_.lock = false;
               _loc2_.living.stand();
               _loc2_.living.doAction("stand");
               _loc2_.x = _loc2_.living.pos.x * _loc2_.living.speed;
               _loc2_.y = _loc2_.living.pos.y * _loc2_.living.speed;
               _loc4_.push(_loc2_);
            }
         }
         _loc4_.sortOn("y",16);
         var _loc3_:GameScene = LittleGameManager.Instance.gameScene;
         _loc7_ = 0;
         while(_loc7_ < _loc4_.length)
         {
            _loc3_.addToLayer(_loc4_[_loc7_] as DisplayObject,0);
            _loc7_++;
         }
      }
      
      protected function drawBackground() : void
      {
         var _loc1_:Graphics = graphics;
         _loc1_.beginFill(0,0);
         _loc1_.drawRect(0,0,StageReferance.stageWidth,StageReferance.stageHeight);
         _loc1_.endFill();
      }
      
      protected function drawMark() : void
      {
         _markBar = new MarkShape(_time);
         _markBar.y = 450;
         _markBar.x = StageReferance.stageWidth;
         _markBar.alpha = 0;
         TweenLite.to(_markBar,0.3,{
            "alpha":1,
            "x":StageReferance.stageWidth - _markBar.width - 20,
            "ease":Bounce.easeOut
         });
         addChild(_markBar);
      }
      
      public function invoke(param1:PackageIn) : void
      {
      }
      
      public function execute() : void
      {
         drawBackground();
         _scene.selfInhaled = true;
         LittleGameManager.Instance.mainStage.addChild(this);
         ChatManager.Instance.focusFuncEnabled = false;
         addEvent();
         if(NoteCount < 3)
         {
            _mouseNote = ComponentFactory.Instance.creat("LittleMouseNote");
            addChild(_mouseNote);
            NoteCount = Number(NoteCount) + 1;
         }
      }
      
      protected function __mark(param1:TimerEvent) : void
      {
         if(_markBar)
         {
            _markBar.setTime(_time - _timer.currentCount);
         }
      }
      
      protected function __markComplete(param1:TimerEvent) : void
      {
         var _loc2_:Timer = param1.currentTarget as Timer;
         _loc2_.removeEventListener("timerComplete",__markComplete);
         removeEventListener("click",__click);
         complete();
      }
      
      protected function addEvent() : void
      {
         addEventListener("click",__click);
      }
      
      protected function __click(param1:MouseEvent) : void
      {
         _clickCount = Number(_clickCount) + 1;
         if(_clickCount >= _totalClick)
         {
            removeEventListener("click",__click);
            _score = _totalScore * _clickCount / _totalClick;
            if(_timer)
            {
               _timer.stop();
               _timer.removeEventListener("timerComplete",__markComplete);
               _timer.removeEventListener("timer",__mark);
            }
            complete();
         }
      }
      
      protected function complete() : void
      {
         LittleGameManager.Instance.sendScore(_score,_target.id);
         if(_self)
         {
            _self.doAction("stand");
            _self.MotionState = 2;
            if(_score > 0)
            {
               _self.getScore(_score);
            }
         }
         _running = false;
         _scene.removeObject(this);
      }
      
      protected function removeEvent() : void
      {
         removeEventListener("click",__click);
      }
      
      public function dispose() : void
      {
         _removed = true;
         if(_running)
         {
            return;
         }
         removeEvent();
         ChatManager.Instance.focusFuncEnabled = true;
         ObjectUtils.disposeObject(_mouseNote);
         _mouseNote = null;
         ObjectUtils.disposeObject(_markBar);
         _markBar = null;
         ObjectUtils.disposeObject(_inhaleAsset);
         _inhaleAsset = null;
         if(parent)
         {
            parent.removeChild(this);
         }
         if(_target)
         {
            _target.act(new LittleLivingDieAction(_scene,_target));
         }
         _self = null;
         _target = null;
         var _loc3_:int = 0;
         var _loc2_:* = _gameLivings;
         for(var _loc1_ in _gameLivings)
         {
            delete _gameLivings[_loc1_];
         }
         _gameLivings = null;
      }
   }
}
