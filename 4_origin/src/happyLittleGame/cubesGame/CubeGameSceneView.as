package happyLittleGame.cubesGame
{
   import com.greensock.TweenLite;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ClassUtils;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.geom.Point;
   import funnyGames.cubeGame.CubeGameManager;
   import funnyGames.cubeGame.event.CubeGameEvent;
   
   public class CubeGameSceneView extends Sprite implements Disposeable
   {
      
      private static const STAND:String = "stand";
      
      private static const DIE:String = "die";
      
      private static const FIRE:String = "beatA";
      
      private static const FIRE_FRAME:uint = 46;
       
      
      private var _forestMC:MovieClip;
      
      private var _princess:MovieClip;
      
      private var _hero:MovieClip;
      
      private var _frontBg:Bitmap;
      
      private var _cubeContainer:CubeMapView;
      
      private var _effectContainer:CubeEffectView;
      
      private var _infoView:CubeGameInfoView;
      
      private var _miniMap:CubeMinMap;
      
      private var _heroPos:Point;
      
      private var _bullets:Vector.<BulletData>;
      
      public function CubeGameSceneView()
      {
         _bullets = new Vector.<BulletData>();
         super();
         this.initView();
         this.initListener();
      }
      
      private function initView() : void
      {
         this._forestMC = ClassUtils.CreatInstance("asset.cubeGame.forest");
         this.addChild(this._forestMC);
         var _loc1_:Boolean = false;
         this._forestMC.mouseEnabled = _loc1_;
         this._forestMC.mouseChildren = _loc1_;
         this._princess = ClassUtils.CreatInstance("asset.cubeGame.princess");
         this.addChild(this._princess);
         PositionUtils.setPos(this._princess,"cubeGame.princessPos");
         _loc1_ = false;
         this._princess.mouseEnabled = _loc1_;
         this._princess.mouseChildren = _loc1_;
         this._hero = ClassUtils.CreatInstance("asset.cubeGame.hero");
         this.addChild(this._hero);
         PositionUtils.setPos(this._hero,"cubeGame.heroPos");
         _heroPos = ComponentFactory.Instance.creatCustomObject("cubeGame.heroPos");
         _loc1_ = false;
         this._hero.mouseEnabled = _loc1_;
         this._hero.mouseChildren = _loc1_;
         _infoView = new CubeGameInfoView();
         addChild(_infoView);
         this._cubeContainer = new CubeMapView();
         PositionUtils.setPos(this._cubeContainer,"cubeGame.cubeContainerPos");
         this.addChild(this._cubeContainer);
         this._frontBg = ComponentFactory.Instance.creatBitmap("asset.cubeGame.frontBg");
         PositionUtils.setPos(this._frontBg,"cubeGame.frontBgPos");
         this.addChild(this._frontBg);
         _effectContainer = new CubeEffectView();
         addChild(_effectContainer);
      }
      
      private function initListener() : void
      {
         CubeGameManager.getInstance().addEventListener("fire",__onFire);
         CubeGameManager.getInstance().addEventListener("gameResult",__onGameResult);
         CubeGameManager.getInstance().addEventListener("cooldown",__onUpdateNPC);
      }
      
      private function removeListener() : void
      {
         this._hero.removeEventListener("enterFrame",onEnterFrame);
         CubeGameManager.getInstance().removeEventListener("fire",__onFire);
         CubeGameManager.getInstance().removeEventListener("gameResult",__onGameResult);
         CubeGameManager.getInstance().removeEventListener("cooldown",__onUpdateNPC);
      }
      
      private function __onUpdateNPC(param1:CubeGameEvent) : void
      {
         _princess.gotoAndPlay("stand");
         _hero.gotoAndPlay("stand");
         TweenLite.killTweensOf(_hero,false);
         PositionUtils.setPos(this._hero,"cubeGame.heroPos");
      }
      
      private function __onGameResult(param1:CubeGameEvent) : void
      {
         if(param1 && !param1.data)
         {
            _princess.gotoAndPlay("die");
            _hero.gotoAndPlay("die");
            TweenLite.killTweensOf(_hero,false);
            TweenLite.to(_hero,3,{"x":_heroPos.x + 300});
         }
      }
      
      private function __onFire(param1:CubeGameEvent) : void
      {
         if(!param1.data)
         {
            return;
         }
         var _loc2_:MovieClip = ClassUtils.CreatInstance("asset.cubeGame.bullet");
         var _loc3_:BulletData = new BulletData();
         _loc3_.bullet = _loc2_;
         _loc3_.id = param1.data.cubeId;
         _loc3_.destination = param1.data.povit;
         _bullets.push(_loc3_);
         addChild(_loc2_);
         PositionUtils.setPos(_loc2_,"cubeGame.bulletPos");
         bulletFly();
      }
      
      private function bulletFly() : void
      {
         _hero.gotoAndPlay("beatA");
         if(!_hero.hasEventListener("enterFrame"))
         {
            _hero.addEventListener("enterFrame",onEnterFrame);
         }
      }
      
      private function onEnterFrame(param1:Event) : void
      {
         evt = param1;
         if(!_hero && _hero.currentFrame != 46)
         {
            return;
         }
         _hero.removeEventListener("enterFrame",onEnterFrame);
         while(_bullets.length > 0)
         {
            var bulletData:BulletData = _bullets.pop();
            if(bulletData)
            {
               TweenLite.to(bulletData.bullet,0.5,{
                  "x":bulletData.destination.x + _cubeContainer.x,
                  "y":bulletData.destination.y + _cubeContainer.y,
                  "onComplete":function():void
                  {
                     TweenLite.killTweensOf(bulletData.bullet,true);
                     ObjectUtils.disposeObject(bulletData.bullet);
                     bulletData.bullet = null;
                     CubeGameManager.getInstance().dispatchEvent(new CubeGameEvent("destroy",bulletData.id));
                     bulletData = null;
                  }
               });
               SoundManager.instance.play("029");
            }
         }
      }
      
      public function dispose() : void
      {
         removeListener();
         TweenLite.killTweensOf(this,false);
         ObjectUtils.disposeAllChildren(this._cubeContainer);
         this._cubeContainer = null;
         ObjectUtils.disposeAllChildren(_infoView);
         _infoView = null;
         ObjectUtils.disposeAllChildren(_miniMap);
         _miniMap = null;
         ObjectUtils.disposeAllChildren(this);
         this._forestMC = null;
         this._princess = null;
         this._hero = null;
         this._frontBg = null;
      }
   }
}

import flash.display.MovieClip;
import flash.geom.Point;

class BulletData
{
    
   
   public var bullet:MovieClip;
   
   public var destination:Point;
   
   public var id:int;
   
   function BulletData()
   {
      super();
   }
}
