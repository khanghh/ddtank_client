package ddt.view.bossbox
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.MovieImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.CSMBoxManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   
   public class CSMBoxView extends Sprite implements Disposeable
   {
       
      
      private var _closeSprite:Component;
      
      private var _closeBox:MovieImage;
      
      private var _timeBG:Bitmap;
      
      private var _timeText:FilterFrameText;
      
      private var _openBox:MovieImage;
      
      private var _downBox:MovieImage;
      
      private var _showType:int = -1;
      
      public function CSMBoxView()
      {
         super();
         buttonMode = true;
         init();
         initEvent();
      }
      
      private function init() : void
      {
         _closeSprite = ComponentFactory.Instance.creatComponentByStylename("CSMBox.closeBoxTip");
         _closeSprite.tipData = LanguageMgr.GetTranslation("tanl.timebox.tipMes");
         _closeSprite.buttonMode = true;
         _closeBox = ComponentFactory.Instance.creatComponentByStylename("CSMBox.closeBox");
         _closeSprite.addChild(_closeBox);
         _timeBG = ComponentFactory.Instance.creatBitmap("asset.timeBox.timeBGAsset");
         _closeSprite.addChild(_timeBG);
         _timeText = ComponentFactory.Instance.creat("bossbox.TimeBoxStyle");
         _closeSprite.addChild(_timeText);
         addChild(_closeSprite);
         _openBox = ComponentFactory.Instance.creatComponentByStylename("CSMBox.openBox");
         addChild(_openBox);
         _downBox = ComponentFactory.Instance.creatComponentByStylename("CSMBox.downBox");
         addChild(_downBox);
         var _loc1_:Point = PositionUtils.creatPoint("CSMBoxViewPos");
         _downBox.x = _downBox.x - _loc1_.x;
         _downBox.y = _downBox.y - _loc1_.y;
         _downBox.buttonMode = true;
         _openBox.visible = false;
         _closeSprite.visible = false;
         _downBox.visible = false;
      }
      
      public function showBox(param1:int = 0) : void
      {
         if(_showType == param1)
         {
            return;
         }
         _showType = param1;
         if(!_openBox || !_closeSprite || !_downBox)
         {
            return;
         }
         switch(int(_showType))
         {
            case 0:
               _openBox.visible = false;
               _closeSprite.visible = true;
               _downBox.visible = false;
               break;
            case 1:
               _openBox.visible = true;
               _closeSprite.visible = false;
               _downBox.visible = false;
         }
      }
      
      public function updateTime(param1:int) : void
      {
         var _loc5_:* = 0;
         var _loc2_:int = 0;
         var _loc4_:int = 0;
         var _loc3_:* = null;
         if(_timeText)
         {
            _loc5_ = param1;
            _loc2_ = _loc5_ / 60;
            _loc4_ = _loc5_ % 60;
            _loc3_ = "";
            if(_loc2_ < 10)
            {
               _loc3_ = _loc3_ + ("0" + _loc2_);
            }
            else
            {
               _loc3_ = _loc3_ + _loc2_;
            }
            _loc3_ = _loc3_ + ":";
            if(_loc4_ < 10)
            {
               _loc3_ = _loc3_ + ("0" + _loc4_);
            }
            else
            {
               _loc3_ = _loc3_ + _loc4_;
            }
            _timeText.text = _loc3_;
         }
      }
      
      private function initEvent() : void
      {
         _closeBox.addEventListener("click",_boxClick);
         _openBox.addEventListener("click",_boxClick);
         _downBox.addEventListener("click",_boxClick);
      }
      
      private function _boxClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(param1.currentTarget == _closeBox)
         {
            CSMBoxManager.instance.showAwards();
         }
         else if(param1.currentTarget == _openBox)
         {
            _openBox.visible = false;
            _closeSprite.visible = false;
            _downBox.visible = true;
            _downBox.movie.stop();
            _downBox.movie.gotoAndPlay(1);
         }
         else if(param1.currentTarget == _downBox)
         {
            SocketManager.Instance.out.sendGetCSMTimeBox();
            dispose();
         }
      }
      
      private function removeEvent() : void
      {
         _closeBox.removeEventListener("click",_boxClick);
         _openBox.removeEventListener("click",_boxClick);
         _downBox.removeEventListener("click",_boxClick);
      }
      
      public function dispose() : void
      {
         if(_closeBox)
         {
            ObjectUtils.disposeObject(_closeBox);
         }
         _closeBox = null;
         if(_timeBG)
         {
            ObjectUtils.disposeObject(_timeBG);
         }
         _timeBG = null;
         if(_timeText)
         {
            ObjectUtils.disposeObject(_timeText);
         }
         _timeText = null;
         if(_closeSprite)
         {
            ObjectUtils.disposeAllChildren(_closeSprite);
            ObjectUtils.disposeObject(_closeSprite);
            _closeSprite = null;
         }
         if(_openBox)
         {
            ObjectUtils.disposeObject(_openBox);
         }
         _openBox = null;
         if(_downBox)
         {
            ObjectUtils.disposeObject(_downBox);
         }
         _downBox = null;
      }
   }
}
