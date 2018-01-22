package game.objects
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.BallManager;
   import flash.display.MovieClip;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import game.view.map.MapView;
   import phy.object.PhysicalObj;
   import road7th.utils.MovieClipVSplice;
   
   public class GameSceneEffect extends PhysicalObj
   {
       
      
      private var _effectMovie:MovieClipVSplice;
      
      private var _isDispose:Boolean = false;
      
      private var _isDie:Boolean = false;
      
      private var _txt:FilterFrameText;
      
      public function GameSceneEffect(param1:int, param2:Rectangle = null, param3:int = 7, param4:Number = 1, param5:Number = 1, param6:Number = 0, param7:Number = 1)
      {
         super(param1,param3,param4,param5,param6,param7);
         if(param2)
         {
            _testRect = param2;
         }
         _canCollided = true;
         mouseChildren = false;
         mouseEnabled = false;
         _isLiving = false;
         if(_isMoving)
         {
            stopMoving();
         }
         initView();
      }
      
      private function test() : void
      {
         _effectMovie.movie.graphics.beginFill(16711680);
         _effectMovie.movie.graphics.drawRect(_testRect.x,_testRect.y,_testRect.width,_testRect.height);
         _effectMovie.movie.graphics.endFill();
      }
      
      public function initMoving() : void
      {
         _canCollided = true;
         _isLiving = true;
         startMoving();
      }
      
      public function initTxt() : void
      {
         _txt = ComponentFactory.Instance.creatComponentByStylename("ddtcorei.gamesceneEffect.txt");
         _txt.mouseEnabled = false;
         addChild(_txt);
      }
      
      public function updateTxt(param1:Object) : void
      {
         if(_txt)
         {
            _txt.text = param1 + "";
         }
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
         var _movie:MovieClip = BallManager.createSceneEffectMovie(Id);
         var $spacing:Number = 0;
         var spacingMC:MovieClip = _movie.getChildByName("spacingMC") as MovieClip;
         var createNum:int = 1;
         if(spacingMC)
         {
            $spacing = spacingMC.y;
            var mcHeight:Number = spacingMC.z;
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
         var createSceneEffectMovie:Function = function():MovieClip
         {
            return BallManager.createSceneEffectMovie(Id);
         };
         _effectMovie = new MovieClipVSplice(_movie,createNum,$spacing,createSceneEffectMovie);
         addChild(_effectMovie.movie);
      }
      
      public function act(param1:String, param2:Function = null) : void
      {
         action = param1;
         back = param2;
         _effectMovie.doAction(action,function():void
         {
            map.cancelFocus();
            if(back != null)
            {
               back();
            }
         });
         needFocus(0,0,0);
      }
      
      override public function moveTo(param1:Point) : void
      {
         if(!_isDispose)
         {
            super.moveTo(param1);
         }
      }
      
      override public function collidedByObject(param1:PhysicalObj) : void
      {
      }
      
      public function get effectMovie() : MovieClipVSplice
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
      
      public function get map() : MapView
      {
         return _map as MapView;
      }
      
      override public function die() : void
      {
         _effectMovie.doAction("die",dispose);
         _isDie = true;
      }
      
      override public function stopMoving() : void
      {
         super.stopMoving();
         if(_isLiving && _effectMovie)
         {
            _effectMovie.movie.rotation = calcObjectAngle();
         }
      }
      
      public function get isDie() : Boolean
      {
         return _isDie;
      }
      
      override public function dispose() : void
      {
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
            ObjectUtils.disposeObject(_txt);
            _txt = null;
            _testRect = null;
            super.dispose();
            _isDispose = true;
         }
      }
   }
}
