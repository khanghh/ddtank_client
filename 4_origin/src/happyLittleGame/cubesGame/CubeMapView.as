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
         var i:* = 0;
         var scoreFloatEffect:* = null;
         var startPos:* = null;
         for(i = uint(0); i < CubeGameManager.getInstance().gameInfo.column; )
         {
            scoreFloatEffect = new ScoreFloatEffect();
            startPos = ComponentFactory.Instance.creatCustomObject("cubeGame.cubeContainer.scoreStartPos");
            startPos.x = i * 41 + 41 / 2;
            scoreFloatEffect.x = startPos.x;
            scoreFloatEffect.y = startPos.y;
            scoreFloatEffect.startPosition = startPos;
            _scoreFloatEffects.push(scoreFloatEffect);
            i++;
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
      
      private function __onGameResult(evt:CubeGameEvent) : void
      {
         if(!evt || !evt.data)
         {
            return;
         }
         showScoreFloatEffect();
      }
      
      private function showScoreFloatEffect() : void
      {
         var i:* = 0;
         var scoreFloatEffect:* = null;
         for(i = uint(0); i < _scoreFloatEffects.length; )
         {
            scoreFloatEffect = _scoreFloatEffects[i];
            if(checkCondition(scoreFloatEffect.x))
            {
               addChild(scoreFloatEffect);
               scoreFloatEffect.show();
            }
            i++;
         }
      }
      
      private function checkCondition(x:int) : Boolean
      {
         var i:* = 0;
         var cubeColumn:* = null;
         for(i = uint(0); i < _cubeColumns.length; )
         {
            cubeColumn = _cubeColumns[i];
            if(!cubeColumn.empty && cubeColumn.x < x && x < cubeColumn.x + 41)
            {
               return false;
            }
            i++;
         }
         return true;
      }
      
      private function __onStartGame(evt:CubeGameEvent) : void
      {
         var i:* = 0;
         var scoreFloatEffect:* = null;
         for(i = uint(0); i < _scoreFloatEffects.length; )
         {
            scoreFloatEffect = _scoreFloatEffects[i];
            if(scoreFloatEffect.parent)
            {
               scoreFloatEffect.parent.removeChild(scoreFloatEffect);
            }
            i++;
         }
         clear();
         addCubeColumn(evt.data as Vector.<CubeData>);
      }
      
      private function __onGenerateColumn(evt:CubeGameEvent) : void
      {
         addCubeColumn(evt.data as Vector.<CubeData>);
      }
      
      private function addCubeColumn(cubeDataList:Vector.<CubeData>) : void
      {
         if(!cubeDataList || cubeDataList.length == 0)
         {
            return;
         }
         var cubeColumn:CubeColumn = new CubeColumn();
         cubeColumn.data = cubeDataList;
         cubeColumn.x = -41;
         _cubeColumns.push(cubeColumn);
         addChild(cubeColumn);
         moveCubeColumns();
      }
      
      private function __onRandomCube(evt:CubeGameEvent) : void
      {
         var cubeData:CubeData = evt.data.cubeData as CubeData;
         var column:uint = evt.data.column as uint;
         if(column >= _cubeColumns.length)
         {
            return;
         }
         var cubeColumn:CubeColumn = _cubeColumns[column];
         if(!cubeColumn)
         {
            return;
         }
         cubeColumn.addCube(cubeData);
      }
      
      private function moveCubeColumns() : void
      {
         var i:* = 0;
         var curCubeColumn:* = null;
         var hasEmptyColumn:Boolean = false;
         var j:* = 0;
         SoundManager.instance.play("220");
         for(i = uint(0); i < _cubeColumns.length; )
         {
            curCubeColumn = _cubeColumns[i];
            if(curCubeColumn)
            {
               hasEmptyColumn = false;
               for(j = uint(i + 1); j < _cubeColumns.length; )
               {
                  if(_cubeColumns[j].empty)
                  {
                     hasEmptyColumn = true;
                     break;
                  }
                  j++;
               }
               if(!hasEmptyColumn)
               {
                  if(curCubeColumn.empty)
                  {
                     _cubeColumns.splice(i,1);
                     i--;
                     if(curCubeColumn.parent)
                     {
                        curCubeColumn.parent.removeChild(curCubeColumn);
                     }
                  }
                  else
                  {
                     curCubeColumn.move();
                  }
               }
            }
            i++;
         }
      }
      
      private function __onDestroy(evt:CubeGameEvent) : void
      {
         CubeGameManager.getInstance().resquestDeleteCube(evt.data as int);
      }
      
      private function __onDeath(evt:CubeGameEvent) : void
      {
         var i:* = 0;
         var cubeColumn:* = null;
         var ids:Vector.<Object> = evt.data as Vector.<Object>;
         if(!ids || ids.length == 0)
         {
            return;
         }
         i = uint(0);
         while(i < _cubeColumns.length)
         {
            cubeColumn = _cubeColumns[i];
            if(cubeColumn)
            {
               cubeColumn.deleteCubes(ids);
            }
            i++;
         }
      }
      
      private function __onClearMap(evt:CubeGameEvent) : void
      {
         clear();
      }
      
      private function clear() : void
      {
         var cubeColumn:* = null;
         while(_cubeColumns.length > 0)
         {
            cubeColumn = _cubeColumns.pop();
            if(cubeColumn)
            {
               cubeColumn.clear();
               if(cubeColumn.parent)
               {
                  cubeColumn.parent.removeChild(cubeColumn);
               }
               ObjectUtils.disposeAllChildren(cubeColumn);
            }
         }
      }
      
      public function dispose() : void
      {
         var scoreFloatEffect:* = null;
         removeListeners();
         clear();
         _cubeColumns = null;
         while(_scoreFloatEffects.length > 0)
         {
            scoreFloatEffect = _scoreFloatEffects.pop();
            ObjectUtils.disposeObject(scoreFloatEffect);
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
   
   public function set data(value:Vector.<CubeData>) : void
   {
      var i:int = 0;
      var cubeData:* = null;
      var cube:* = null;
      for(i = value.length - 1; i >= 0; )
      {
         cubeData = value[i];
         if(cubeData)
         {
            cube = new Cube(cubeData.id,cubeData.type);
            cube.y = 42 * i;
            cube.yPos = cube.y;
            _cubes.push(cube);
            addChild(cube);
         }
         i--;
      }
   }
   
   public function clear() : void
   {
      var cube:* = null;
      while(_cubes.length > 0)
      {
         cube = _cubes.pop();
         if(cube)
         {
            cube.dispose();
            if(cube.parent)
            {
               cube.parent.removeChild(cube);
            }
         }
      }
   }
   
   public function addCube(cubeData:CubeData) : void
   {
      var cube:Cube = new Cube(cubeData.id,cubeData.type);
      addChild(cube);
      cube.yPos = (CubeGameManager.getInstance().gameInfo.row - _cubes.length - 1) * 42;
      cube.fall();
      _cubes.push(cube);
   }
   
   public function deleteCubes(ids:Vector.<Object>) : void
   {
      ids = ids;
      var deathCubes:Vector.<Cube> = new Vector.<Cube>();
      for(var i:uint = 0; i < ids.length; )
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
      deathCubes = deathCubes.sort(function(left:Cube, right:Cube):int
      {
         if(left.y < right.y)
         {
            return 1;
         }
         if(left.y > right.y)
         {
            return -1;
         }
         return 0;
      });
      for(var j:uint = 0; j < deathCubes.length; )
      {
         var deathCube:Cube = deathCubes[j];
         for(var k:uint = 0; k < _cubes.length; )
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
   
   private function deleteCube(id:int) : void
   {
      var i:* = 0;
      var deathCube:* = null;
      for(i = uint(0); i < _cubes.length; )
      {
         deathCube = _cubes[i];
         if(deathCube.id == id)
         {
            _cubes.splice(i,1);
            deathCube.die();
            break;
         }
         i++;
      }
   }
   
   private function getCube(id:int) : Cube
   {
      var i:* = 0;
      var cube:* = null;
      for(i = uint(0); i < _cubes.length; )
      {
         cube = _cubes[i];
         if(cube && cube.id == id)
         {
            return cube;
         }
         i++;
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
      var numImg:NumberImage = ComponentFactory.Instance.creatComponentByStylename("cubeMapView.numbers");
      addChild(numImg);
      numImg.space = -4;
      numImg.count = CubeGameManager.getInstance().gameInfo.emptyColumnScore;
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
         "onComplete":function(target:DisplayObject):void
         {
            target = target;
            TweenLite.killTweensOf(this,false);
            TweenLite.to(target,1,{
               "x":endPos.x,
               "y":endPos.y,
               "alpha":0,
               "ease":Sine.easeIn,
               "delay":1,
               "onCompleteParams":[target],
               "onComplete":function(target:DisplayObject):void
               {
                  target.x = _startPos.x;
                  target.y = _startPos.y;
               }
            });
         }
      });
   }
   
   public function set startPosition(value:Point) : void
   {
      _startPos = value;
   }
   
   public function dispose() : void
   {
      ObjectUtils.disposeAllChildren(this);
   }
}
