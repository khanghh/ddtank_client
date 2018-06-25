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
         var output:String = "[NormalBoguInhaled:(";
         return output + ")]";
      }
      
      public function initialize(scene:Scenario, pkg:PackageIn) : void
      {
         var i:int = 0;
         var livingID:int = 0;
         var gameLiving:* = null;
         _scene = scene;
         _id = pkg.readInt();
         _self = _scene.findLiving(pkg.readInt()) as LittleSelf;
         _target = _scene.findLiving(pkg.readInt());
         _totalClick = pkg.readInt();
         _totalScore = pkg.readInt();
         _clickScore = pkg.readInt();
         _time = pkg.readInt();
         var livingCount:int = pkg.readInt();
         var gameScene:GameScene = LittleGameManager.Instance.gameScene;
         _gameLivings = new Dictionary();
         _gameLivings[_target.id] = gameScene.findGameLiving(_target.id);
         for(i = 0; i < livingCount; )
         {
            livingID = pkg.readInt();
            gameLiving = gameScene.findGameLiving(livingID);
            if(gameLiving)
            {
               _gameLivings[livingID] = gameLiving;
            }
            i++;
         }
         drawInhaleAsset();
         execute();
      }
      
      protected function drawInhaleAsset() : void
      {
      }
      
      protected function lockLivings() : void
      {
         var gameLiving:* = null;
         var livingContainer:* = null;
         var pos:* = null;
         var i:int = 0;
         var sortList:Array = [];
         var _loc8_:int = 0;
         var _loc7_:* = _gameLivings;
         for(var key in _gameLivings)
         {
            gameLiving = _gameLivings[key];
            if(gameLiving && gameLiving.parent && gameLiving.inGame)
            {
               gameLiving.lock = true;
               pos = gameLiving.parent.localToGlobal(new Point(gameLiving.living.dx * gameLiving.living.speed,gameLiving.living.dy * gameLiving.living.speed));
               pos = globalToLocal(pos);
               gameLiving.x = pos.x;
               gameLiving.y = pos.y;
               sortList.push(gameLiving);
            }
         }
         sortList.sortOn("y",16);
         for(i = sortList.length; i > 0; )
         {
            addChildAt(sortList[i - 1],0);
            i--;
         }
      }
      
      protected function releaseLivings() : void
      {
         var gameLiving:* = null;
         var living:* = null;
         var livingContainer:* = null;
         var i:int = 0;
         var sortList:Array = [];
         var _loc9_:int = 0;
         var _loc8_:* = _gameLivings;
         for(var key in _gameLivings)
         {
            gameLiving = _gameLivings[key];
            if(gameLiving)
            {
               gameLiving.setInhaled(false);
            }
            if(gameLiving.inGame)
            {
               gameLiving.lock = false;
               gameLiving.living.stand();
               gameLiving.living.doAction("stand");
               gameLiving.x = gameLiving.living.pos.x * gameLiving.living.speed;
               gameLiving.y = gameLiving.living.pos.y * gameLiving.living.speed;
               sortList.push(gameLiving);
            }
         }
         sortList.sortOn("y",16);
         var gameScene:GameScene = LittleGameManager.Instance.gameScene;
         for(i = 0; i < sortList.length; )
         {
            gameScene.addToLayer(sortList[i] as DisplayObject,0);
            i++;
         }
      }
      
      protected function drawBackground() : void
      {
         var g:Graphics = graphics;
         g.beginFill(0,0);
         g.drawRect(0,0,StageReferance.stageWidth,StageReferance.stageHeight);
         g.endFill();
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
      
      public function invoke(pkg:PackageIn) : void
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
      
      protected function __mark(event:TimerEvent) : void
      {
         if(_markBar)
         {
            _markBar.setTime(_time - _timer.currentCount);
         }
      }
      
      protected function __markComplete(event:TimerEvent) : void
      {
         var timer:Timer = event.currentTarget as Timer;
         timer.removeEventListener("timerComplete",__markComplete);
         removeEventListener("click",__click);
         complete();
      }
      
      protected function addEvent() : void
      {
         addEventListener("click",__click);
      }
      
      protected function __click(event:MouseEvent) : void
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
         for(var key in _gameLivings)
         {
            delete _gameLivings[key];
         }
         _gameLivings = null;
      }
   }
}
