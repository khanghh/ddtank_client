package moneyTree.view
{
   import com.greensock.TweenMax;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.events.CEvent;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import ddt.view.tips.MultipleLineTip;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import moneyTree.MoneyTreeManager;
   
   public class Fruit extends Sprite implements Disposeable
   {
       
      
      private var _index:int;
      
      private var _tip:MultipleLineTip;
      
      protected var _title:Bitmap;
      
      protected var _normalBmp:Bitmap;
      
      protected var _grownMC:MovieClip;
      
      protected var _pickMC:MovieClip;
      
      protected var _countDown:CountDownBoard;
      
      private var _manager:MoneyTreeManager;
      
      private var _onComplete:Function;
      
      public function Fruit(index:int)
      {
         super();
         _index = index;
         this.useHandCursor = true;
         this.buttonMode = true;
         var factory:ComponentFactory = ComponentFactory.Instance;
         _normalBmp = factory.creatBitmap("moneyTree.fruit" + index + ".normal");
         addChild(_normalBmp);
         _grownMC = factory.creat("moneyTree.fruit" + index + ".grown");
         _grownMC.gotoAndStop(1);
         _pickMC = factory.creat("moneyTree.fruit" + index + ".pick");
         _pickMC.gotoAndStop(1);
         _countDown = new CountDownBoard(index,factory.creatBitmap("moneyTree.fruit" + index + ".title"));
         _countDown.x = 53;
         _countDown.y = 3;
         addChild(_countDown);
         if(_index == 1)
         {
            _countDown.x = 51;
            _countDown.y = 5;
         }
         else if(_index == 2)
         {
            _countDown.x = -116;
            _countDown.y = 4;
         }
         else if(_index == 3)
         {
            _countDown.x = 49;
            _countDown.y = 24;
         }
         _tip = new MultipleLineTip();
         _tip.tipData = LanguageMgr.GetTranslation("moneyTree.fruit.tip").toString().split("|")[index].toString();
         PositionUtils.setPos(_tip,"moneyTree.fruit" + index.toString() + ".Tippos");
         _tip.visible = false;
         addChildAt(_tip,1);
         this.addEventListener("click",onClick);
         this.addEventListener("mouseOver",__showTip);
         this.addEventListener("mouseOut",__hideTip);
         _manager = MoneyTreeManager.getInstance();
         _manager.addEventListener("mt_update_timer",updateTime);
      }
      
      public function get index() : int
      {
         return _index;
      }
      
      private function __showTip(e:MouseEvent) : void
      {
         _tip.visible = true;
      }
      
      private function __hideTip(e:MouseEvent) : void
      {
         _tip.visible = false;
      }
      
      protected function onClick(e:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         this.removeEventListener("click",onClick);
         MoneyTreeManager.getInstance().pick(_index);
         TweenMax.delayedCall(2,addListener);
      }
      
      private function addListener() : void
      {
         this.addEventListener("click",onClick);
      }
      
      protected function updateTime(e:CEvent) : void
      {
         if(_pickMC.hasEventListener("enterFrame"))
         {
            return;
         }
         _countDown.updateTime(MoneyTreeManager.getInstance().model.getCountDownString(_index));
      }
      
      public function showGrown() : void
      {
         if(_pickMC.hasEventListener("enterFrame"))
         {
            _onComplete = showGrown;
            return;
         }
         _normalBmp.parent && removeChild(_normalBmp);
         _pickMC.parent && _pickMC.stop();
         addChild(_grownMC);
         _grownMC.gotoAndPlay(1);
      }
      
      public function showNormal() : void
      {
         if(_pickMC.hasEventListener("enterFrame"))
         {
            _onComplete = showNormal;
            return;
         }
         _grownMC.parent && _grownMC.stop();
         _pickMC.parent && _pickMC.stop();
         addChild(_normalBmp);
      }
      
      public function showPick() : void
      {
         _pickMC.addEventListener("enterFrame",onPickEF);
         _normalBmp.parent && removeChild(_normalBmp);
         _grownMC.parent && _grownMC.stop();
         addChild(_pickMC);
         _pickMC.gotoAndPlay(1);
      }
      
      protected function onPickEF(e:Event) : void
      {
         if(_pickMC == null)
         {
            return;
         }
         if(_pickMC.currentFrame == _pickMC.totalFrames)
         {
            _pickMC.removeEventListener("enterFrame",onPickEF);
            _onComplete && _onComplete();
            _countDown.updateTime(MoneyTreeManager.getInstance().model.getCountDownString(_index));
         }
      }
      
      private function showDelay(onComplete:Function) : void
      {
         _onComplete = onComplete;
      }
      
      public function dispose() : void
      {
         TweenMax.killDelayedCallsTo(this);
         _pickMC.removeEventListener("enterFrame",onPickEF);
         this.removeEventListener("click",onClick);
         this.removeEventListener("mouseOver",__showTip);
         this.removeEventListener("mouseOut",__hideTip);
         _manager.removeEventListener("mt_update_timer",updateTime);
         _manager = null;
         _countDown.dispose();
         if(_normalBmp != null)
         {
            ObjectUtils.disposeObject(_normalBmp);
            _normalBmp = null;
         }
         if(_pickMC != null)
         {
            ObjectUtils.disposeObject(_pickMC);
            _pickMC = null;
         }
         if(_grownMC != null)
         {
            ObjectUtils.disposeObject(_grownMC);
            _grownMC = null;
         }
         if(_title != null)
         {
            ObjectUtils.disposeObject(_title);
            _title = null;
         }
      }
   }
}
