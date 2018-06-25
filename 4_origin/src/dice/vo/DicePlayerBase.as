package dice.vo
{
   import ddt.data.player.PlayerInfo;
   import ddt.events.SceneCharacterEvent;
   import ddt.view.sceneCharacter.SceneCharacterActionItem;
   import ddt.view.sceneCharacter.SceneCharacterActionSet;
   import ddt.view.sceneCharacter.SceneCharacterDirection;
   import ddt.view.sceneCharacter.SceneCharacterItem;
   import ddt.view.sceneCharacter.SceneCharacterLoaderHead;
   import ddt.view.sceneCharacter.SceneCharacterPlayerBase;
   import ddt.view.sceneCharacter.SceneCharacterSet;
   import ddt.view.sceneCharacter.SceneCharacterStateItem;
   import ddt.view.sceneCharacter.SceneCharacterStateSet;
   import dice.controller.DiceController;
   import flash.display.BitmapData;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class DicePlayerBase extends SceneCharacterPlayerBase
   {
       
      
      private var _playerInfo:PlayerInfo;
      
      private var _sceneCharacterStateSet:SceneCharacterStateSet;
      
      private var _sceneCharacterSetNatural:SceneCharacterSet;
      
      private var _sceneCharacterActionSetNatural:SceneCharacterActionSet;
      
      private var _headBitmapData:BitmapData;
      
      private var _bodyBitmapData:BitmapData;
      
      private var _rectangle:Rectangle;
      
      private var _sceneCharacterLoaderBody:DiceSceneCharacterLoaderBody;
      
      private var _sceneCharacterLoaderHead:SceneCharacterLoaderHead;
      
      private var _callBack:Function;
      
      private var _SynchronousPosition:Function;
      
      private var _isWalk:Boolean = false;
      
      public var _playerWidth:Number = 120;
      
      public var _playerHeight:Number = 175;
      
      public function DicePlayerBase(playerInfo:PlayerInfo, SynchronousPosition:Function = null, callBack:Function = null)
      {
         _rectangle = new Rectangle();
         super(callBack);
         _playerInfo = playerInfo;
         _callBack = callBack;
         _SynchronousPosition = SynchronousPosition;
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
      
      private function sceneCharacterLoaderHeadCallBack(sceneCharacterLoaderHead:SceneCharacterLoaderHead, isAllLoadSuccess:Boolean = true) : void
      {
         _headBitmapData = sceneCharacterLoaderHead.getContent()[0] as BitmapData;
         if(sceneCharacterLoaderHead)
         {
            sceneCharacterLoaderHead.dispose();
         }
         if(!isAllLoadSuccess || !_headBitmapData)
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
         if(!_rectangle)
         {
            _rectangle = new Rectangle();
         }
         _rectangle.x = 0;
         _rectangle.y = 0;
         _rectangle.width = _playerWidth;
         _rectangle.height = _playerHeight;
         actionBmp = new BitmapData(_playerWidth,_playerHeight,true,0);
         actionBmp.copyPixels(_headBitmapData,_rectangle,new Point(0,0));
         _sceneCharacterSetNatural.push(new SceneCharacterItem("NaturalFrontHead","NaturalFrontAction",actionBmp,1,1,_playerWidth,_playerHeight,1,points,true,7));
         _rectangle.x = _playerWidth;
         _rectangle.y = 0;
         _rectangle.width = _playerWidth;
         _rectangle.height = _playerHeight;
         actionBmp = new BitmapData(_playerWidth,_playerHeight,true,0);
         actionBmp.copyPixels(_headBitmapData,_rectangle,new Point(0,0));
         _sceneCharacterSetNatural.push(new SceneCharacterItem("NaturalFrontEyesCloseHead","NaturalFrontEyesCloseAction",actionBmp,1,1,_playerWidth,_playerHeight,2));
         _rectangle.x = _playerWidth * 2;
         _rectangle.y = 0;
         _rectangle.width = _playerWidth;
         _rectangle.height = _playerHeight;
         actionBmp = new BitmapData(_playerWidth,_playerHeight * 2,true,0);
         actionBmp.copyPixels(_headBitmapData,_rectangle,new Point(0,0));
         _sceneCharacterSetNatural.push(new SceneCharacterItem("NaturalBackHead","NaturalBackAction",actionBmp,1,1,_playerWidth,_playerHeight,6,points,true,7));
         sceneCharacterLoadBodyNatural();
      }
      
      private function sceneCharacterLoadBodyNatural() : void
      {
         _sceneCharacterLoaderBody = new DiceSceneCharacterLoaderBody(_playerInfo);
         _sceneCharacterLoaderBody.load(sceneCharacterLoaderBodyNaturalCallBack);
      }
      
      private function sceneCharacterLoaderBodyNaturalCallBack(sceneCharacterLoaderBody:DiceSceneCharacterLoaderBody, isAllLoadSuccess:Boolean = true) : void
      {
         var actionBmp:* = null;
         if(!_sceneCharacterSetNatural)
         {
            return;
         }
         _bodyBitmapData = sceneCharacterLoaderBody.getContent()[0] as BitmapData;
         if(sceneCharacterLoaderBody)
         {
            sceneCharacterLoaderBody.dispose();
         }
         if(!isAllLoadSuccess || !_bodyBitmapData)
         {
            if(_callBack != null)
            {
               _callBack(this,false);
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
         _rectangle.height = _playerHeight;
         actionBmp = new BitmapData(_bodyBitmapData.width,_playerHeight,true,0);
         actionBmp.copyPixels(_bodyBitmapData,_rectangle,new Point(0,0));
         _sceneCharacterSetNatural.push(new SceneCharacterItem("NaturalFrontBody","NaturalFrontAction",actionBmp,1,7,_playerWidth,_playerHeight,3));
         _rectangle.x = 0;
         _rectangle.y = 0;
         _rectangle.width = _playerWidth;
         _rectangle.height = _playerHeight;
         actionBmp = new BitmapData(_playerWidth,_playerHeight,true,0);
         actionBmp.copyPixels(_bodyBitmapData,_rectangle,new Point(0,0));
         _sceneCharacterSetNatural.push(new SceneCharacterItem("NaturalFrontEyesCloseBody","NaturalFrontEyesCloseAction",actionBmp,1,1,_playerWidth,_playerHeight,4));
         _rectangle.x = 0;
         _rectangle.y = _playerHeight;
         _rectangle.width = _bodyBitmapData.width;
         _rectangle.height = _playerHeight;
         actionBmp = new BitmapData(_bodyBitmapData.width,_playerHeight,true,0);
         actionBmp.copyPixels(_bodyBitmapData,_rectangle,new Point(0,0));
         _sceneCharacterSetNatural.push(new SceneCharacterItem("NaturalbackBody","NaturalBackAction",actionBmp,1,7,_playerWidth,_playerHeight,5));
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
         .super.sceneCharacterStateSet = _sceneCharacterStateSet;
      }
      
      override public function playerWalk(walkPath:Array) : void
      {
         var _walkPath0:* = null;
         var po1:* = null;
         var _walkDistance:Number = NaN;
         _walkPath = walkPath;
         if(_walkPath && _walkPath.length > 0)
         {
            sceneCharacterDirection = SceneCharacterDirection.getDirection(new Point(this.x,this.y),_walkPath[0]);
            _walkPath0 = _walkPath[0] as Point;
            po1 = new Point(this.x,this.y);
            _walkDistance = Point.distance(_walkPath0,new Point(this.x,this.y));
            if(_walkDistance > 0 || DiceController.Instance.CurrentPosition == 0)
            {
               if(sceneCharacterDirection.type == "RT" && this.y - _walkPath[0].y <= 1)
               {
                  sceneCharacterDirection = new SceneCharacterDirection("LB",true);
               }
               dispatchEvent(new SceneCharacterEvent("characterDirectionChange",true));
            }
            _tween.start(_walkDistance / _moveSpeed,"x",_walkPath[0].x,"y",_walkPath[0].y);
            if(_SynchronousPosition != null)
            {
               _SynchronousPosition(_walkPath[0]);
            }
            _walkPath.shift();
         }
         else
         {
            dispatchEvent(new SceneCharacterEvent("characterDirectionChange",false));
         }
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
         if(_sceneCharacterLoaderBody)
         {
            _sceneCharacterLoaderBody.dispose();
         }
         _sceneCharacterLoaderBody = null;
         if(_sceneCharacterLoaderHead)
         {
            _sceneCharacterLoaderHead.dispose();
         }
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
