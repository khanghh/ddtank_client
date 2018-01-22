package anotherDimension.view
{
   import anotherDimension.model.AnotherDimensionResourceInfo;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.player.PlayerInfo;
   import ddt.manager.PlayerManager;
   import ddt.manager.TimeManager;
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
   
   public class AnotherDimensionSelfItemView extends Sprite implements Disposeable
   {
      
      private static var HeadWidth:int = 120;
      
      private static var HeadHeight:int = 103;
       
      
      private var _resourceLevel:int = 0;
      
      private var _resourcePlayerInfo:PlayerInfo;
      
      private var _resourceLevelBg:MovieClip;
      
      private var _headLoader:SceneCharacterLoaderHead;
      
      private var _headBitmap:Bitmap;
      
      private var _daojishiTxt:FilterFrameText;
      
      private var _daojishiBg:Bitmap;
      
      private var _anotherDimensionInfo:AnotherDimensionResourceInfo;
      
      private var _anotherDimensionOthertip:AnotherDimensionOtherTip;
      
      private var _tipSprite:Sprite;
      
      private var _timer:Timer;
      
      private var hourTime:Number = 3600000.0;
      
      private var minuteTime:Number = 60000.0;
      
      public function AnotherDimensionSelfItemView(param1:AnotherDimensionResourceInfo)
      {
         super();
         _anotherDimensionInfo = param1;
         initView();
         loadHead();
         initEvent();
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
         _resourceLevelBg.gotoAndStop(_resourceLevel);
         _daojishiBg = ComponentFactory.Instance.creat("anotherDimension.daojishiBg");
         _daojishiTxt = ComponentFactory.Instance.creatComponentByStylename("anotherDimension.daojishiTxt");
         _anotherDimensionOthertip = new AnotherDimensionOtherTip(_anotherDimensionInfo);
         _anotherDimensionOthertip.visible = false;
         _anotherDimensionOthertip.refreshView(_anotherDimensionInfo);
         _anotherDimensionOthertip.setSelfTipStyle(_anotherDimensionInfo);
         PositionUtils.setPos(_anotherDimensionOthertip,"anotherDimension.anotherDimensionOtherItemView.anotherDimensionOthertipPos");
         addChild(_anotherDimensionOthertip);
         _tipSprite = new Sprite();
         _tipSprite.graphics.beginFill(16711680,0);
         _tipSprite.graphics.drawRect(27,27,88,75);
         _tipSprite.graphics.endFill();
         addChild(_tipSprite);
      }
      
      public function loadHead() : void
      {
         if(_headLoader)
         {
            _headLoader.dispose();
            _headLoader = null;
         }
         _headLoader = new SceneCharacterLoaderHead(PlayerManager.Instance.Self);
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
            addChild(_daojishiBg);
            addChild(_daojishiTxt);
            addChild(_anotherDimensionOthertip);
            addChild(_tipSprite);
            setDaojishi();
         }
      }
      
      private function setDaojishi() : void
      {
         var _loc9_:Date = _anotherDimensionInfo.haveResourceTime;
         var _loc5_:int = _anotherDimensionInfo.haveResourceLast;
         var _loc8_:Date = TimeManager.Instance.Now();
         var _loc3_:Number = _loc9_.getTime();
         var _loc2_:Number = _loc5_ * minuteTime;
         var _loc1_:Number = _loc8_.getTime();
         var _loc7_:Number = _loc3_ + _loc2_ - _loc1_;
         var _loc6_:int = Math.floor(_loc7_ / minuteTime);
         if(_loc6_ <= 1)
         {
            _loc6_ = 1;
         }
         var _loc4_:String = _loc6_ + "phút";
         _daojishiTxt.text = _loc4_;
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
         _anotherDimensionOthertip.setSelfTipStyle(_anotherDimensionInfo);
         setDaojishi();
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
