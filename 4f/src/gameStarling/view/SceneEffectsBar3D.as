package gameStarling.view
{
   import com.greensock.TweenMax;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.geom.Rectangle;
   import gameCommon.model.SceneEffectObj;
   import gameStarling.objects.GameSceneEffect3D;
   import gameStarling.view.map.MapView3D;
   import starlingPhy.object.PhysicalObj3D;
   
   public class SceneEffectsBar3D extends Sprite implements Disposeable
   {
       
      
      private var _bg:Bitmap;
      
      private var _arrow:Bitmap;
      
      private var _iconSprite:Sprite;
      
      private var _cells:Array;
      
      private var _mask:Shape;
      
      private var _spacing:Number = 5;
      
      private var _currentData:Array;
      
      private var _currentId:int;
      
      private var _tween:TweenMax;
      
      private var _map:MapView3D;
      
      private var _updateBackFun:Function;
      
      public function SceneEffectsBar3D(param1:MapView3D){super();}
      
      private function initView() : void{}
      
      private function creatMask(param1:DisplayObject) : Shape{return null;}
      
      private function updatePos() : void{}
      
      public function updateView(param1:Array, param2:Function) : void{}
      
      private function addSceneEffect(param1:SceneEffectObj, param2:Boolean = false) : void{}
      
      private function exeUpdateBackFun() : void{}
      
      private function crateSceneEffect(param1:SceneEffectObj, param2:Boolean = false) : void{}
      
      private function removeSceneEffect(param1:int, param2:Boolean = false) : void{}
      
      public function dispose() : void{}
   }
}

import com.pickgliss.ui.ComponentFactory;
import com.pickgliss.ui.ShowTipManager;
import com.pickgliss.ui.core.Disposeable;
import com.pickgliss.ui.core.ITipedDisplay;
import com.pickgliss.utils.ObjectUtils;
import ddt.manager.LanguageMgr;
import flash.display.Bitmap;
import flash.display.DisplayObject;
import flash.display.Sprite;
import gameCommon.model.SceneEffectObj;

class SceneEffectsCell extends Sprite implements Disposeable, ITipedDisplay
{
    
   
   private var _bg:Bitmap;
   
   private var _icon:Bitmap;
   
   private var _info:SceneEffectObj;
   
   private var _tipData:Object;
   
   private var _tipStyle:String;
   
   function SceneEffectsCell(param1:SceneEffectObj = null){super();}
   
   public function updateView(param1:SceneEffectObj = null) : void{}
   
   public function get info() : SceneEffectObj{return null;}
   
   public function get tipData() : Object{return null;}
   
   public function set tipData(param1:Object) : void{}
   
   public function get tipDirctions() : String{return null;}
   
   public function set tipDirctions(param1:String) : void{}
   
   public function get tipGapH() : int{return 0;}
   
   public function set tipGapH(param1:int) : void{}
   
   public function get tipGapV() : int{return 0;}
   
   public function set tipGapV(param1:int) : void{}
   
   public function get tipStyle() : String{return null;}
   
   public function set tipStyle(param1:String) : void{}
   
   public function asDisplayObject() : DisplayObject{return null;}
   
   public function dispose() : void{}
}
