package consortionBattle.player
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.view.sceneCharacter.SceneCharacterActionItem;
   import ddt.view.sceneCharacter.SceneCharacterActionSet;
   import ddt.view.sceneCharacter.SceneCharacterItem;
   import ddt.view.sceneCharacter.SceneCharacterPlayerBase;
   import ddt.view.sceneCharacter.SceneCharacterSet;
   import ddt.view.sceneCharacter.SceneCharacterStateItem;
   import ddt.view.sceneCharacter.SceneCharacterStateSet;
   import flash.display.BitmapData;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class ConsortiaBattlePlayerBase extends SceneCharacterPlayerBase
   {
       
      
      private var _playerData:ConsortiaBattlePlayerInfo;
      
      private var _sceneCharacterStateSet:SceneCharacterStateSet;
      
      private var _defaultSceneCharacterStateSet:SceneCharacterStateSet;
      
      private var _sceneCharacterSetNatural:SceneCharacterSet;
      
      private var _defaultSceneCharacterSetNatural:SceneCharacterSet;
      
      private var _sceneCharacterActionSetNatural:SceneCharacterActionSet;
      
      private var _defaultSceneCharacterActionSetNatural:SceneCharacterActionSet;
      
      private var _headBitmapData:BitmapData;
      
      private var _bodyBitmapData:BitmapData;
      
      private var _rectangle:Rectangle;
      
      public var playerWidth:Number = 120;
      
      public var playerHeight:Number = 175;
      
      private var _callBack:Function;
      
      private var _sceneCharacterLoaderBody:ConsBatLoaderHeadOrBody;
      
      private var _sceneCharacterLoaderHead:ConsBatLoaderHeadOrBody;
      
      private var _loadComplete:Boolean = false;
      
      public function ConsortiaBattlePlayerBase(playerData:ConsortiaBattlePlayerInfo, callBack:Function = null)
      {
         _rectangle = new Rectangle();
         super(callBack);
         _playerData = playerData;
         _callBack = callBack;
         initialize();
      }
      
      private function initialize() : void
      {
         _sceneCharacterStateSet = new SceneCharacterStateSet();
         _sceneCharacterActionSetNatural = new SceneCharacterActionSet();
         _defaultSceneCharacterStateSet = new SceneCharacterStateSet();
         _defaultSceneCharacterActionSetNatural = new SceneCharacterActionSet();
         sceneCharacterLoadHead();
      }
      
      private function sceneCharacterLoadHead() : void
      {
         _sceneCharacterLoaderHead = new ConsBatLoaderHeadOrBody(_playerData,1);
         _sceneCharacterLoaderHead.load(sceneCharacterLoaderHeadCallBack);
         if(!_loadComplete)
         {
            _headBitmapData = ComponentFactory.Instance.creatBitmapData("game.player.defaultPlayerCharacter");
            showDefaultCharacter();
         }
      }
      
      private function showDefaultCharacter() : void
      {
         var actionBmp:* = null;
         _defaultSceneCharacterSetNatural = new SceneCharacterSet();
         if(!_rectangle)
         {
            _rectangle = new Rectangle();
         }
         _rectangle.x = 0;
         _rectangle.y = 0;
         _rectangle.width = playerWidth;
         _rectangle.height = playerHeight;
         actionBmp = new BitmapData(playerWidth,playerHeight,true,0);
         actionBmp.copyPixels(_headBitmapData,_rectangle,new Point(25,20));
         _defaultSceneCharacterSetNatural.push(new SceneCharacterItem("NaturalFrontHead","NaturalFrontAction",actionBmp,1,1,playerWidth,playerHeight,1));
         var sceneCharacterActionItem1:SceneCharacterActionItem = new SceneCharacterActionItem("naturalStandFront",[0],false);
         _defaultSceneCharacterActionSetNatural.push(sceneCharacterActionItem1);
         var sceneCharacterActionItem2:SceneCharacterActionItem = new SceneCharacterActionItem("naturalStandBack",[0],false);
         _defaultSceneCharacterActionSetNatural.push(sceneCharacterActionItem2);
         var sceneCharacterActionItem3:SceneCharacterActionItem = new SceneCharacterActionItem("naturalWalkFront",[0],false);
         _defaultSceneCharacterActionSetNatural.push(sceneCharacterActionItem3);
         var sceneCharacterActionItem4:SceneCharacterActionItem = new SceneCharacterActionItem("naturalWalkBack",[0],false);
         _defaultSceneCharacterActionSetNatural.push(sceneCharacterActionItem4);
         var _sceneCharacterStateItemNatural:SceneCharacterStateItem = new SceneCharacterStateItem("natural",_defaultSceneCharacterSetNatural,_defaultSceneCharacterActionSetNatural);
         _defaultSceneCharacterStateSet.push(_sceneCharacterStateItemNatural);
         .super.loadComplete = false;
         .super.isDefaultCharacter = true;
         .super.sceneCharacterStateSet = _defaultSceneCharacterStateSet;
      }
      
      private function sceneCharacterLoaderHeadCallBack(sceneCharacterLoaderHead:ConsBatLoaderHeadOrBody, isAllLoadSucceed:Boolean = true) : void
      {
         _headBitmapData = sceneCharacterLoaderHead.getContent()[0] as BitmapData;
         if(sceneCharacterLoaderHead)
         {
            sceneCharacterLoaderHead.dispose();
         }
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
         if(!_rectangle)
         {
            _rectangle = new Rectangle();
         }
         _rectangle.x = 0;
         _rectangle.y = 0;
         _rectangle.width = playerWidth;
         _rectangle.height = playerHeight;
         actionBmp = new BitmapData(playerWidth,playerHeight,true,0);
         actionBmp.copyPixels(_headBitmapData,_rectangle,new Point(0,0));
         _sceneCharacterSetNatural.push(new SceneCharacterItem("NaturalFrontHead","NaturalFrontAction",actionBmp,1,1,playerWidth,playerHeight,1,points,true,7));
         _rectangle.x = playerWidth;
         _rectangle.y = 0;
         _rectangle.width = playerWidth;
         _rectangle.height = playerHeight;
         actionBmp = new BitmapData(playerWidth,playerHeight,true,0);
         actionBmp.copyPixels(_headBitmapData,_rectangle,new Point(0,0));
         _sceneCharacterSetNatural.push(new SceneCharacterItem("NaturalFrontEyesCloseHead","NaturalFrontEyesCloseAction",actionBmp,1,1,playerWidth,playerHeight,2));
         _rectangle.x = playerWidth * 2;
         _rectangle.y = 0;
         _rectangle.width = playerWidth;
         _rectangle.height = playerHeight;
         actionBmp = new BitmapData(playerWidth,playerHeight * 2,true,0);
         actionBmp.copyPixels(_headBitmapData,_rectangle,new Point(0,0));
         _sceneCharacterSetNatural.push(new SceneCharacterItem("NaturalBackHead","NaturalBackAction",actionBmp,1,1,playerWidth,playerHeight,6,points,true,7));
         sceneCharacterLoadBodyNatural();
      }
      
      private function sceneCharacterLoadBodyNatural() : void
      {
         _sceneCharacterLoaderBody = new ConsBatLoaderHeadOrBody(_playerData,2);
         _sceneCharacterLoaderBody.load(sceneCharacterLoaderBodyNaturalCallBack);
      }
      
      private function sceneCharacterLoaderBodyNaturalCallBack(sceneCharacterLoaderBody:ConsBatLoaderHeadOrBody, isAllLoadSucceed:Boolean = true) : void
      {
         var actionBmp:* = null;
         _loadComplete = true;
         if(!_sceneCharacterSetNatural)
         {
            return;
         }
         _bodyBitmapData = sceneCharacterLoaderBody.getContent()[0] as BitmapData;
         if(sceneCharacterLoaderBody)
         {
            sceneCharacterLoaderBody.dispose();
         }
         if(!isAllLoadSucceed || !_bodyBitmapData)
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
         _rectangle.height = playerHeight;
         actionBmp = new BitmapData(_bodyBitmapData.width,playerHeight,true,0);
         actionBmp.copyPixels(_bodyBitmapData,_rectangle,new Point(0,0));
         _sceneCharacterSetNatural.push(new SceneCharacterItem("NaturalFrontBody","NaturalFrontAction",actionBmp,1,7,playerWidth,playerHeight,3));
         _rectangle.x = 0;
         _rectangle.y = 0;
         _rectangle.width = playerWidth;
         _rectangle.height = playerHeight;
         actionBmp = new BitmapData(playerWidth,playerHeight,true,0);
         actionBmp.copyPixels(_bodyBitmapData,_rectangle,new Point(0,0));
         _sceneCharacterSetNatural.push(new SceneCharacterItem("NaturalFrontEyesCloseBody","NaturalFrontEyesCloseAction",actionBmp,1,1,playerWidth,playerHeight,4));
         _rectangle.x = 0;
         _rectangle.y = playerHeight;
         _rectangle.width = _bodyBitmapData.width;
         _rectangle.height = playerHeight;
         actionBmp = new BitmapData(_bodyBitmapData.width,playerHeight,true,0);
         actionBmp.copyPixels(_bodyBitmapData,_rectangle,new Point(0,0));
         _sceneCharacterSetNatural.push(new SceneCharacterItem("NaturalBackBody","NaturalBackAction",actionBmp,1,7,playerWidth,playerHeight,5));
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
         .super.loadComplete = true;
         .super.isDefaultCharacter = false;
         .super.sceneCharacterStateSet = _sceneCharacterStateSet;
         disposeDefaultSource();
      }
      
      private function disposeDefaultSource() : void
      {
         if(_defaultSceneCharacterStateSet)
         {
            _defaultSceneCharacterStateSet.dispose();
         }
         _defaultSceneCharacterStateSet = null;
         if(_defaultSceneCharacterSetNatural)
         {
            _defaultSceneCharacterSetNatural.dispose();
         }
         _defaultSceneCharacterSetNatural = null;
         if(_defaultSceneCharacterActionSetNatural)
         {
            _defaultSceneCharacterActionSetNatural.dispose();
         }
         _defaultSceneCharacterActionSetNatural = null;
      }
      
      override public function dispose() : void
      {
         disposeDefaultSource();
         _playerData = null;
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
