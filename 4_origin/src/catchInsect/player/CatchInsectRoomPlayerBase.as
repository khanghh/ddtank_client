package catchInsect.player
{
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.player.PlayerInfo;
   import ddt.view.sceneCharacter.SceneCharacterActionItem;
   import ddt.view.sceneCharacter.SceneCharacterActionSet;
   import ddt.view.sceneCharacter.SceneCharacterItem;
   import ddt.view.sceneCharacter.SceneCharacterLoaderHead;
   import ddt.view.sceneCharacter.SceneCharacterPlayerBase;
   import ddt.view.sceneCharacter.SceneCharacterSet;
   import ddt.view.sceneCharacter.SceneCharacterStateItem;
   import ddt.view.sceneCharacter.SceneCharacterStateSet;
   import flash.display.BitmapData;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class CatchInsectRoomPlayerBase extends SceneCharacterPlayerBase
   {
       
      
      private var _playerInfo:PlayerInfo;
      
      private var _sceneCharacterStateSet:SceneCharacterStateSet;
      
      private var _sceneCharacterSetNatural:SceneCharacterSet;
      
      private var _sceneCharacterActionSetNatural:SceneCharacterActionSet;
      
      private var _headBitmapData:BitmapData;
      
      private var _bodyBitmapData:BitmapData;
      
      private var _rectangle:Rectangle;
      
      public var playerWitdh:Number = 120;
      
      public var playerHeight:Number = 175;
      
      private var _callBack:Function;
      
      private var _sceneCharacterLoaderBody:SceneCharacterLoaderBody;
      
      private var _sceneCharacterLoaderHead:SceneCharacterLoaderHead;
      
      public function CatchInsectRoomPlayerBase(param1:PlayerInfo, param2:Function = null)
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
         if(!param2 || !_headBitmapData)
         {
            if(_callBack != null)
            {
               _callBack(this,false,0);
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
         if(!_rectangle)
         {
            _rectangle = new Rectangle();
         }
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
         _sceneCharacterLoaderBody = new SceneCharacterLoaderBody(_playerInfo);
         _sceneCharacterLoaderBody.load(sceneCharacterLoaderBodyNaturalCallBack);
      }
      
      private function sceneCharacterLoaderBodyNaturalCallBack(param1:SceneCharacterLoaderBody, param2:Boolean) : void
      {
         var _loc7_:* = null;
         if(!_sceneCharacterSetNatural)
         {
            return;
         }
         _bodyBitmapData = param1.getContent()[0] as BitmapData;
         if(param1)
         {
            param1.dispose();
         }
         if(!param2 || !_bodyBitmapData)
         {
            if(_callBack != null)
            {
               _callBack(this,false,0);
            }
            return;
         }
         if(!_rectangle)
         {
            _rectangle = new Rectangle();
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
         .super.sceneCharacterStateSet = _sceneCharacterStateSet;
      }
      
      override public function dispose() : void
      {
         _playerInfo = null;
         _callBack = null;
         if(_sceneCharacterSetNatural)
         {
            _sceneCharacterSetNatural.dispose();
         }
         _sceneCharacterSetNatural = null;
         if(_sceneCharacterActionSetNatural)
         {
            _sceneCharacterActionSetNatural.dispose();
         }
         _sceneCharacterActionSetNatural = null;
         if(_sceneCharacterStateSet)
         {
            _sceneCharacterStateSet.dispose();
         }
         _sceneCharacterStateSet = null;
         ObjectUtils.disposeObject(_sceneCharacterLoaderBody);
         _sceneCharacterLoaderBody = null;
         ObjectUtils.disposeObject(_sceneCharacterLoaderHead);
         _sceneCharacterLoaderHead = null;
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
         _rectangle = null;
         super.dispose();
      }
   }
}
