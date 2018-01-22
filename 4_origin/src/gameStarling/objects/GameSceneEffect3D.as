package gameStarling.objects
{
   import bones.display.BoneMovieStarling;
   import bones.display.IBoneMovie;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.StarlingObjectUtils;
   import ddt.manager.BallManager;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import gameStarling.view.map.MapView3D;
   import road7th.utils.BoneMovieVSplice;
   import starlingPhy.object.PhysicalObj3D;
   import starlingui.core.text.TextLabel;
   
   public class GameSceneEffect3D extends PhysicalObj3D
   {
       
      
      private var _effectMovie:BoneMovieVSplice;
      
      private var _isDispose:Boolean = false;
      
      private var _isDie:Boolean = false;
      
      private var _txt:TextLabel;
      
      private var _backFun:Function;
      
      public function GameSceneEffect3D(param1:int, param2:Rectangle = null, param3:int = 7, param4:Number = 1, param5:Number = 1, param6:Number = 0, param7:Number = 1)
      {
         super(param1,param3,param4,param5,param6,param7);
         if(param2)
         {
            _testRect = param2;
         }
         _canCollided = true;
         touchable = false;
         _isLiving = false;
         if(_isMoving)
         {
            stopMoving();
         }
         initView();
      }
      
      public function initMoving() : void
      {
         _canCollided = true;
         _isLiving = true;
         startMoving();
      }
      
      public function updateTxt(param1:Object) : void
      {
         var _loc2_:String = param1 + "";
         if(_txt && _txt.text == _loc2_)
         {
            return;
         }
         if(_txt == null)
         {
            _txt = new TextLabel("ddtcorei.gamesceneEffect.txt");
            addChild(_txt);
         }
         _txt.text = _loc2_;
      }
      
      override public function get layer() : int
      {
         return _layerType;
      }
      
      override public function get layerType() : int
      {
         return 7;
      }
      
      private function initView() : void
      {
         var movie:BoneMovieStarling = BallManager.createSceneEffectMovieBone(Id) as BoneMovieStarling;
         var $spacing:Number = 0;
         var mcHeight:Number = 0;
         var createNum:int = 1;
         if(Id == -104)
         {
            $spacing = -200;
            mcHeight = 500;
         }
         if(mcHeight != 0)
         {
            if(mcHeight < _testRect.height)
            {
               var maxH:Number = _testRect.height;
               if(maxH != 0)
               {
                  createNum = Math.ceil(maxH / (mcHeight + $spacing));
               }
               if(createNum < 1)
               {
                  createNum = 1;
               }
            }
         }
         var createSceneEffectMovie:Function = function():IBoneMovie
         {
            return BallManager.createSceneEffectMovieBone(Id);
         };
         _effectMovie = new BoneMovieVSplice(movie,createNum,$spacing,createSceneEffectMovie);
         addChild(_effectMovie.movie);
      }
      
      public function act(param1:String, param2:Function = null) : void
      {
         action = param1;
         back = param2;
         _effectMovie.playAction(action,function():void
         {
            map.cancelFocus();
            if(back != null)
            {
               back();
            }
         });
         needFocus(0,0,0);
      }
      
      public function set bombBackFun(param1:Function) : void
      {
         _backFun = param1;
      }
      
      override public function moveTo(param1:Point) : void
      {
         if(!_isDispose)
         {
            super.moveTo(param1);
         }
      }
      
      override public function collidedByObject(param1:PhysicalObj3D) : void
      {
      }
      
      public function get effectMovie() : BoneMovieVSplice
      {
         return _effectMovie;
      }
      
      public function needFocus(param1:int = 0, param2:int = 0, param3:Object = null) : void
      {
         if(map)
         {
            map.livingSetCenter(x + param1,y + param2 - 150,true,2,param3);
         }
      }
      
      public function get map() : MapView3D
      {
         return _map as MapView3D;
      }
      
      override public function die() : void
      {
         _effectMovie.playAction("die",dispose);
         _isDie = true;
      }
      
      override public function stopMoving() : void
      {
         super.stopMoving();
         if(_isLiving && _effectMovie)
         {
            _effectMovie.movie.angle = calcObjectAngle();
         }
      }
      
      public function get isDie() : Boolean
      {
         return _isDie;
      }
      
      override public function dispose() : void
      {
         stopMoving();
         if(!_isDispose)
         {
            if(_map)
            {
               _map.removePhysical(this);
            }
            if(parent)
            {
               parent.removeChild(this);
            }
            ObjectUtils.disposeObject(_effectMovie);
            _effectMovie = null;
            StarlingObjectUtils.disposeObject(_txt);
            _txt = null;
            _testRect = null;
            super.dispose();
            _isDispose = true;
            if(_backFun != null)
            {
               _backFun();
            }
            _backFun = null;
         }
      }
   }
}
