package gameCommon.view
{
   import com.greensock.TweenLite;
   import com.greensock.easing.Sine;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.SoundManager;
   import flash.display.Bitmap;
   import flash.display.DisplayObjectContainer;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.geom.Rectangle;
   import flash.utils.Timer;
   import gameCommon.GameControl;
   import gameCommon.view.smallMap.GameTurnButton;
   
   public class DungeonHelpView extends Sprite implements Disposeable
   {
       
      
      private var _isFirst:Boolean;
      
      protected var _closeBtn:SimpleBitmapButton;
      
      private var _time:Timer;
      
      private var _opened:Boolean;
      
      protected var _container:Sprite;
      
      private var _winTxt1:FilterFrameText;
      
      private var _winTxt2:FilterFrameText;
      
      private var _lostTxt1:FilterFrameText;
      
      private var _lostTxt2:FilterFrameText;
      
      private var _arrow1:Bitmap;
      
      private var _arrow2:Bitmap;
      
      private var _arrow3:Bitmap;
      
      private var _arrow4:Bitmap;
      
      private var _tweened:Boolean = false;
      
      protected var _turnButton:GameTurnButton;
      
      private var _barrier:DungeonInfoView;
      
      private var _gameContainer:DisplayObjectContainer;
      
      protected var _sourceRect:Rectangle;
      
      private var _showed:Boolean = false;
      
      public function DungeonHelpView(param1:GameTurnButton, param2:DungeonInfoView, param3:DisplayObjectContainer)
      {
         super();
         _isFirst = true;
         buttonMode = false;
         mouseEnabled = false;
         _turnButton = param1;
         _barrier = param2;
         _gameContainer = param3;
         _container = new Sprite();
         _container.x = 211;
         _container.y = 65;
         addChild(_container);
         init();
         addEventListener("click",__closeHandler);
         addEventListener("addedToStage",__startEffect);
      }
      
      protected function init() : void
      {
         var _loc1_:Bitmap = ComponentFactory.Instance.creatBitmap("asset.game.missionInfoBG2Asset");
         _container.addChild(_loc1_);
         _winTxt1 = ComponentFactory.Instance.creat("asset.DungeonHelpView.winTxt1");
         _container.addChild(_winTxt1);
         _winTxt2 = ComponentFactory.Instance.creat("asset.DungeonHelpView.winTxt2");
         _container.addChild(_winTxt2);
         _lostTxt1 = ComponentFactory.Instance.creat("asset.DungeonHelpView.lostTxt1");
         _container.addChild(_lostTxt1);
         _lostTxt2 = ComponentFactory.Instance.creat("asset.DungeonHelpView.lostTxt2");
         _container.addChild(_lostTxt2);
         _closeBtn = ComponentFactory.Instance.creat("asset.game.DungeonHelpView.closeBtn");
         _container.addChild(_closeBtn);
         _arrow1 = ComponentFactory.Instance.creat("asset.game.missionHelpArrow2");
         _container.addChild(_arrow1);
         _arrow1.visible = false;
         _arrow2 = ComponentFactory.Instance.creat("asset.game.missionHelpArrow2");
         _container.addChild(_arrow2);
         _arrow2.visible = false;
         _arrow3 = ComponentFactory.Instance.creat("asset.game.missionHelpArrow1");
         _container.addChild(_arrow3);
         _arrow3.visible = false;
         _arrow4 = ComponentFactory.Instance.creat("asset.game.missionHelpArrow1");
         _container.addChild(_arrow4);
         _arrow4.visible = false;
         setText();
         _sourceRect = new Rectangle(0,0,424,132);
         _sourceRect.x = StageReferance.stageWidth - _sourceRect.width >> 1;
         _sourceRect.y = StageReferance.stageHeight - _sourceRect.height >> 1;
      }
      
      private function closeComplete() : void
      {
         TweenLite.killTweensOf(_container,false);
         if(parent)
         {
            parent.removeChild(this);
            if(_isFirst)
            {
               _turnButton.isFirst = false;
               _turnButton.shine();
               _isFirst = false;
            }
         }
      }
      
      private function openComplete() : void
      {
         TweenLite.killTweensOf(_container,false);
      }
      
      public function open() : void
      {
         if(_tweened)
         {
            TweenLite.killTweensOf(_container,true);
         }
         _gameContainer.addChild(this);
         _tweened = true;
         _opened = true;
         TweenLite.to(this,0.3,{
            "x":_sourceRect.x,
            "y":_sourceRect.y,
            "width":_sourceRect.width,
            "height":_sourceRect.height,
            "ease":Sine.easeOut,
            "onComplete":openComplete
         });
      }
      
      public function close(param1:Rectangle) : void
      {
         if(_tweened)
         {
            TweenLite.killTweensOf(this,true);
         }
         _tweened = true;
         _opened = false;
         TweenLite.to(this,0.6,{
            "width":param1.width,
            "height":param1.height,
            "x":param1.x,
            "y":param1.y,
            "ease":Sine.easeIn,
            "onComplete":closeComplete
         });
      }
      
      private function __sleepOrStop() : void
      {
         if(_isFirst)
         {
            _time = new Timer(2000,1);
            _time.addEventListener("timerComplete",__timerComplete);
            _time.start();
            _showed = true;
         }
      }
      
      protected function __timerComplete(param1:TimerEvent) : void
      {
         var _loc2_:* = null;
         if(_turnButton && _gameContainer)
         {
            _loc2_ = _turnButton.getBounds(_gameContainer);
            _loc2_.x = 860;
            _loc2_.y = 5;
         }
         close(_loc2_);
         clearTime();
      }
      
      protected function clearTime() : void
      {
         if(_time)
         {
            _time.removeEventListener("timerComplete",__timerComplete);
            _time.stop();
         }
         _time = null;
      }
      
      private function setText() : void
      {
         var _loc2_:Array = GameControl.Instance.Current.missionInfo.success.split("<br>");
         var _loc1_:Array = GameControl.Instance.Current.missionInfo.failure.split("<br>");
         _winTxt1.text = _loc2_[0];
         _arrow1.y = _winTxt1.y + 5;
         _arrow1.x = _winTxt1.x - 15;
         _arrow1.visible = true;
         if(_loc2_.length >= 2)
         {
            _winTxt2.text = _loc2_[1];
            _winTxt2.y = _winTxt1.y + _winTxt1.textHeight + 25;
            _arrow2.y = _winTxt2.y + 5;
            _arrow2.x = _winTxt2.x - 15;
            _arrow2.visible = true;
         }
         else
         {
            _arrow2.visible = false;
         }
         _lostTxt1.text = _loc1_[0];
         _arrow3.y = _lostTxt1.y + 5;
         _arrow3.x = _lostTxt1.x - 15;
         _arrow3.visible = true;
         if(_loc1_.length >= 2)
         {
            _lostTxt2.text = _loc1_[1];
            _lostTxt2.y = _lostTxt1.y + _lostTxt1.textHeight + 25;
            _arrow4.y = _lostTxt2.y + 5;
            _arrow4.x = _lostTxt2.x - 15;
            _arrow4.visible = true;
         }
         else
         {
            _arrow4.visible = false;
         }
      }
      
      public function defaultClose() : void
      {
      }
      
      public function dispose() : void
      {
         clearTime();
         if(_tweened)
         {
            TweenLite.killTweensOf(_container);
         }
         if(_closeBtn)
         {
            _closeBtn.removeEventListener("click",__closeHandler);
            ObjectUtils.disposeObject(_closeBtn);
            _closeBtn = null;
         }
         removeEventListener("click",__closeHandler);
         ObjectUtils.disposeAllChildren(_container);
         ObjectUtils.disposeObject(_container);
         _container = null;
         _winTxt1 = null;
         _winTxt2 = null;
         _lostTxt1 = null;
         _lostTxt2 = null;
         _arrow1 = null;
         _arrow2 = null;
         _arrow3 = null;
         _arrow4 = null;
         _turnButton = null;
         if(_barrier)
         {
            _barrier.dispose();
         }
         _barrier = null;
         _gameContainer = null;
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
      
      private function __startEffect(param1:Event) : void
      {
         _opened = true;
         x = StageReferance.stageWidth >> 1;
         y = StageReferance.stageHeight >> 1;
         width = 1;
         height = 1;
         TweenLite.to(this,1,{
            "x":_sourceRect.x,
            "y":_sourceRect.y,
            "width":_sourceRect.width,
            "height":_sourceRect.height,
            "ease":Sine.easeOut,
            "onComplete":__sleepOrStop
         });
      }
      
      protected function __closeHandler(param1:MouseEvent) : void
      {
         var _loc2_:* = null;
         SoundManager.instance.play("008");
         if(_isFirst)
         {
            close(new Rectangle(1000,0,2,2));
         }
         else
         {
            _loc2_ = _barrier.getBounds(_gameContainer);
            var _loc3_:int = 1;
            _loc2_.height = _loc3_;
            _loc2_.width = _loc3_;
            close(_loc2_);
         }
         StageReferance.stage.focus = null;
      }
      
      public function get opened() : Boolean
      {
         return _opened;
      }
      
      public function get showed() : Boolean
      {
         return _showed;
      }
   }
}
