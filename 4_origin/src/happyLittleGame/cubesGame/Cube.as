package happyLittleGame.cubesGame
{
   import com.greensock.TweenLite;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.NumberImage;
   import com.pickgliss.utils.ClassUtils;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.SoundManager;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import funnyGames.cubeGame.CubeGameManager;
   import funnyGames.cubeGame.event.CubeGameEvent;
   
   public class Cube extends Sprite implements Disposeable
   {
      
      public static const WIDTH_SPACE:uint = 41;
      
      public static const HEIGH_SPACE:uint = 42;
      
      private static const _TWEEN_TIME:Number = 0.3;
      
      private static const _DELAY_TIME:Number = 0.6;
       
      
      private var _id:int;
      
      private var _type:uint;
      
      public var yPos:int;
      
      private var _score:uint;
      
      private var _hitEffect:MovieClip;
      
      private var _exploreEffect:MovieClip;
      
      private var _numsImg:NumberImage;
      
      private var _bg:Bitmap;
      
      public function Cube(param1:int, param2:uint)
      {
         super();
         _id = param1;
         _type = param2;
         initView();
         initListener();
      }
      
      private function initListener() : void
      {
         this.addEventListener("click",__onClick);
         CubeGameManager.getInstance().addEventListener("destroy",__onCollide);
      }
      
      private function removeListener() : void
      {
         this.removeEventListener("click",__onClick);
         if(_exploreEffect)
         {
            _exploreEffect.removeEventListener("enterFrame",__onExplore);
         }
         CubeGameManager.getInstance().removeEventListener("destroy",__onCollide);
      }
      
      private function __onClick(param1:MouseEvent) : void
      {
         if(!CubeGameManager.getInstance().status)
         {
            return;
         }
         CubeGameManager.getInstance().dispatchEvent(new CubeGameEvent("fire",{
            "cubeId":_id,
            "povit":povit
         }));
      }
      
      private function __onCollide(param1:CubeGameEvent) : void
      {
         if(!param1 || param1.data != this._id)
         {
            return;
         }
         _hitEffect = ClassUtils.CreatInstance("asset.cubeGame.hitEffect");
         var _loc2_:int = 32;
         _hitEffect.y = _loc2_;
         _hitEffect.x = _loc2_;
         _hitEffect.mouseEnabled = false;
         _hitEffect.visible = false;
         addChild(_hitEffect);
         _hitEffect.visible = true;
         _hitEffect.play();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatBitmap("asset.CubeGame." + _type);
         addChild(_bg);
         _numsImg = ComponentFactory.Instance.creatComponentByStylename("cubeMapView.numbers");
         _numsImg.x = 11;
         _numsImg.y = 20;
         _numsImg.space = -3;
         addChild(_numsImg);
      }
      
      public function get povit() : Point
      {
         return new Point(this.parent.x + this.x + (41 >> 1),this.y + (42 >> 1));
      }
      
      public function set score(param1:uint) : void
      {
         _score = param1;
      }
      
      public function die() : void
      {
         if(_hitEffect)
         {
            _hitEffect.visible = false;
            _hitEffect.stop();
         }
         _exploreEffect = ClassUtils.CreatInstance("asset.cubeGame.exploreEffect");
         _exploreEffect.mouseEnabled = false;
         var _loc1_:int = 32;
         _exploreEffect.y = _loc1_;
         _exploreEffect.x = _loc1_;
         addChild(_exploreEffect);
         _exploreEffect.visible = true;
         _exploreEffect.play();
         _exploreEffect.addEventListener("enterFrame",__onExplore);
         SoundManager.instance.play("089");
      }
      
      private function __onExplore(param1:Event) : void
      {
         evt = param1;
         if(!evt || _exploreEffect.currentFrame != _exploreEffect.totalFrames)
         {
            return;
         }
         _exploreEffect.removeEventListener("enterFrame",__onExplore);
         if(_score == 0)
         {
            dispose();
         }
         else
         {
            _bg.visible = false;
            _exploreEffect.stop();
            TweenLite.killTweensOf(_numsImg,false);
            if(_score.toString().length < 4)
            {
               _numsImg.x = _numsImg.x - (_score.toString().length - 3) * 16;
            }
            _numsImg.count = _score;
            TweenLite.killTweensOf(_numsImg,true);
            TweenLite.to(_numsImg,0.1,{
               "alpha":0,
               "delay":0.5,
               "onComplete":function():void
               {
                  dispose();
               }
            });
         }
      }
      
      public function fall() : void
      {
         TweenLite.killTweensOf(this,false);
         TweenLite.to(this,0.3,{
            "y":yPos,
            "delay":0.6
         });
      }
      
      public function dispose() : void
      {
         removeListener();
         TweenLite.killTweensOf(this,false);
         TweenLite.killTweensOf(_numsImg,false);
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
         _exploreEffect = null;
         _hitEffect = null;
         _bg = null;
         ObjectUtils.disposeAllChildren(_numsImg);
         _numsImg = null;
      }
      
      public function get id() : int
      {
         return _id;
      }
   }
}
