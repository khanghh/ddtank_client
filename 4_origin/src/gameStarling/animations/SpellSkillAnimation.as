package gameStarling.animations
{
   import bones.BoneMovieFactory;
   import bones.display.BoneMovieStarling;
   import com.pickgliss.utils.StarlingObjectUtils;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.geom.Matrix;
   import flash.geom.Point;
   import gameCommon.GameControl;
   import gameStarling.objects.GamePlayer3D;
   import gameStarling.view.GameViewBase3D;
   import gameStarling.view.map.MapView3D;
   import road7th.StarlingMain;
   import road7th.math.interpolateNumber;
   import road7th.utils.BoneMovieWrapper;
   import starling.display.Sprite;
   import starling.events.Event;
   import starling.events.EventDispatcher;
   
   public class SpellSkillAnimation extends EventDispatcher implements IAnimate
   {
       
      
      private var _begin:Point;
      
      private var _end:Point;
      
      private var _scale:Number;
      
      private var _life:int;
      
      private var _backlist:Array;
      
      private var _finished:Boolean;
      
      private var _player:GamePlayer3D;
      
      private var _characterCopy:Bitmap;
      
      private var _gameView:Sprite;
      
      private var _skill:BoneMovieWrapper;
      
      private var _skillAsset:BoneMovieStarling;
      
      private var _effect:ScaleEffect3D;
      
      private var _skillType:int;
      
      private var map:MapView3D;
      
      public function SpellSkillAnimation(x:Number, y:Number, stageWidth:Number, stageHeight:Number, mapWidth:Number, mapHeight:Number, player:GamePlayer3D, gameview:GameViewBase3D)
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
         _gameView = StarlingMain.instance.currentScene;
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
         StarlingObjectUtils.disposeObject(_effect);
         StarlingObjectUtils.disposeObject(_skill);
         StarlingObjectUtils.disposeObject(_skillAsset);
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
            if(map.bg)
            {
               map.bg.visible = false;
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
      
      public function update(movie:MapView3D) : Boolean
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
               _skill.asDisplay.addChild(_effect);
            }
            if(_life == 1)
            {
               _skillAsset = BoneMovieFactory.instance.creatBoneMovie("bonesGameRadialAsset");
               map.bg.visible = true;
               setMapAlpha(1 - _life / 20);
               map.hidePhysical(_player);
               _gameView.addChildAt(_skillAsset,1);
               map.bringToStageTop(_player);
            }
            else if(_life < 6)
            {
               if(_backlist.length == 0)
               {
                  _begin = new Point(map.x,map.y);
                  _backlist.push(map.transformationMatrix.clone());
               }
               setMapAlpha(1 - _life / 15);
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
               setMapAlpha(1 - _life / 15);
            }
            else if(_life == 15)
            {
               setMapAlpha(1 - _life / 15);
               StarlingObjectUtils.removeObject(_skillAsset);
               _skill = new BoneMovieWrapper(createSkillStyleName(),true);
               bmd = Math.random() > 0.3?_player.character.charaterWithoutWeapon:_player.character.winCharater;
               _effect = new ScaleEffect3D(_skillType,bmd);
               _skill.asDisplay.addChild(_effect);
               _skill.asDisplay.scaleX = _player.player.direction;
               _skill.asDisplay.x = _player.player.direction > 0?0:Number(1000);
               _gameView.addChildAt(_skill.asDisplay,1);
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
                  setMapAlpha((_life - 47) / 5);
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
      
      private function setMapAlpha(value:Number) : void
      {
         if(map.bg)
         {
            map.bg.alpha = 1 - value;
         }
      }
      
      private function createSkillStyleName() : String
      {
         var str:String = "bonesGameSpecialSkill" + GameControl.Instance.specialSkillType;
         str = str + Math.ceil(Math.random() * 4);
         return str;
      }
      
      public function get finish() : Boolean
      {
         return _finished;
      }
   }
}
