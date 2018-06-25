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
      
      public function SceneEffectsBar3D($map:MapView3D)
      {
         super();
         _map = $map;
         initView();
      }
      
      private function initView() : void
      {
         var i:int = 0;
         var _cell:* = null;
         _bg = ComponentFactory.Instance.creatBitmap("asset.gameBattle.sceneEffectBarBg");
         addChild(_bg);
         _iconSprite = new Sprite();
         addChild(_iconSprite);
         _cells = [];
         _mask = creatMask(_iconSprite);
         PositionUtils.setPos(_mask,"asset.gameBattle.maskPos");
         addChild(_mask);
         for(i = 0; i < 6; )
         {
            _cell = new SceneEffectsCell();
            _iconSprite.addChild(_cell);
            _cells.push(_cell);
            i++;
         }
         updatePos();
         _arrow = ComponentFactory.Instance.creatBitmap("asset.gameBattle.sceneEffectBarArrow");
         addChild(_arrow);
      }
      
      private function creatMask(source:DisplayObject) : Shape
      {
         var result:Shape = new Shape();
         result.graphics.beginFill(16711680,1);
         result.graphics.drawRect(0,0,32,180);
         result.graphics.endFill();
         source.mask = result;
         return result;
      }
      
      private function updatePos() : void
      {
         var i:int = 0;
         var cell:* = null;
         for(i = 0; i < _cells.length; )
         {
            cell = _cells[i] as SceneEffectsCell;
            cell.y = i * (32 + _spacing);
            i++;
         }
      }
      
      public function updateView($arr:Array, $backFun:Function) : void
      {
         $arr = $arr;
         $backFun = $backFun;
         exeUpdateBackFun();
         var quick:Boolean = false;
         if(_updateBackFun != null)
         {
            quick = true;
         }
         _updateBackFun = $backFun;
         if(_currentData == null)
         {
            for(var i:int = 0; i < _cells.length; )
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
            for(var j:int = 1; j < _cells.length; )
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
               var tempCell:SceneEffectsCell = _cells.shift();
               tempCell.updateView();
               _cells.push(tempCell);
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
      
      private function addSceneEffect(obj:SceneEffectObj, quick:Boolean = false) : void
      {
         obj = obj;
         quick = quick;
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
      
      private function crateSceneEffect($obj:SceneEffectObj, quick:Boolean = false) : void
      {
         var rect:* = null;
         var isTxt:Boolean = false;
         trace("创建特效：" + $obj.id + " X:" + $obj.x + " Y:" + $obj.y);
         var sx:int = $obj.x;
         var sy:int = $obj.y;
         var isMoving:Boolean = false;
         var layerType:int = 7;
         if($obj.id == SceneEffectObj.Hide)
         {
            rect = new Rectangle(-250,0,500,_map.mapMaxHeight);
            layerType = 2;
         }
         else if($obj.id == SceneEffectObj.RedDead)
         {
            rect = new Rectangle(-200,-200,400,400);
         }
         else if($obj.id == SceneEffectObj.BlackHole)
         {
            rect = new Rectangle(-200,-200,400,400);
         }
         else if($obj.id < -100)
         {
            rect = new Rectangle(0,0,1,_map.mapMaxHeight);
         }
         else if($obj.id == SceneEffectObj.Bomb)
         {
            isMoving = true;
            isTxt = true;
            rect = new Rectangle(0,0,1,1);
            layerType = 1;
         }
         else if($obj.id == SceneEffectObj.Star)
         {
            rect = new Rectangle(0,0,1,1);
            layerType = 2;
         }
         else
         {
            rect = new Rectangle(0,0,1,1);
         }
         var sceneEffect:GameSceneEffect3D = new GameSceneEffect3D($obj.id,rect,layerType,5,50);
         sceneEffect.x = sx;
         sceneEffect.y = sy;
         if(isMoving)
         {
            sceneEffect.initMoving();
         }
         if(isTxt)
         {
            sceneEffect.updateTxt($obj.turn - 1);
         }
         _map.addPhysical(sceneEffect);
         if(quick)
         {
            sceneEffect.act("stand");
            exeUpdateBackFun();
         }
         else
         {
            sceneEffect.bombBackFun = exeUpdateBackFun;
            sceneEffect.act("born",exeUpdateBackFun);
            sceneEffect.stopMoving();
         }
      }
      
      private function removeSceneEffect($id:int, quick:Boolean = false) : void
      {
         var physicalObj:* = null;
         if($id != SceneEffectObj.Null)
         {
            trace("移除特效：" + $id);
            physicalObj = _map.getSceneEffectPhysicalById($id);
            if(physicalObj)
            {
               if(quick)
               {
                  physicalObj.dispose();
               }
               else
               {
                  physicalObj.die();
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
   
   function SceneEffectsCell($info:SceneEffectObj = null)
   {
      super();
      _bg = ComponentFactory.Instance.creatBitmap("asset.gameBattle.sceneEffectCellBg");
      addChild(_bg);
      updateView($info);
      this.buttonMode = true;
      ShowTipManager.Instance.addTip(this);
   }
   
   public function updateView($info:SceneEffectObj = null) : void
   {
      _info = $info;
      ObjectUtils.disposeObject(_icon);
      if($info && $info.follow == false)
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
   
   public function set tipData(value:Object) : void
   {
      _tipData = value;
   }
   
   public function get tipDirctions() : String
   {
      return "2,5,7,0,3,6,4,1";
   }
   
   public function set tipDirctions(value:String) : void
   {
   }
   
   public function get tipGapH() : int
   {
      return 0;
   }
   
   public function set tipGapH(value:int) : void
   {
   }
   
   public function get tipGapV() : int
   {
      return 0;
   }
   
   public function set tipGapV(value:int) : void
   {
   }
   
   public function get tipStyle() : String
   {
      return _tipStyle;
   }
   
   public function set tipStyle(value:String) : void
   {
      _tipStyle = value;
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
