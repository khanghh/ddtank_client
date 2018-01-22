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
      
      public function CubeMapView(){super();}
      
      private function initView() : void{}
      
      private function initListeners() : void{}
      
      private function removeListeners() : void{}
      
      private function __onGameResult(param1:CubeGameEvent) : void{}
      
      private function showScoreFloatEffect() : void{}
      
      private function checkCondition(param1:int) : Boolean{return false;}
      
      private function __onStartGame(param1:CubeGameEvent) : void{}
      
      private function __onGenerateColumn(param1:CubeGameEvent) : void{}
      
      private function addCubeColumn(param1:Vector.<CubeData>) : void{}
      
      private function __onRandomCube(param1:CubeGameEvent) : void{}
      
      private function moveCubeColumns() : void{}
      
      private function __onDestroy(param1:CubeGameEvent) : void{}
      
      private function __onDeath(param1:CubeGameEvent) : void{}
      
      private function __onClearMap(param1:CubeGameEvent) : void{}
      
      private function clear() : void{}
      
      public function dispose() : void{}
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
   
   function CubeColumn(){super();}
   
   public function set data(param1:Vector.<CubeData>) : void{}
   
   public function clear() : void{}
   
   public function addCube(param1:CubeData) : void{}
   
   public function deleteCubes(param1:Vector.<Object>) : void{}
   
   private function deleteCube(param1:int) : void{}
   
   private function getCube(param1:int) : Cube{return null;}
   
   public function move() : void{}
   
   public function get empty() : Boolean{return false;}
   
   public function dispose() : void{}
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
   
   function ScoreFloatEffect(){super();}
   
   private function initView() : void{}
   
   public function show() : void{}
   
   public function set startPosition(param1:Point) : void{}
   
   public function dispose() : void{}
}
