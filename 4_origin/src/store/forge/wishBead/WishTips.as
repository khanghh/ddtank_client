package store.forge.wishBead
{
   import com.greensock.TweenMax;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.ChatManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.SoundManager;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   
   public class WishTips extends Sprite implements Disposeable
   {
      
      public static const BEGIN_Y:int = 130;
       
      
      private var _timer:Timer;
      
      private var _successBit:Bitmap;
      
      private var _failBit:Bitmap;
      
      private var _moveSprite:Sprite;
      
      public var isDisplayerTip:Boolean = true;
      
      public function WishTips()
      {
         super();
         this.mouseChildren = false;
         this.mouseEnabled = false;
         init();
      }
      
      private function init() : void
      {
         _successBit = ComponentFactory.Instance.creatBitmap("store.StoreIISuccessBitAsset");
         _failBit = ComponentFactory.Instance.creatBitmap("store.StoreIIFailBitAsset");
         _moveSprite = new Sprite();
         addChild(_moveSprite);
         _timer = new Timer(7500,1);
         _timer.addEventListener("timerComplete",__timerComplete);
      }
      
      private function createTween(onComplete:Function = null, completeParam:Array = null) : void
      {
         MessageTipManager.getInstance().kill();
         TweenMax.killTweensOf(_moveSprite);
         TweenMax.from(_moveSprite,0.4,{
            "y":130,
            "alpha":0
         });
         TweenMax.to(_moveSprite,0.4,{
            "delay":1.4,
            "y":130 * -1,
            "alpha":0,
            "onComplete":(onComplete == null?removeTips:onComplete),
            "onCompleteParams":completeParam
         });
      }
      
      public function showSuccess(callback:Function) : void
      {
         removeTips();
         if(isDisplayerTip)
         {
            if(!_moveSprite)
            {
               _moveSprite = new Sprite();
               addChild(_moveSprite);
            }
            _moveSprite.addChild(_successBit);
            createTween(callback);
         }
         SoundManager.instance.pauseMusic();
         SoundManager.instance.play("063",false,false);
         _timer.start();
         ChatManager.Instance.sysChatYellow(LanguageMgr.GetTranslation("wishBead.result"));
      }
      
      private function strengthTweenComplete(content:String) : void
      {
         if(content)
         {
            MessageTipManager.getInstance().show(content);
         }
         removeTips();
      }
      
      public function showFail(callback:Function) : void
      {
         removeTips();
         if(isDisplayerTip)
         {
            if(!_moveSprite)
            {
               _moveSprite = new Sprite();
               addChild(_moveSprite);
            }
            _moveSprite.addChild(_failBit);
            createTween(callback);
         }
         SoundManager.instance.pauseMusic();
         SoundManager.instance.play("064",false,false);
         _timer.start();
      }
      
      private function __timerComplete(evt:TimerEvent) : void
      {
         _timer.reset();
         SoundManager.instance.resumeMusic();
         SoundManager.instance.stop("063");
         SoundManager.instance.stop("064");
      }
      
      private function removeTips() : void
      {
         if(_moveSprite && _moveSprite.parent)
         {
            while(_moveSprite.numChildren)
            {
               _moveSprite.removeChildAt(0);
            }
            TweenMax.killTweensOf(_moveSprite);
            _moveSprite.parent.removeChild(_moveSprite);
            _moveSprite = null;
         }
      }
      
      public function dispose() : void
      {
         _timer.removeEventListener("timerComplete",__timerComplete);
         _timer.stop();
         _timer = null;
         TweenMax.killTweensOf(_moveSprite);
         SoundManager.instance.resumeMusic();
         SoundManager.instance.stop("063");
         SoundManager.instance.stop("064");
         removeTips();
         if(_successBit)
         {
            ObjectUtils.disposeObject(_successBit);
         }
         _successBit = null;
         if(_failBit)
         {
            ObjectUtils.disposeObject(_failBit);
         }
         _failBit = null;
         if(_moveSprite)
         {
            ObjectUtils.disposeObject(_moveSprite);
         }
         _moveSprite = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
