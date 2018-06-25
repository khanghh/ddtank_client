package game.animations
{
   import com.pickgliss.utils.ClassUtils;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.geom.Matrix;
   import flash.geom.Point;
   import game.objects.GamePlayer;
   import game.view.GameViewBase;
   import game.view.map.MapView;
   import road7th.math.interpolateNumber;
   
   public class SpellSkillAnimation extends EventDispatcher implements IAnimate
   {
       
      
      private var _begin:Point;
      
      private var _end:Point;
      
      private var _scale:Number;
      
      private var _life:int;
      
      private var _backlist:Array;
      
      private var _finished:Boolean;
      
      private var _player:GamePlayer;
      
      private var _characterCopy:Bitmap;
      
      private var _gameView:GameViewBase;
      
      private var _skill:Sprite;
      
      private var _skillAsset:MovieClip;
      
      private var _effect:ScaleEffect;
      
      private var _skillType:int;
      
      private var map:MapView;
      
      public function SpellSkillAnimation(x:Number, y:Number, stageWidth:Number, stageHeight:Number, mapWidth:Number, mapHeight:Number, player:GamePlayer, gameview:GameViewBase)
      {
         super();
         _scale = 1.5;
         var _minX:Number = -mapWidth * _scale + stageWidth;
         var _minY:Number = -mapHeight * _scale + stageHeight;
         var m:Matrix = new Matrix(_scale,0,0,_scale);
         _end = new Point(x,y);
         _end = m.transformPoint(_end);
         _end.x = stageWidth / 2 - _end.x;
         _end.y = stageHeight / 4 * 3 - _end.y;
         _end.x = _end.x > 0?0:Number(_end.x < _minX?_minX:Number(_end.x));
         _end.y = _end.y > 0?0:Number(_end.y < _minY?_minY:Number(_end.y));
         _player = player;
         _gameView = gameview;
         _life = 0;
         _backlist = [];
         _finished = false;
         _skillType = Math.ceil(Math.random() * 4);
      }
      
      public function get level() : int
      {
         return 2;
      }
      
      public function canAct() : Boolean
      {
         return !_finished;
      }
      
      public function prepare(aniset:AnimationSet) : void
      {
      }
      
      public function canReplace(anit:IAnimate) : Boolean
      {
         return false;
      }
      
      public function cancel() : void
      {
         if(_skill && _skill.parent)
         {
            _skill.parent.removeChild(_skill);
         }
         if(_skillAsset && _skillAsset.parent)
         {
            _skillAsset.parent.removeChild(_skillAsset);
         }
         if(_effect)
         {
            _effect.dispose();
         }
         if(map)
         {
            map.restoreStageTopLiving();
            while(_backlist.length > 0)
            {
               map.setMatrx(_backlist.pop());
            }
            if(map.ground)
            {
               map.ground.alpha = 1;
            }
            if(map.stone)
            {
               map.stone.alpha = 1;
            }
            if(map.sky)
            {
               map.sky.alpha = 1;
            }
            map.showPhysical();
         }
         map = null;
         _player = null;
         _gameView = null;
         _skill = null;
         _skillAsset = null;
         _effect = null;
      }
      
      public function update(movie:MapView) : Boolean
      {
         var a:Number = NaN;
         var tp:* = null;
         var s:Number = NaN;
         var m:* = null;
         var bmd:* = null;
         try
         {
            map = movie;
            _life = Number(_life) + 1;
            if(_skill && _effect)
            {
               _skill.addChild(_effect);
            }
            if(_life == 1)
            {
               _skillAsset = MovieClip(ClassUtils.CreatInstance("asset.game.RadialAsset"));
               map.sky.alpha = 1 - _life / 20;
               map.hidePhysical(_player);
               _gameView.addChildAt(_skillAsset,1);
               map.bringToStageTop(_player);
            }
            else if(_life < 6)
            {
               if(_backlist.length == 0)
               {
                  _begin = new Point(map.x,map.y);
                  _backlist.push(map.transform.matrix.clone());
               }
               map.sky.alpha = 1 - _life / 15;
               tp = Point.interpolate(_end,_begin,(_life - 1) / 5);
               s = interpolateNumber(0,1,1,_scale,(_life - 1) / 5);
               m = new Matrix();
               m.scale(s,s);
               m.translate(tp.x,tp.y);
               map.setMatrx(m);
               _backlist.push(m);
            }
            else if(_life < 15)
            {
               map.sky.alpha = 1 - _life / 15;
            }
            else if(_life == 15)
            {
               map.sky.alpha = 1 - _life / 15;
               if(_skillAsset && _skillAsset.parent)
               {
                  _skillAsset.parent.removeChild(_skillAsset);
               }
               _skill = createSkillCartoon(_skillType);
               var _loc8_:Boolean = false;
               _skill.mouseEnabled = _loc8_;
               _skill.mouseChildren = _loc8_;
               bmd = Math.random() > 0.3?_player.character.charaterWithoutWeapon:_player.character.winCharater;
               _effect = new ScaleEffect(_skillType,bmd);
               _skill.addChild(_effect);
               _skill.scaleX = _player.player.direction;
               _skill.x = _player.player.direction > 0?0:Number(1000);
               _gameView.addChildAt(_skill,1);
            }
            else if(_life == 52)
            {
               map.showPhysical();
            }
            else if(_life > 47)
            {
               if(_backlist.length > 0)
               {
                  map.setMatrx(_backlist.pop());
                  map.sky.alpha = (_life - 47) / 5;
               }
               else
               {
                  cancel();
                  _finished = true;
                  dispatchEvent(new Event("complete"));
               }
            }
         }
         catch(e:Error)
         {
            cancel();
         }
         return true;
      }
      
      private function createSkillCartoon(id:int) : Sprite
      {
         var str:String = "";
         if(id == 2)
         {
            str = "asset.game.specialSkillA" + Math.ceil(Math.random() * 4);
         }
         else
         {
            str = "asset.game.specialSkillB" + Math.ceil(Math.random() * 4);
         }
         return MovieClip(ClassUtils.CreatInstance(str));
      }
      
      public function get finish() : Boolean
      {
         return _finished;
      }
   }
}
