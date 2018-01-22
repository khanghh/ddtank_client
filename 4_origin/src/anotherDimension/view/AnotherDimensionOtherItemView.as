package anotherDimension.view
{
   import anotherDimension.model.AnotherDimensionResourceInfo;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.player.PlayerInfo;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import ddt.view.sceneCharacter.SceneCharacterLoaderHead;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.utils.Timer;
   
   public class AnotherDimensionOtherItemView extends Sprite implements Disposeable
   {
      
      private static var HeadWidth:int = 120;
      
      private static var HeadHeight:int = 103;
       
      
      private var _isBossResource:Boolean;
      
      private var _resourceLevel:int = 0;
      
      private var _resourcePlayerInfo:PlayerInfo;
      
      private var _resourceLevelBg:MovieClip;
      
      private var _zhanlingBnt:BaseButton;
      
      private var _lueduoBnt:BaseButton;
      
      private var _zhanlingOverBg:Bitmap;
      
      private var _lueduoOverBg:Bitmap;
      
      private var _anotherDimensionInfo:AnotherDimensionResourceInfo;
      
      private var _anotherDimensionOthertip:AnotherDimensionOtherTip;
      
      private var _tipSprite:Sprite;
      
      private var _timer:Timer;
      
      private var _headLoader:SceneCharacterLoaderHead;
      
      private var _headBitmap:Bitmap;
      
      public function AnotherDimensionOtherItemView(param1:AnotherDimensionResourceInfo)
      {
         super();
         _anotherDimensionInfo = param1;
         initView();
         initEvent();
      }
      
      public function get isBossResource() : Boolean
      {
         return _isBossResource;
      }
      
      public function set isBossResource(param1:Boolean) : void
      {
         _isBossResource = param1;
         if(_isBossResource)
         {
            _zhanlingBnt.visible = true;
            _lueduoBnt.visible = false;
         }
         else
         {
            _zhanlingBnt.visible = false;
            _lueduoBnt.visible = true;
         }
      }
      
      public function get resourceLevel() : int
      {
         return _resourceLevel;
      }
      
      public function set resourceLevel(param1:int) : void
      {
         _resourceLevel = param1;
         _resourceLevelBg.gotoAndStop(_resourceLevel);
      }
      
      private function initView() : void
      {
         _resourceLevelBg = ComponentFactory.Instance.creat("anotherDimension.resourceBg");
         _resourceLevelBg.gotoAndStop(_anotherDimensionInfo.resourceLevel);
         _zhanlingBnt = ComponentFactory.Instance.creatComponentByStylename("anotherDimension.anotherDimensionOtherItemView.zhanlingBnt");
         _lueduoBnt = ComponentFactory.Instance.creatComponentByStylename("anotherDimension.anotherDimensionOtherItemView.lueduoBnt");
         _zhanlingBnt.addEventListener("click",__clickZhanling);
         _lueduoBnt.addEventListener("click",__clickZhanling);
         _zhanlingOverBg = ComponentFactory.Instance.creat("anotherDimension.fightOverzhanling");
         _lueduoOverBg = ComponentFactory.Instance.creat("anotherDimension.fightOver");
         if(_anotherDimensionInfo.monsterId > 0)
         {
            isBossResource = true;
         }
         else
         {
            isBossResource = false;
         }
         if(_anotherDimensionInfo.resourceState == 1 && (_anotherDimensionInfo.resourcePlayerInfo && _anotherDimensionInfo.resourcePlayerInfo.ID == PlayerManager.Instance.Self.ID))
         {
            _zhanlingOverBg.visible = true;
            _lueduoOverBg.visible = false;
            _zhanlingBnt.visible = false;
            _lueduoBnt.visible = false;
         }
         else if(_anotherDimensionInfo.resourceState == 3 && (_anotherDimensionInfo.resourcePlayerInfo && _anotherDimensionInfo.resourcePlayerInfo.ID == PlayerManager.Instance.Self.ID))
         {
            _zhanlingOverBg.visible = true;
            _lueduoOverBg.visible = false;
            _zhanlingBnt.visible = false;
            _lueduoBnt.visible = false;
         }
         else if(_anotherDimensionInfo.resourceState == 2)
         {
            _zhanlingOverBg.visible = false;
            _lueduoOverBg.visible = true;
            _zhanlingBnt.visible = false;
            _lueduoBnt.visible = false;
         }
         else
         {
            _zhanlingOverBg.visible = false;
            _lueduoOverBg.visible = false;
            if(_anotherDimensionInfo.monsterId > 0)
            {
               isBossResource = true;
            }
            else
            {
               isBossResource = false;
            }
         }
         if(_anotherDimensionInfo.monsterId > 0)
         {
            addChild(_resourceLevelBg);
            if(_anotherDimensionInfo.monsterId == 80001 || _anotherDimensionInfo.monsterId == 80006 || _anotherDimensionInfo.monsterId == 80011)
            {
               _headBitmap = ComponentFactory.Instance.creat("anotherDimension.bossIcon1");
            }
            else if(_anotherDimensionInfo.monsterId == 80002 || _anotherDimensionInfo.monsterId == 80007 || _anotherDimensionInfo.monsterId == 80012)
            {
               _headBitmap = ComponentFactory.Instance.creat("anotherDimension.bossIcon2");
            }
            else if(_anotherDimensionInfo.monsterId == 80003 || _anotherDimensionInfo.monsterId == 80008 || _anotherDimensionInfo.monsterId == 80013)
            {
               _headBitmap = ComponentFactory.Instance.creat("anotherDimension.bossIcon3");
            }
            else if(_anotherDimensionInfo.monsterId == 80004 || _anotherDimensionInfo.monsterId == 80009 || _anotherDimensionInfo.monsterId == 80014)
            {
               _headBitmap = ComponentFactory.Instance.creat("anotherDimension.bossIcon4");
            }
            else if(_anotherDimensionInfo.monsterId == 80005 || _anotherDimensionInfo.monsterId == 80010 || _anotherDimensionInfo.monsterId == 80015)
            {
               _headBitmap = ComponentFactory.Instance.creat("anotherDimension.bossIcon5");
            }
            if(_headBitmap)
            {
               addChild(_headBitmap);
            }
            addChild(_zhanlingBnt);
            addChild(_lueduoBnt);
            addChild(_zhanlingOverBg);
            addChild(_lueduoOverBg);
         }
         else
         {
            loadHead();
         }
         _anotherDimensionOthertip = new AnotherDimensionOtherTip(_anotherDimensionInfo);
         _anotherDimensionOthertip.visible = false;
         _anotherDimensionOthertip.refreshView(_anotherDimensionInfo);
         PositionUtils.setPos(_anotherDimensionOthertip,"anotherDimension.anotherDimensionOtherItemView.anotherDimensionOthertipPos");
         addChild(_anotherDimensionOthertip);
         _tipSprite = new Sprite();
         _tipSprite.graphics.beginFill(16711680,0);
         _tipSprite.graphics.drawRect(27,27,88,75);
         _tipSprite.graphics.endFill();
         addChild(_tipSprite);
      }
      
      private function __clickZhanling(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         SocketManager.Instance.out.clickAnotherDimenZhanling(_anotherDimensionInfo.resourcePos);
      }
      
      public function loadHead() : void
      {
         if(_headLoader)
         {
            _headLoader.dispose();
            _headLoader = null;
         }
         _headLoader = new SceneCharacterLoaderHead(_anotherDimensionInfo.resourcePlayerInfo);
         _headLoader.load(headLoaderCallBack);
      }
      
      private function headLoaderCallBack(param1:SceneCharacterLoaderHead, param2:Boolean = true) : void
      {
         var _loc3_:* = null;
         var _loc4_:* = null;
         if(param1)
         {
            if(!_headBitmap)
            {
               _headBitmap = new Bitmap();
            }
            _loc3_ = new Rectangle(0,0,HeadWidth,HeadHeight);
            _loc4_ = new BitmapData(HeadWidth,HeadHeight,true,0);
            _loc4_.copyPixels(param1.getContent()[0] as BitmapData,_loc3_,new Point(0,0));
            _headBitmap.bitmapData = _loc4_;
            param1.dispose();
            _headBitmap.rotationY = 180;
            _headBitmap.width = 80;
            _headBitmap.height = 80;
            PositionUtils.setPos(_headBitmap,"anotherDimension.anotherDimension.headBitmapPos");
            addChild(_resourceLevelBg);
            addChild(_headBitmap);
            addChild(_zhanlingBnt);
            addChild(_lueduoBnt);
            addChild(_zhanlingOverBg);
            addChild(_lueduoOverBg);
            addChild(_anotherDimensionOthertip);
            addChild(_tipSprite);
         }
      }
      
      private function initEvent() : void
      {
         _tipSprite.addEventListener("mouseOver",overHandler);
         _tipSprite.addEventListener("mouseOut",outHandler);
         _timer = new Timer(60000);
         _timer.addEventListener("timer",_reflushTip);
         _timer.start();
      }
      
      private function _reflushTip(param1:TimerEvent) : void
      {
         _anotherDimensionOthertip.refreshView(_anotherDimensionInfo);
      }
      
      private function removeEvent() : void
      {
         _tipSprite.removeEventListener("mouseOver",overHandler);
         _tipSprite.removeEventListener("mouseOut",outHandler);
         if(_timer)
         {
            _timer.stop();
            _timer.removeEventListener("timer",_reflushTip);
            _timer = null;
         }
      }
      
      private function overHandler(param1:MouseEvent) : void
      {
         _anotherDimensionOthertip.visible = true;
         this.parent.setChildIndex(this,this.parent.numChildren - 1);
      }
      
      private function outHandler(param1:MouseEvent) : void
      {
         _anotherDimensionOthertip.visible = false;
      }
      
      public function dispose() : void
      {
         removeEvent();
         while(numChildren)
         {
            ObjectUtils.disposeObject(getChildAt(0));
         }
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}
