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
      
      public function HotSpringPlayerBase(param1:PlayerInfo, param2:Function = null)
      {
         _rectangle = new Rectangle();
         super(param2);
         _playerInfo = param1;
         _callBack = param2;
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
      
      private function sceneCharacterLoaderHeadCallBack(param1:SceneCharacterLoaderHead, param2:Boolean = true) : void
      {
         _headBitmapData = param1.getContent()[0] as BitmapData;
         if(param1)
         {
            param1.dispose();
         }
         param1 = null;
         if(!param2 || !_headBitmapData)
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
         var _loc1_:* = null;
         _sceneCharacterSetNatural = new SceneCharacterSet();
         var _loc2_:Vector.<Point> = new Vector.<Point>();
         _loc2_.push(new Point(0,0));
         _loc2_.push(new Point(0,0));
         _loc2_.push(new Point(0,-1));
         _loc2_.push(new Point(0,2));
         _loc2_.push(new Point(0,0));
         _loc2_.push(new Point(0,-1));
         _loc2_.push(new Point(0,2));
         _rectangle.x = 0;
         _rectangle.y = 0;
         _rectangle.width = playerWitdh;
         _rectangle.height = playerHeight;
         _loc1_ = new BitmapData(playerWitdh,playerHeight,true,0);
         _loc1_.copyPixels(_headBitmapData,_rectangle,new Point(0,0));
         _sceneCharacterSetNatural.push(new SceneCharacterItem("NaturalFrontHead","NaturalFrontAction",_loc1_,1,1,playerWitdh,playerHeight,1,_loc2_,true,7));
         _rectangle.x = playerWitdh;
         _rectangle.y = 0;
         _rectangle.width = playerWitdh;
         _rectangle.height = playerHeight;
         _loc1_ = new BitmapData(playerWitdh,playerHeight,true,0);
         _loc1_.copyPixels(_headBitmapData,_rectangle,new Point(0,0));
         _sceneCharacterSetNatural.push(new SceneCharacterItem("NaturalFrontEyesCloseHead","NaturalFrontEyesCloseAction",_loc1_,1,1,playerWitdh,playerHeight,2));
         _rectangle.x = playerWitdh * 2;
         _rectangle.y = 0;
         _rectangle.width = playerWitdh;
         _rectangle.height = playerHeight;
         _loc1_ = new BitmapData(playerWitdh,playerHeight * 2,true,0);
         _loc1_.copyPixels(_headBitmapData,_rectangle,new Point(0,0));
         _sceneCharacterSetNatural.push(new SceneCharacterItem("NaturalBackHead","NaturalBackAction",_loc1_,1,1,playerWitdh,playerHeight,6,_loc2_,true,7));
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
      
      private function sceneCharacterLoaderBodyNaturalCallBack(param1:SceneCharacterLoaderBody, param2:Boolean = true) : void
      {
         var _loc7_:* = null;
         _bodyBitmapData = param1.getContent()[0] as BitmapData;
         _sceneCharacterLoaderPath = null;
         if(param1)
         {
            param1.dispose();
         }
         param1 = null;
         if(!param2 || !_bodyBitmapData)
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
         _loc7_ = new BitmapData(_bodyBitmapData.width,playerHeight,true,0);
         _loc7_.copyPixels(_bodyBitmapData,_rectangle,new Point(0,0));
         _sceneCharacterSetNatural.push(new SceneCharacterItem("NaturalFrontBody","NaturalFrontAction",_loc7_,1,7,playerWitdh,playerHeight,3));
         _rectangle.x = 0;
         _rectangle.y = 0;
         _rectangle.width = playerWitdh;
         _rectangle.height = playerHeight;
         _loc7_ = new BitmapData(playerWitdh,playerHeight,true,0);
         _loc7_.copyPixels(_bodyBitmapData,_rectangle,new Point(0,0));
         _sceneCharacterSetNatural.push(new SceneCharacterItem("NaturalFrontEyesCloseBody","NaturalFrontEyesCloseAction",_loc7_,1,1,playerWitdh,playerHeight,4));
         _rectangle.x = 0;
         _rectangle.y = playerHeight;
         _rectangle.width = _bodyBitmapData.width;
         _rectangle.height = playerHeight;
         _loc7_ = new BitmapData(_bodyBitmapData.width,playerHeight,true,0);
         _loc7_.copyPixels(_bodyBitmapData,_rectangle,new Point(0,0));
         _sceneCharacterSetNatural.push(new SceneCharacterItem("NaturalBackBody","NaturalBackAction",_loc7_,1,7,playerWitdh,playerHeight,5));
         var _loc6_:SceneCharacterActionItem = new SceneCharacterActionItem("naturalStandFront",[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,7,7,7],true);
         _sceneCharacterActionSetNatural.push(_loc6_);
         var _loc5_:SceneCharacterActionItem = new SceneCharacterActionItem("naturalStandBack",[8],false);
         _sceneCharacterActionSetNatural.push(_loc5_);
         var _loc4_:SceneCharacterActionItem = new SceneCharacterActionItem("naturalWalkFront",[1,1,1,2,2,2,3,3,3,4,4,4,5,5,5,6,6,6],true);
         _sceneCharacterActionSetNatural.push(_loc4_);
         var _loc3_:SceneCharacterActionItem = new SceneCharacterActionItem("naturalWalkBack",[9,9,9,10,10,10,11,11,11,12,12,12,13,13,13,14,14,14],true);
         _sceneCharacterActionSetNatural.push(_loc3_);
         var _loc8_:SceneCharacterStateItem = new SceneCharacterStateItem("natural",_sceneCharacterSetNatural,_sceneCharacterActionSetNatural);
         _sceneCharacterStateSet.push(_loc8_);
         sceneCharacterStateWater();
      }
      
      private function sceneCharacterStateWater() : void
      {
         var _loc2_:* = null;
         var _loc1_:* = null;
         var _loc3_:* = null;
         _sceneCharacterSetWater = new SceneCharacterSet();
         _headMaskAsset = ComponentFactory.Instance.creat("asset.HotSpringPlayerBase.headMaskAsset");
         _headMaskAsset.cacheAsBitmap = true;
         _rectangle.x = 0;
         _rectangle.y = 0;
         _rectangle.width = playerWitdh;
         _rectangle.height = playerHeight;
         _loc2_ = new BitmapData(playerWitdh,playerHeight,true,0);
         _loc2_.copyPixels(_headBitmapData,_rectangle,new Point(0,0));
         _loc1_ = new Bitmap(_loc2_);
         _loc1_.cacheAsBitmap = true;
         _loc1_.mask = _headMaskAsset;
         _loc3_ = new Sprite();
         _loc3_.addChild(_loc1_);
         _loc3_.addChild(_headMaskAsset);
         _loc2_ = new BitmapData(playerWitdh,playerHeight,true,0);
         _loc2_.draw(_loc3_);
         if(_loc1_)
         {
            _loc1_.bitmapData.dispose();
         }
         _loc1_ = null;
         if(_loc3_ && _loc3_.parent)
         {
            _loc3_.parent.removeChild(_loc3_);
         }
         _loc3_ = null;
         _sceneCharacterSetWater.push(new SceneCharacterItem("WaterFrontHead","WaterFrontAction",_loc2_,1,1,playerWitdh,playerHeight,1));
         _rectangle.x = playerWitdh;
         _rectangle.y = 0;
         _rectangle.width = playerWitdh;
         _rectangle.height = playerHeight;
         _loc2_ = new BitmapData(playerWitdh,playerHeight,true,0);
         _loc2_.copyPixels(_headBitmapData,_rectangle,new Point(0,0));
         _loc1_ = new Bitmap(_loc2_);
         _loc1_.cacheAsBitmap = true;
         _loc1_.mask = _headMaskAsset;
         _loc3_ = new Sprite();
         _loc3_.addChild(_loc1_);
         _loc3_.addChild(_headMaskAsset);
         _loc2_ = new BitmapData(playerWitdh,playerHeight,true,0);
         _loc2_.draw(_loc3_);
         if(_loc1_)
         {
            _loc1_.bitmapData.dispose();
         }
         _loc1_ = null;
         if(_loc3_ && _loc3_.parent)
         {
            _loc3_.parent.removeChild(_loc3_);
         }
         _loc3_ = null;
         _sceneCharacterSetWater.push(new SceneCharacterItem("WaterFrontEyesCloseHead","WaterFrontEyesCloseAction",_loc2_,1,1,playerWitdh,playerHeight,2));
         _rectangle.x = playerWitdh * 2;
         _rectangle.y = 0;
         _rectangle.width = playerWitdh;
         _rectangle.height = playerHeight;
         _loc2_ = new BitmapData(playerWitdh,playerHeight,true,0);
         _loc2_.copyPixels(_headBitmapData,_rectangle,new Point(0,0));
         _loc1_ = new Bitmap(_loc2_);
         _loc1_.cacheAsBitmap = true;
         _loc1_.mask = _headMaskAsset;
         _loc3_ = new Sprite();
         _loc3_.addChild(_loc1_);
         _loc3_.addChild(_headMaskAsset);
         _loc2_ = new BitmapData(playerWitdh,playerHeight,true,0);
         _loc2_.draw(_loc3_);
         if(_loc1_)
         {
            _loc1_.bitmapData.dispose();
         }
         _loc1_ = null;
         if(_loc3_ && _loc3_.parent)
         {
            _loc3_.parent.removeChild(_loc3_);
         }
         _loc3_ = null;
         if(_headMaskAsset && _headMaskAsset.parent)
         {
            _headMaskAsset.parent.removeChild(_headMaskAsset);
         }
         _headMaskAsset = null;
         _sceneCharacterSetWater.push(new SceneCharacterItem("WaterBackHead","WaterBackAction",_loc2_,1,1,playerWitdh,playerHeight,6));
         sceneCharacterLoadBodyWater();
      }
      
      private function sceneCharacterLoadBodyWater() : void
      {
         _sceneCharacterLoaderPath = "cloth3";
         _sceneCharacterLoaderBody = new SceneCharacterLoaderBody(_playerInfo,_sceneCharacterLoaderPath);
         _sceneCharacterLoaderBody.load(sceneCharacterLoaderBodyWaterCallBack);
      }
      
      private function sceneCharacterLoaderBodyWaterCallBack(param1:SceneCharacterLoaderBody, param2:Boolean = true) : void
      {
         var _loc7_:* = null;
         _bodyBitmapData = param1.getContent()[0] as BitmapData;
         _sceneCharacterLoaderPath = null;
         if(param1)
         {
            param1.dispose();
         }
         param1 = null;
         if(!param2 || !_bodyBitmapData)
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
         _loc7_ = new BitmapData(_bodyBitmapData.width,playerHeight,true,0);
         _loc7_.copyPixels(_bodyBitmapData,_rectangle,new Point(0,0));
         _sceneCharacterSetWater.push(new SceneCharacterItem("WaterFrontBody","WaterFrontAction",_loc7_,1,1,playerWitdh,playerHeight,3));
         _rectangle.x = 0;
         _rectangle.y = 0;
         _rectangle.width = playerWitdh;
         _rectangle.height = playerHeight;
         _loc7_ = new BitmapData(playerWitdh,playerHeight,true,0);
         _loc7_.copyPixels(_bodyBitmapData,_rectangle,new Point(0,0));
         _sceneCharacterSetWater.push(new SceneCharacterItem("WaterFrontEyesCloseBody","WaterFrontEyesCloseAction",_loc7_,1,1,playerWitdh,playerHeight,4));
         _rectangle.x = 0;
         _rectangle.y = playerHeight;
         _rectangle.width = _bodyBitmapData.width;
         _rectangle.height = playerHeight;
         _loc7_ = new BitmapData(_bodyBitmapData.width,playerHeight,true,0);
         _loc7_.copyPixels(_bodyBitmapData,_rectangle,new Point(0,0));
         _sceneCharacterSetWater.push(new SceneCharacterItem("WaterBackBody","WaterBackAction",_loc7_,1,0,playerWitdh,playerHeight,5));
         var _loc6_:SceneCharacterActionItem = new SceneCharacterActionItem("waterFrontEyes",[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1],true);
         _sceneCharacterActionSetWater.push(_loc6_);
         var _loc5_:SceneCharacterActionItem = new SceneCharacterActionItem("waterStandBack",[2],false);
         _sceneCharacterActionSetWater.push(_loc5_);
         var _loc4_:SceneCharacterActionItem = new SceneCharacterActionItem("waterBack",[2],false);
         _sceneCharacterActionSetWater.push(_loc4_);
         var _loc3_:SceneCharacterActionItem = new SceneCharacterActionItem("waterFront",[0],false);
         _sceneCharacterActionSetWater.push(_loc3_);
         var _loc8_:SceneCharacterStateItem = new SceneCharacterStateItem("water",_sceneCharacterSetWater,_sceneCharacterActionSetWater);
         _sceneCharacterStateSet.push(_loc8_);
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
