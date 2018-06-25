package hotSpring.player
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.image.MovieImage;
   import ddt.data.player.PlayerInfo;
   import ddt.view.sceneCharacter.SceneCharacterActionItem;
   import ddt.view.sceneCharacter.SceneCharacterActionSet;
   import ddt.view.sceneCharacter.SceneCharacterItem;
   import ddt.view.sceneCharacter.SceneCharacterLoaderBody;
   import ddt.view.sceneCharacter.SceneCharacterLoaderHead;
   import ddt.view.sceneCharacter.SceneCharacterPlayerBase;
   import ddt.view.sceneCharacter.SceneCharacterSet;
   import ddt.view.sceneCharacter.SceneCharacterStateItem;
   import ddt.view.sceneCharacter.SceneCharacterStateSet;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Sprite;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class HotSpringPlayerBase extends SceneCharacterPlayerBase
   {
       
      
      private var _playerInfo:PlayerInfo;
      
      private var _sceneCharacterStateSet:SceneCharacterStateSet;
      
      private var _sceneCharacterSetNatural:SceneCharacterSet;
      
      private var _sceneCharacterSetWater:SceneCharacterSet;
      
      private var _sceneCharacterLoaderPath:String;
      
      private var _sceneCharacterActionSetNatural:SceneCharacterActionSet;
      
      private var _sceneCharacterActionSetWater:SceneCharacterActionSet;
      
      private var _sceneCharacterLoaderHead:SceneCharacterLoaderHead;
      
      private var _sceneCharacterLoaderBody:SceneCharacterLoaderBody;
      
      private var _headBitmapData:BitmapData;
      
      private var _bodyBitmapData:BitmapData;
      
      private var _rectangle:Rectangle;
      
      private var _headMaskAsset:MovieImage;
      
      public var playerWitdh:Number = 120;
      
      public var playerHeight:Number = 175;
      
      private var _callBack:Function;
      
      public function HotSpringPlayerBase(playerInfo:PlayerInfo, callBack:Function = null)
      {
         _rectangle = new Rectangle();
         super(callBack);
         _playerInfo = playerInfo;
         _callBack = callBack;
         initialize();
      }
      
      private function initialize() : void
      {
         _sceneCharacterStateSet = new SceneCharacterStateSet();
         _sceneCharacterActionSetNatural = new SceneCharacterActionSet();
         _sceneCharacterActionSetWater = new SceneCharacterActionSet();
         sceneCharacterLoadHead();
      }
      
      private function sceneCharacterLoadHead() : void
      {
         _sceneCharacterLoaderHead = new SceneCharacterLoaderHead(_playerInfo);
         _sceneCharacterLoaderHead.load(sceneCharacterLoaderHeadCallBack);
      }
      
      private function sceneCharacterLoaderHeadCallBack(sceneCharacterLoaderHead:SceneCharacterLoaderHead, isAllLoadSucceed:Boolean = true) : void
      {
         _headBitmapData = sceneCharacterLoaderHead.getContent()[0] as BitmapData;
         if(sceneCharacterLoaderHead)
         {
            sceneCharacterLoaderHead.dispose();
         }
         sceneCharacterLoaderHead = null;
         if(!isAllLoadSucceed || !_headBitmapData)
         {
            if(_callBack != null)
            {
               _callBack(this,false);
            }
            return;
         }
         sceneCharacterStateNatural();
      }
      
      private function sceneCharacterStateNatural() : void
      {
         var actionBmp:* = null;
         _sceneCharacterSetNatural = new SceneCharacterSet();
         var points:Vector.<Point> = new Vector.<Point>();
         points.push(new Point(0,0));
         points.push(new Point(0,0));
         points.push(new Point(0,-1));
         points.push(new Point(0,2));
         points.push(new Point(0,0));
         points.push(new Point(0,-1));
         points.push(new Point(0,2));
         _rectangle.x = 0;
         _rectangle.y = 0;
         _rectangle.width = playerWitdh;
         _rectangle.height = playerHeight;
         actionBmp = new BitmapData(playerWitdh,playerHeight,true,0);
         actionBmp.copyPixels(_headBitmapData,_rectangle,new Point(0,0));
         _sceneCharacterSetNatural.push(new SceneCharacterItem("NaturalFrontHead","NaturalFrontAction",actionBmp,1,1,playerWitdh,playerHeight,1,points,true,7));
         _rectangle.x = playerWitdh;
         _rectangle.y = 0;
         _rectangle.width = playerWitdh;
         _rectangle.height = playerHeight;
         actionBmp = new BitmapData(playerWitdh,playerHeight,true,0);
         actionBmp.copyPixels(_headBitmapData,_rectangle,new Point(0,0));
         _sceneCharacterSetNatural.push(new SceneCharacterItem("NaturalFrontEyesCloseHead","NaturalFrontEyesCloseAction",actionBmp,1,1,playerWitdh,playerHeight,2));
         _rectangle.x = playerWitdh * 2;
         _rectangle.y = 0;
         _rectangle.width = playerWitdh;
         _rectangle.height = playerHeight;
         actionBmp = new BitmapData(playerWitdh,playerHeight * 2,true,0);
         actionBmp.copyPixels(_headBitmapData,_rectangle,new Point(0,0));
         _sceneCharacterSetNatural.push(new SceneCharacterItem("NaturalBackHead","NaturalBackAction",actionBmp,1,1,playerWitdh,playerHeight,6,points,true,7));
         sceneCharacterLoadBodyNatural();
      }
      
      private function sceneCharacterLoadBodyNatural() : void
      {
         if(_playerInfo.IsVIP)
         {
            _sceneCharacterLoaderPath = "cloth4";
         }
         else
         {
            _sceneCharacterLoaderPath = "cloth2";
         }
         _sceneCharacterLoaderBody = new SceneCharacterLoaderBody(_playerInfo,_sceneCharacterLoaderPath);
         _sceneCharacterLoaderBody.load(sceneCharacterLoaderBodyNaturalCallBack);
      }
      
      private function sceneCharacterLoaderBodyNaturalCallBack(sceneCharacterLoaderBody:SceneCharacterLoaderBody, isAllLoadSucceed:Boolean = true) : void
      {
         var actionBmp:* = null;
         _bodyBitmapData = sceneCharacterLoaderBody.getContent()[0] as BitmapData;
         _sceneCharacterLoaderPath = null;
         if(sceneCharacterLoaderBody)
         {
            sceneCharacterLoaderBody.dispose();
         }
         sceneCharacterLoaderBody = null;
         if(!isAllLoadSucceed || !_bodyBitmapData)
         {
            if(_callBack != null)
            {
               _callBack(this,false);
            }
            return;
         }
         _rectangle.x = 0;
         _rectangle.y = 0;
         _rectangle.width = _bodyBitmapData.width;
         _rectangle.height = playerHeight;
         actionBmp = new BitmapData(_bodyBitmapData.width,playerHeight,true,0);
         actionBmp.copyPixels(_bodyBitmapData,_rectangle,new Point(0,0));
         _sceneCharacterSetNatural.push(new SceneCharacterItem("NaturalFrontBody","NaturalFrontAction",actionBmp,1,7,playerWitdh,playerHeight,3));
         _rectangle.x = 0;
         _rectangle.y = 0;
         _rectangle.width = playerWitdh;
         _rectangle.height = playerHeight;
         actionBmp = new BitmapData(playerWitdh,playerHeight,true,0);
         actionBmp.copyPixels(_bodyBitmapData,_rectangle,new Point(0,0));
         _sceneCharacterSetNatural.push(new SceneCharacterItem("NaturalFrontEyesCloseBody","NaturalFrontEyesCloseAction",actionBmp,1,1,playerWitdh,playerHeight,4));
         _rectangle.x = 0;
         _rectangle.y = playerHeight;
         _rectangle.width = _bodyBitmapData.width;
         _rectangle.height = playerHeight;
         actionBmp = new BitmapData(_bodyBitmapData.width,playerHeight,true,0);
         actionBmp.copyPixels(_bodyBitmapData,_rectangle,new Point(0,0));
         _sceneCharacterSetNatural.push(new SceneCharacterItem("NaturalBackBody","NaturalBackAction",actionBmp,1,7,playerWitdh,playerHeight,5));
         var sceneCharacterActionItem1:SceneCharacterActionItem = new SceneCharacterActionItem("naturalStandFront",[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,7,7,7],true);
         _sceneCharacterActionSetNatural.push(sceneCharacterActionItem1);
         var sceneCharacterActionItem2:SceneCharacterActionItem = new SceneCharacterActionItem("naturalStandBack",[8],false);
         _sceneCharacterActionSetNatural.push(sceneCharacterActionItem2);
         var sceneCharacterActionItem3:SceneCharacterActionItem = new SceneCharacterActionItem("naturalWalkFront",[1,1,1,2,2,2,3,3,3,4,4,4,5,5,5,6,6,6],true);
         _sceneCharacterActionSetNatural.push(sceneCharacterActionItem3);
         var sceneCharacterActionItem4:SceneCharacterActionItem = new SceneCharacterActionItem("naturalWalkBack",[9,9,9,10,10,10,11,11,11,12,12,12,13,13,13,14,14,14],true);
         _sceneCharacterActionSetNatural.push(sceneCharacterActionItem4);
         var _sceneCharacterStateItemNatural:SceneCharacterStateItem = new SceneCharacterStateItem("natural",_sceneCharacterSetNatural,_sceneCharacterActionSetNatural);
         _sceneCharacterStateSet.push(_sceneCharacterStateItemNatural);
         sceneCharacterStateWater();
      }
      
      private function sceneCharacterStateWater() : void
      {
         var actionBmp:* = null;
         var actionBmpMask:* = null;
         var actionMaskBox:* = null;
         _sceneCharacterSetWater = new SceneCharacterSet();
         _headMaskAsset = ComponentFactory.Instance.creat("asset.HotSpringPlayerBase.headMaskAsset");
         _headMaskAsset.cacheAsBitmap = true;
         _rectangle.x = 0;
         _rectangle.y = 0;
         _rectangle.width = playerWitdh;
         _rectangle.height = playerHeight;
         actionBmp = new BitmapData(playerWitdh,playerHeight,true,0);
         actionBmp.copyPixels(_headBitmapData,_rectangle,new Point(0,0));
         actionBmpMask = new Bitmap(actionBmp);
         actionBmpMask.cacheAsBitmap = true;
         actionBmpMask.mask = _headMaskAsset;
         actionMaskBox = new Sprite();
         actionMaskBox.addChild(actionBmpMask);
         actionMaskBox.addChild(_headMaskAsset);
         actionBmp = new BitmapData(playerWitdh,playerHeight,true,0);
         actionBmp.draw(actionMaskBox);
         if(actionBmpMask)
         {
            actionBmpMask.bitmapData.dispose();
         }
         actionBmpMask = null;
         if(actionMaskBox && actionMaskBox.parent)
         {
            actionMaskBox.parent.removeChild(actionMaskBox);
         }
         actionMaskBox = null;
         _sceneCharacterSetWater.push(new SceneCharacterItem("WaterFrontHead","WaterFrontAction",actionBmp,1,1,playerWitdh,playerHeight,1));
         _rectangle.x = playerWitdh;
         _rectangle.y = 0;
         _rectangle.width = playerWitdh;
         _rectangle.height = playerHeight;
         actionBmp = new BitmapData(playerWitdh,playerHeight,true,0);
         actionBmp.copyPixels(_headBitmapData,_rectangle,new Point(0,0));
         actionBmpMask = new Bitmap(actionBmp);
         actionBmpMask.cacheAsBitmap = true;
         actionBmpMask.mask = _headMaskAsset;
         actionMaskBox = new Sprite();
         actionMaskBox.addChild(actionBmpMask);
         actionMaskBox.addChild(_headMaskAsset);
         actionBmp = new BitmapData(playerWitdh,playerHeight,true,0);
         actionBmp.draw(actionMaskBox);
         if(actionBmpMask)
         {
            actionBmpMask.bitmapData.dispose();
         }
         actionBmpMask = null;
         if(actionMaskBox && actionMaskBox.parent)
         {
            actionMaskBox.parent.removeChild(actionMaskBox);
         }
         actionMaskBox = null;
         _sceneCharacterSetWater.push(new SceneCharacterItem("WaterFrontEyesCloseHead","WaterFrontEyesCloseAction",actionBmp,1,1,playerWitdh,playerHeight,2));
         _rectangle.x = playerWitdh * 2;
         _rectangle.y = 0;
         _rectangle.width = playerWitdh;
         _rectangle.height = playerHeight;
         actionBmp = new BitmapData(playerWitdh,playerHeight,true,0);
         actionBmp.copyPixels(_headBitmapData,_rectangle,new Point(0,0));
         actionBmpMask = new Bitmap(actionBmp);
         actionBmpMask.cacheAsBitmap = true;
         actionBmpMask.mask = _headMaskAsset;
         actionMaskBox = new Sprite();
         actionMaskBox.addChild(actionBmpMask);
         actionMaskBox.addChild(_headMaskAsset);
         actionBmp = new BitmapData(playerWitdh,playerHeight,true,0);
         actionBmp.draw(actionMaskBox);
         if(actionBmpMask)
         {
            actionBmpMask.bitmapData.dispose();
         }
         actionBmpMask = null;
         if(actionMaskBox && actionMaskBox.parent)
         {
            actionMaskBox.parent.removeChild(actionMaskBox);
         }
         actionMaskBox = null;
         if(_headMaskAsset && _headMaskAsset.parent)
         {
            _headMaskAsset.parent.removeChild(_headMaskAsset);
         }
         _headMaskAsset = null;
         _sceneCharacterSetWater.push(new SceneCharacterItem("WaterBackHead","WaterBackAction",actionBmp,1,1,playerWitdh,playerHeight,6));
         sceneCharacterLoadBodyWater();
      }
      
      private function sceneCharacterLoadBodyWater() : void
      {
         _sceneCharacterLoaderPath = "cloth3";
         _sceneCharacterLoaderBody = new SceneCharacterLoaderBody(_playerInfo,_sceneCharacterLoaderPath);
         _sceneCharacterLoaderBody.load(sceneCharacterLoaderBodyWaterCallBack);
      }
      
      private function sceneCharacterLoaderBodyWaterCallBack(sceneCharacterLoaderBody:SceneCharacterLoaderBody, isAllLoadSucceed:Boolean = true) : void
      {
         var actionBmp:* = null;
         _bodyBitmapData = sceneCharacterLoaderBody.getContent()[0] as BitmapData;
         _sceneCharacterLoaderPath = null;
         if(sceneCharacterLoaderBody)
         {
            sceneCharacterLoaderBody.dispose();
         }
         sceneCharacterLoaderBody = null;
         if(!isAllLoadSucceed || !_bodyBitmapData)
         {
            if(_callBack != null)
            {
               _callBack(this,false);
            }
            return;
         }
         _rectangle.x = 0;
         _rectangle.y = 0;
         _rectangle.width = _bodyBitmapData.width;
         _rectangle.height = playerHeight;
         actionBmp = new BitmapData(_bodyBitmapData.width,playerHeight,true,0);
         actionBmp.copyPixels(_bodyBitmapData,_rectangle,new Point(0,0));
         _sceneCharacterSetWater.push(new SceneCharacterItem("WaterFrontBody","WaterFrontAction",actionBmp,1,1,playerWitdh,playerHeight,3));
         _rectangle.x = 0;
         _rectangle.y = 0;
         _rectangle.width = playerWitdh;
         _rectangle.height = playerHeight;
         actionBmp = new BitmapData(playerWitdh,playerHeight,true,0);
         actionBmp.copyPixels(_bodyBitmapData,_rectangle,new Point(0,0));
         _sceneCharacterSetWater.push(new SceneCharacterItem("WaterFrontEyesCloseBody","WaterFrontEyesCloseAction",actionBmp,1,1,playerWitdh,playerHeight,4));
         _rectangle.x = 0;
         _rectangle.y = playerHeight;
         _rectangle.width = _bodyBitmapData.width;
         _rectangle.height = playerHeight;
         actionBmp = new BitmapData(_bodyBitmapData.width,playerHeight,true,0);
         actionBmp.copyPixels(_bodyBitmapData,_rectangle,new Point(0,0));
         _sceneCharacterSetWater.push(new SceneCharacterItem("WaterBackBody","WaterBackAction",actionBmp,1,0,playerWitdh,playerHeight,5));
         var sceneCharacterActionItem1:SceneCharacterActionItem = new SceneCharacterActionItem("waterFrontEyes",[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1],true);
         _sceneCharacterActionSetWater.push(sceneCharacterActionItem1);
         var sceneCharacterActionItem2:SceneCharacterActionItem = new SceneCharacterActionItem("waterStandBack",[2],false);
         _sceneCharacterActionSetWater.push(sceneCharacterActionItem2);
         var sceneCharacterActionItem3:SceneCharacterActionItem = new SceneCharacterActionItem("waterBack",[2],false);
         _sceneCharacterActionSetWater.push(sceneCharacterActionItem3);
         var sceneCharacterActionItem4:SceneCharacterActionItem = new SceneCharacterActionItem("waterFront",[0],false);
         _sceneCharacterActionSetWater.push(sceneCharacterActionItem4);
         var _sceneCharacterStateItemWater:SceneCharacterStateItem = new SceneCharacterStateItem("water",_sceneCharacterSetWater,_sceneCharacterActionSetWater);
         _sceneCharacterStateSet.push(_sceneCharacterStateItemWater);
         .super.sceneCharacterStateSet = _sceneCharacterStateSet;
      }
      
      override public function dispose() : void
      {
         _playerInfo = null;
         if(_sceneCharacterSetNatural)
         {
            _sceneCharacterSetNatural.dispose();
         }
         _sceneCharacterSetNatural = null;
         if(_sceneCharacterSetWater)
         {
            _sceneCharacterSetWater.dispose();
         }
         _sceneCharacterSetWater = null;
         if(_sceneCharacterLoaderHead)
         {
            _sceneCharacterLoaderHead.dispose();
         }
         _sceneCharacterLoaderHead = null;
         if(_sceneCharacterLoaderBody)
         {
            _sceneCharacterLoaderBody.dispose();
         }
         _sceneCharacterLoaderBody = null;
         if(_sceneCharacterActionSetNatural)
         {
            _sceneCharacterActionSetNatural.dispose();
         }
         _sceneCharacterActionSetNatural = null;
         if(_sceneCharacterActionSetWater)
         {
            _sceneCharacterActionSetWater.dispose();
         }
         _sceneCharacterActionSetWater = null;
         if(_sceneCharacterStateSet)
         {
            _sceneCharacterStateSet.dispose();
         }
         _sceneCharacterStateSet = null;
         if(_headBitmapData)
         {
            _headBitmapData.dispose();
         }
         _headBitmapData = null;
         if(_bodyBitmapData)
         {
            _bodyBitmapData.dispose();
         }
         _bodyBitmapData = null;
         if(_headMaskAsset && _headMaskAsset.parent)
         {
            _headMaskAsset.parent.removeChild(_headMaskAsset);
         }
         _headMaskAsset = null;
         _sceneCharacterLoaderPath = null;
         _rectangle = null;
         super.dispose();
      }
   }
}
