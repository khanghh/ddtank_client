package happyLittleGame.cubesGame
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.SoundManager;
   import flash.display.Sprite;
   import flash.geom.Point;
   import funnyGames.cubeGame.CubeGameManager;
   import funnyGames.cubeGame.data.CubeData;
   import funnyGames.cubeGame.event.CubeGameEvent;
   
   public class CubeMapView extends Sprite implements Disposeable
   {
       
      
      private var _cubeColumns:Vector.<CubeColumn>;
      
      private var _scoreFloatEffects:Vector.<ScoreFloatEffect>;
      
      public function CubeMapView()
      {
         _cubeColumns = new Vector.<CubeColumn>();
         _scoreFloatEffects = new Vector.<ScoreFloatEffect>();
         super();
         initView();
         this.initListeners();
      }
      
      private function initView() : void
      {
         var _loc3_:* = 0;
         var _loc2_:* = null;
         var _loc1_:* = null;
         _loc3_ = uint(0);
         while(_loc3_ < CubeGameManager.getInstance().gameInfo.column)
         {
            _loc2_ = new ScoreFloatEffect();
            _loc1_ = ComponentFactory.Instance.creatCustomObject("cubeGame.cubeContainer.scoreStartPos");
            _loc1_.x = _loc3_ * 41 + 41 / 2;
            _loc2_.x = _loc1_.x;
            _loc2_.y = _loc1_.y;
            _loc2_.startPosition = _loc1_;
            _scoreFloatEffects.push(_loc2_);
            _loc3_++;
         }
      }
      
      private function initListeners() : void
      {
         CubeGameManager.getInstance().addEventListener("gameStart",__onStartGame);
         CubeGameManager.getInstance().addEventListener("cubeGenerate",__onGenerateColumn);
         CubeGameManager.getInstance().addEventListener("cubeRandom",__onRandomCube);
         CubeGameManager.getInstance().addEventListener("destroy",__onDestroy);
         CubeGameManager.getInstance().addEventListener("cubeDeath",__onDeath);
         CubeGameManager.getInstance().addEventListener("clearMap",__onClearMap);
         CubeGameManager.getInstance().addEventListener("gameResult",__onGameResult);
      }
      
      private function removeListeners() : void
      {
         CubeGameManager.getInstance().removeEventListener("gameStart",__onStartGame);
         CubeGameManager.getInstance().removeEventListener("cubeGenerate",__onGenerateColumn);
         CubeGameManager.getInstance().removeEventListener("cubeRandom",__onRandomCube);
         CubeGameManager.getInstance().removeEventListener("destroy",__onDestroy);
         CubeGameManager.getInstance().removeEventListener("cubeDeath",__onDeath);
         CubeGameManager.getInstance().removeEventListener("clearMap",__onClearMap);
         CubeGameManager.getInstance().removeEventListener("gameResult",__onGameResult);
      }
      
      private function __onGameResult(param1:CubeGameEvent) : void
      {
         if(!param1 || !param1.data)
         {
            return;
         }
         showScoreFloatEffect();
      }
      
      private function showScoreFloatEffect() : void
      {
         var _loc2_:* = 0;
         var _loc1_:* = null;
         _loc2_ = uint(0);
         while(_loc2_ < _scoreFloatEffects.length)
         {
            _loc1_ = _scoreFloatEffects[_loc2_];
            if(checkCondition(_loc1_.x))
            {
               addChild(_loc1_);
               _loc1_.show();
            }
            _loc2_++;
         }
      }
      
      private function checkCondition(param1:int) : Boolean
      {
         var _loc3_:* = 0;
         var _loc2_:* = null;
         _loc3_ = uint(0);
         while(_loc3_ < _cubeColumns.length)
         {
            _loc2_ = _cubeColumns[_loc3_];
            if(!_loc2_.empty && _loc2_.x < param1 && param1 < _loc2_.x + 41)
            {
               return false;
            }
            _loc3_++;
         }
         return true;
      }
      
      private function __onStartGame(param1:CubeGameEvent) : void
      {
         var _loc3_:* = 0;
         var _loc2_:* = null;
         _loc3_ = uint(0);
         while(_loc3_ < _scoreFloatEffects.length)
         {
            _loc2_ = _scoreFloatEffects[_loc3_];
            if(_loc2_.parent)
            {
               _loc2_.parent.removeChild(_loc2_);
            }
            _loc3_++;
         }
         clear();
         addCubeColumn(param1.data as Vector.<CubeData>);
      }
      
      private function __onGenerateColumn(param1:CubeGameEvent) : void
      {
         addCubeColumn(param1.data as Vector.<CubeData>);
      }
      
      private function addCubeColumn(param1:Vector.<CubeData>) : void
      {
         if(!param1 || param1.length == 0)
         {
            return;
         }
         var _loc2_:CubeColumn = new CubeColumn();
         _loc2_.data = param1;
         _loc2_.x = -41;
         _cubeColumns.push(_loc2_);
         addChild(_loc2_);
         moveCubeColumns();
      }
      
      private function __onRandomCube(param1:CubeGameEvent) : void
      {
         var _loc3_:CubeData = param1.data.cubeData as CubeData;
         var _loc2_:uint = param1.data.column as uint;
         if(_loc2_ >= _cubeColumns.length)
         {
            return;
         }
         var _loc4_:CubeColumn = _cubeColumns[_loc2_];
         if(!_loc4_)
         {
            return;
         }
         _loc4_.addCube(_loc3_);
      }
      
      private function moveCubeColumns() : void
      {
         var _loc4_:* = 0;
         var _loc2_:* = null;
         var _loc1_:Boolean = false;
         var _loc3_:* = 0;
         SoundManager.instance.play("220");
         _loc4_ = uint(0);
         while(_loc4_ < _cubeColumns.length)
         {
            _loc2_ = _cubeColumns[_loc4_];
            if(_loc2_)
            {
               _loc1_ = false;
               _loc3_ = uint(_loc4_ + 1);
               while(_loc3_ < _cubeColumns.length)
               {
                  if(_cubeColumns[_loc3_].empty)
                  {
                     _loc1_ = true;
                     break;
                  }
                  _loc3_++;
               }
               if(!_loc1_)
               {
                  if(_loc2_.empty)
                  {
                     _cubeColumns.splice(_loc4_,1);
                     _loc4_--;
                     if(_loc2_.parent)
                     {
                        _loc2_.parent.removeChild(_loc2_);
                     }
                  }
                  else
                  {
                     _loc2_.move();
                  }
               }
            }
            _loc4_++;
         }
      }
      
      private function __onDestroy(param1:CubeGameEvent) : void
      {
         CubeGameManager.getInstance().resquestDeleteCube(param1.data as int);
      }
      
      private function __onDeath(param1:CubeGameEvent) : void
      {
         var _loc4_:* = 0;
         var _loc3_:* = null;
         var _loc2_:Vector.<Object> = param1.data as Vector.<Object>;
         if(!_loc2_ || _loc2_.length == 0)
         {
            return;
         }
         _loc4_ = uint(0);
         while(_loc4_ < _cubeColumns.length)
         {
            _loc3_ = _cubeColumns[_loc4_];
            if(_loc3_)
            {
               _loc3_.deleteCubes(_loc2_);
            }
            _loc4_++;
         }
      }
      
      private function __onClearMap(param1:CubeGameEvent) : void
      {
         clear();
      }
      
      private function clear() : void
      {
         var _loc1_:* = null;
         while(_cubeColumns.length > 0)
         {
            _loc1_ = _cubeColumns.pop();
            if(_loc1_)
            {
               _loc1_.clear();
               if(_loc1_.parent)
               {
                  _loc1_.parent.removeChild(_loc1_);
               }
               ObjectUtils.disposeAllChildren(_loc1_);
            }
         }
      }
      
      public function dispose() : void
      {
         var _loc1_:* = null;
         removeListeners();
         clear();
         _cubeColumns = null;
         while(_scoreFloatEffects.length > 0)
         {
            _loc1_ = _scoreFloatEffects.pop();
            ObjectUtils.disposeObject(_loc1_);
         }
         ObjectUtils.disposeAllChildren(this);
      }
   }
}

import com.greensock.TweenLite;
import com.pickgliss.ui.core.Disposeable;
import flash.display.Sprite;
import funnyGames.cubeGame.CubeGameManager;
import funnyGames.cubeGame.data.CubeData;
import happyLittleGame.cubesGame.Cube;

class CubeColumn extends Sprite implements Disposeable
{
   
   private static const _TWEEN_TIME:Number = 0.3;
    
   
   private var _cubes:Vector.<Cube>;
   
   function CubeColumn()
   {
      _cubes = new Vector.<Cube>();
      super();
   }
   
   public function set data(param1:Vector.<CubeData>) : void
   {
      var _loc4_:int = 0;
      var _loc2_:* = null;
      var _loc3_:* = null;
      _loc4_ = param1.length - 1;
      while(_loc4_ >= 0)
      {
         _loc2_ = param1[_loc4_];
         if(_loc2_)
         {
            _loc3_ = new Cube(_loc2_.id,_loc2_.type);
            _loc3_.y = 42 * _loc4_;
            _loc3_.yPos = _loc3_.y;
            _cubes.push(_loc3_);
            addChild(_loc3_);
         }
         _loc4_--;
      }
   }
   
   public function clear() : void
   {
      var _loc1_:* = null;
      while(_cubes.length > 0)
      {
         _loc1_ = _cubes.pop();
         if(_loc1_)
         {
            _loc1_.dispose();
            if(_loc1_.parent)
            {
               _loc1_.parent.removeChild(_loc1_);
            }
         }
      }
   }
   
   public function addCube(param1:CubeData) : void
   {
      var _loc2_:Cube = new Cube(param1.id,param1.type);
      addChild(_loc2_);
      _loc2_.yPos = (CubeGameManager.getInstance().gameInfo.row - _cubes.length - 1) * 42;
      _loc2_.fall();
      _cubes.push(_loc2_);
   }
   
   public function deleteCubes(param1:Vector.<Object>) : void
   {
      ids = param1;
      var deathCubes:Vector.<Cube> = new Vector.<Cube>();
      var i:uint = 0;
      while(i < ids.length)
      {
         var cube:Cube = getCube(ids[i].id);
         if(cube)
         {
            deathCubes.push(cube);
            cube.score = ids[i].score;
         }
         i = i + 1;
      }
      if(deathCubes.length == 0)
      {
         return;
      }
      deathCubes = deathCubes.sort(function(param1:Cube, param2:Cube):int
      {
         if(param1.y < param2.y)
         {
            return 1;
         }
         if(param1.y > param2.y)
         {
            return -1;
         }
         return 0;
      });
      var j:uint = 0;
      while(j < deathCubes.length)
      {
         var deathCube:Cube = deathCubes[j];
         var k:uint = 0;
         while(k < _cubes.length)
         {
            var curCube:Cube = _cubes[k];
            if(!(!curCube || curCube.y >= deathCube.y))
            {
               curCube.yPos = curCube.yPos + 42;
               curCube.fall();
            }
            k = k + 1;
         }
         deleteCube(deathCube.id);
         j = j + 1;
      }
   }
   
   private function deleteCube(param1:int) : void
   {
      var _loc3_:* = 0;
      var _loc2_:* = null;
      _loc3_ = uint(0);
      while(_loc3_ < _cubes.length)
      {
         _loc2_ = _cubes[_loc3_];
         if(_loc2_.id == param1)
         {
            _cubes.splice(_loc3_,1);
            _loc2_.die();
            break;
         }
         _loc3_++;
      }
   }
   
   private function getCube(param1:int) : Cube
   {
      var _loc3_:* = 0;
      var _loc2_:* = null;
      _loc3_ = uint(0);
      while(_loc3_ < _cubes.length)
      {
         _loc2_ = _cubes[_loc3_];
         if(_loc2_ && _loc2_.id == param1)
         {
            return _loc2_;
         }
         _loc3_++;
      }
      return null;
   }
   
   public function move() : void
   {
      TweenLite.killTweensOf(this,false);
      TweenLite.to(this,0.3,{"x":x + 41});
   }
   
   public function get empty() : Boolean
   {
      return _cubes.length == 0;
   }
   
   public function dispose() : void
   {
      TweenLite.killTweensOf(this,false);
      clear();
   }
}

import com.greensock.TweenLite;
import com.greensock.easing.Sine;
import com.pickgliss.ui.ComponentFactory;
import com.pickgliss.ui.core.Disposeable;
import com.pickgliss.ui.image.NumberImage;
import com.pickgliss.utils.ObjectUtils;
import flash.display.DisplayObject;
import flash.display.Sprite;
import flash.geom.Point;
import funnyGames.cubeGame.CubeGameManager;

class ScoreFloatEffect extends Sprite implements Disposeable
{
    
   
   private var _startPos:Point;
   
   function ScoreFloatEffect()
   {
      super();
      initView();
      alpha = 0;
   }
   
   private function initView() : void
   {
      var _loc1_:NumberImage = ComponentFactory.Instance.creatComponentByStylename("cubeMapView.numbers");
      addChild(_loc1_);
      _loc1_.space = -4;
      _loc1_.count = CubeGameManager.getInstance().gameInfo.emptyColumnScore;
   }
   
   public function show() : void
   {
      TweenLite.killTweensOf(this,false);
      this.x = _startPos.x;
      this.y = _startPos.y;
      var endPos:Point = ComponentFactory.Instance.creatCustomObject("cubeGame.cubeContainer.scoreEndPos");
      TweenLite.to(this,0.5,{
         "y":y - 100,
         "alpha":1,
         "onCompleteParams":[this],
         "onComplete":function(param1:DisplayObject):void
         {
            target = param1;
            TweenLite.killTweensOf(this,false);
            TweenLite.to(target,1,{
               "x":endPos.x,
               "y":endPos.y,
               "alpha":0,
               "ease":Sine.easeIn,
               "delay":1,
               "onCompleteParams":[target],
               "onComplete":function(param1:DisplayObject):void
               {
                  param1.x = _startPos.x;
                  param1.y = _startPos.y;
               }
            });
         }
      });
   }
   
   public function set startPosition(param1:Point) : void
   {
      _startPos = param1;
   }
   
   public function dispose() : void
   {
      ObjectUtils.disposeAllChildren(this);
   }
}
