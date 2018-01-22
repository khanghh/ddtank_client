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
      
      public function SceneEffectsBar3D(param1:MapView3D)
      {
         super();
         _map = param1;
         initView();
      }
      
      private function initView() : void
      {
         var _loc2_:int = 0;
         var _loc1_:* = null;
         _bg = ComponentFactory.Instance.creatBitmap("asset.gameBattle.sceneEffectBarBg");
         addChild(_bg);
         _iconSprite = new Sprite();
         addChild(_iconSprite);
         _cells = [];
         _mask = creatMask(_iconSprite);
         PositionUtils.setPos(_mask,"asset.gameBattle.maskPos");
         addChild(_mask);
         _loc2_ = 0;
         while(_loc2_ < 6)
         {
            _loc1_ = new SceneEffectsCell();
            _iconSprite.addChild(_loc1_);
            _cells.push(_loc1_);
            _loc2_++;
         }
         updatePos();
         _arrow = ComponentFactory.Instance.creatBitmap("asset.gameBattle.sceneEffectBarArrow");
         addChild(_arrow);
      }
      
      private function creatMask(param1:DisplayObject) : Shape
      {
         var _loc2_:Shape = new Shape();
         _loc2_.graphics.beginFill(16711680,1);
         _loc2_.graphics.drawRect(0,0,32,180);
         _loc2_.graphics.endFill();
         param1.mask = _loc2_;
         return _loc2_;
      }
      
      private function updatePos() : void
      {
         var _loc2_:int = 0;
         var _loc1_:* = null;
         _loc2_ = 0;
         while(_loc2_ < _cells.length)
         {
            _loc1_ = _cells[_loc2_] as SceneEffectsCell;
            _loc1_.y = _loc2_ * (32 + _spacing);
            _loc2_++;
         }
      }
      
      public function updateView(param1:Array, param2:Function) : void
      {
         $arr = param1;
         $backFun = param2;
         exeUpdateBackFun();
         var quick:Boolean = false;
         if(_updateBackFun != null)
         {
            quick = true;
         }
         _updateBackFun = $backFun;
         if(_currentData == null)
         {
            var i:int = 0;
            while(i < _cells.length)
            {
               if($arr.hasOwnProperty(i))
               {
                  var cell1:SceneEffectsCell = _cells[i] as SceneEffectsCell;
                  cell1.updateView($arr[i]);
               }
               i = Number(i) + 1;
            }
            addSceneEffect($arr[0] as SceneEffectObj);
         }
         else
         {
            var cell0:SceneEffectsCell = _cells[0] as SceneEffectsCell;
            var j:int = 1;
            while(j < _cells.length)
            {
               var index:int = j - 1;
               if($arr.hasOwnProperty(index))
               {
                  if(j == 1)
                  {
                     if(cell0.info.id == $arr[index].id)
                     {
                        $arr[index].follow = true;
                     }
                  }
                  var cell2:SceneEffectsCell = _cells[j] as SceneEffectsCell;
                  cell2.updateView($arr[index]);
               }
               j = Number(j) + 1;
            }
            var onAllComplete:Function = function():void
            {
               TweenMax.killTweensOf(_iconSprite);
               _tween = null;
               var _loc1_:SceneEffectsCell = _cells.shift();
               _loc1_.updateView();
               _cells.push(_loc1_);
               _iconSprite.y = 0;
               updatePos();
               if(_currentData[0].id != _currentId && _currentId != SceneEffectObj.Null)
               {
                  removeSceneEffect(_currentId,quick);
               }
               addSceneEffect(_currentData[0] as SceneEffectObj,quick);
            };
            if(_tween)
            {
               onAllComplete();
            }
            else
            {
               var toY:Number = -32 - _spacing;
               _tween = TweenMax.to(_iconSprite,0.5,{
                  "y":toY,
                  "onComplete":onAllComplete
               });
            }
         }
         _currentData = $arr;
      }
      
      private function addSceneEffect(param1:SceneEffectObj, param2:Boolean = false) : void
      {
         obj = param1;
         quick = param2;
         _currentId = obj.id;
         if(_currentId != SceneEffectObj.Null)
         {
            var physicalObj:GameSceneEffect3D = _map.getSceneEffectPhysicalById(obj.id) as GameSceneEffect3D;
            if(physicalObj == null)
            {
               crateSceneEffect(obj,quick);
            }
            else
            {
               physicalObj.x = obj.x;
               physicalObj.y = obj.y;
               physicalObj.stopMoving();
               if(physicalObj.Id == SceneEffectObj.Bomb)
               {
                  physicalObj.updateTxt(obj.turn - 1);
                  physicalObj.bombBackFun = exeUpdateBackFun;
                  if(obj.turn == 1)
                  {
                     var gameSceneEffect:GameSceneEffect3D = physicalObj as GameSceneEffect3D;
                     gameSceneEffect.act("die",function():void
                     {
                        physicalObj.bombBackFun = null;
                        physicalObj.dispose();
                        exeUpdateBackFun();
                     });
                  }
                  else
                  {
                     exeUpdateBackFun();
                  }
               }
               else
               {
                  exeUpdateBackFun();
               }
            }
         }
         else
         {
            exeUpdateBackFun();
         }
      }
      
      private function exeUpdateBackFun() : void
      {
         if(_updateBackFun != null)
         {
            _updateBackFun();
            _updateBackFun = null;
         }
      }
      
      private function crateSceneEffect(param1:SceneEffectObj, param2:Boolean = false) : void
      {
         var _loc8_:* = null;
         var _loc6_:Boolean = false;
         trace("创建特效：" + param1.id + " X:" + param1.x + " Y:" + param1.y);
         var _loc9_:int = param1.x;
         var _loc7_:int = param1.y;
         var _loc5_:Boolean = false;
         var _loc4_:int = 7;
         if(param1.id == SceneEffectObj.Hide)
         {
            _loc8_ = new Rectangle(-250,0,500,_map.mapMaxHeight);
            _loc4_ = 2;
         }
         else if(param1.id == SceneEffectObj.RedDead)
         {
            _loc8_ = new Rectangle(-200,-200,400,400);
         }
         else if(param1.id == SceneEffectObj.BlackHole)
         {
            _loc8_ = new Rectangle(-200,-200,400,400);
         }
         else if(param1.id < -100)
         {
            _loc8_ = new Rectangle(0,0,1,_map.mapMaxHeight);
         }
         else if(param1.id == SceneEffectObj.Bomb)
         {
            _loc5_ = true;
            _loc6_ = true;
            _loc8_ = new Rectangle(0,0,1,1);
            _loc4_ = 1;
         }
         else if(param1.id == SceneEffectObj.Star)
         {
            _loc8_ = new Rectangle(0,0,1,1);
            _loc4_ = 2;
         }
         else
         {
            _loc8_ = new Rectangle(0,0,1,1);
         }
         var _loc3_:GameSceneEffect3D = new GameSceneEffect3D(param1.id,_loc8_,_loc4_,5,50);
         _loc3_.x = _loc9_;
         _loc3_.y = _loc7_;
         if(_loc5_)
         {
            _loc3_.initMoving();
         }
         if(_loc6_)
         {
            _loc3_.updateTxt(param1.turn - 1);
         }
         _map.addPhysical(_loc3_);
         if(param2)
         {
            _loc3_.act("stand");
            exeUpdateBackFun();
         }
         else
         {
            _loc3_.bombBackFun = exeUpdateBackFun;
            _loc3_.act("born",exeUpdateBackFun);
            _loc3_.stopMoving();
         }
      }
      
      private function removeSceneEffect(param1:int, param2:Boolean = false) : void
      {
         var _loc3_:* = null;
         if(param1 != SceneEffectObj.Null)
         {
            trace("移除特效：" + param1);
            _loc3_ = _map.getSceneEffectPhysicalById(param1);
            if(_loc3_)
            {
               if(param2)
               {
                  _loc3_.dispose();
               }
               else
               {
                  _loc3_.die();
               }
            }
         }
      }
      
      public function dispose() : void
      {
         TweenMax.killTweensOf(_iconSprite);
         _tween = null;
         ObjectUtils.disposeAllChildren(_iconSprite);
         ObjectUtils.disposeAllChildren(this);
         _bg = null;
         _arrow = null;
         _mask = null;
         _cells = null;
         _currentData = null;
         _spacing = 0;
         _map = null;
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
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
   
   function SceneEffectsCell(param1:SceneEffectObj = null)
   {
      super();
      _bg = ComponentFactory.Instance.creatBitmap("asset.gameBattle.sceneEffectCellBg");
      addChild(_bg);
      updateView(param1);
      this.buttonMode = true;
      ShowTipManager.Instance.addTip(this);
   }
   
   public function updateView(param1:SceneEffectObj = null) : void
   {
      _info = param1;
      ObjectUtils.disposeObject(_icon);
      if(param1 && param1.follow == false)
      {
         _icon = ComponentFactory.Instance.creatBitmap("asset.gameBattle.sceneEffectIcon" + Math.abs(_info.id));
         addChild(_icon);
         tipData = LanguageMgr.GetTranslation("ddt.gameBattle.sceneEffectCellTips" + _info.id);
         tipStyle = "ddt.view.tips.OneLineTip";
      }
      else
      {
         tipData = null;
         tipStyle = null;
      }
   }
   
   public function get info() : SceneEffectObj
   {
      return _info;
   }
   
   public function get tipData() : Object
   {
      return _tipData;
   }
   
   public function set tipData(param1:Object) : void
   {
      _tipData = param1;
   }
   
   public function get tipDirctions() : String
   {
      return "2,5,7,0,3,6,4,1";
   }
   
   public function set tipDirctions(param1:String) : void
   {
   }
   
   public function get tipGapH() : int
   {
      return 0;
   }
   
   public function set tipGapH(param1:int) : void
   {
   }
   
   public function get tipGapV() : int
   {
      return 0;
   }
   
   public function set tipGapV(param1:int) : void
   {
   }
   
   public function get tipStyle() : String
   {
      return _tipStyle;
   }
   
   public function set tipStyle(param1:String) : void
   {
      _tipStyle = param1;
   }
   
   public function asDisplayObject() : DisplayObject
   {
      return this;
   }
   
   public function dispose() : void
   {
      ShowTipManager.Instance.removeTip(this);
      ObjectUtils.disposeAllChildren(this);
      _bg = null;
      _icon = null;
      _info = null;
      if(this.parent)
      {
         this.parent.removeChild(this);
      }
   }
}
