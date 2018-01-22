package newOpenGuide
{
   import com.greensock.TweenLite;
   import com.greensock.easing.Quad;
   import com.pickgliss.manager.NoviceDataManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.PathManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   
   public class NewOpenGuideMiddleView extends Sprite implements Disposeable
   {
       
      
      private var _lightMc:MovieClip;
      
      private var _frameMc:MovieClip;
      
      private var _titleTxt:FilterFrameText;
      
      private var _iconMc:MovieClip;
      
      private var _btnSprite:Sprite;
      
      private var _titleStrIndexArray:Array;
      
      public function NewOpenGuideMiddleView()
      {
         super();
         initView();
         initEvent();
         refreshContent();
         playOpenCartoon();
      }
      
      private function initView() : void
      {
         _frameMc = ComponentFactory.Instance.creat("asset.newOpenGuide.frameMc");
         _lightMc = ComponentFactory.Instance.creat("asset.newOpenGuide.lightMc");
         _titleTxt = ComponentFactory.Instance.creatComponentByStylename("newOpenGuideMiddleView.titleTxt");
         _iconMc = ComponentFactory.Instance.creat("asset.newOpenGuide.iconMc");
         _btnSprite = new Sprite();
         _btnSprite.graphics.beginFill(16711680,0);
         _btnSprite.graphics.drawRect(-86,-41,166,127);
         _btnSprite.graphics.endFill();
         _btnSprite.buttonMode = true;
         _btnSprite.visible = false;
         addChild(_frameMc);
         addChild(_titleTxt);
         addChild(_lightMc);
         addChild(_iconMc);
         addChild(_btnSprite);
      }
      
      private function initEvent() : void
      {
         _frameMc.addEventListener("enterFrame",enterFrameHandler,false,0,true);
         _btnSprite.addEventListener("click",clickHandler,false,0,true);
      }
      
      private function enterFrameHandler(param1:Event) : void
      {
         if(_frameMc.currentFrame == 8)
         {
            _btnSprite.visible = true;
            _frameMc.removeEventListener("enterFrame",enterFrameHandler);
         }
      }
      
      private function clickHandler(param1:MouseEvent) : void
      {
         _btnSprite.visible = false;
         _lightMc.gotoAndPlay(1);
         _lightMc.addEventListener("enterFrame",enterFrameHandler2,false,0,true);
         TweenLite.to(_iconMc,0.4,{
            "x":-42,
            "y":-37,
            "scaleX":1.2,
            "scaleY":1.2
         });
         var _loc2_:Array = NewOpenGuideManager.instance.getTitleStrIndexByLevel(PlayerManager.Instance.Self.Grade);
         SocketManager.Instance.out.syncWeakStep(200 + _loc2_[2]);
         if(_loc2_[0] == 1)
         {
            NoviceDataManager.instance.saveNoviceData(470,PathManager.userName(),PathManager.solveRequestPath());
         }
         if(_loc2_[0] == 2)
         {
            NoviceDataManager.instance.saveNoviceData(650,PathManager.userName(),PathManager.solveRequestPath());
         }
         if(_loc2_[0] == 3)
         {
            NoviceDataManager.instance.saveNoviceData(720,PathManager.userName(),PathManager.solveRequestPath());
         }
         if(_loc2_[0] == 4)
         {
            NoviceDataManager.instance.saveNoviceData(910,PathManager.userName(),PathManager.solveRequestPath());
         }
         if(_loc2_[0] == 5)
         {
            NoviceDataManager.instance.saveNoviceData(980,PathManager.userName(),PathManager.solveRequestPath());
         }
         if(_loc2_[0] == 6)
         {
            NoviceDataManager.instance.saveNoviceData(1020,PathManager.userName(),PathManager.solveRequestPath());
         }
      }
      
      private function enterFrameHandler2(param1:Event) : void
      {
         var _loc2_:* = null;
         var _loc3_:* = null;
         if(_lightMc.currentFrame <= 10)
         {
            _iconMc.x = _iconMc.x - 0.5;
            _iconMc.y = _iconMc.y - 0.9;
            _iconMc.scaleX = _iconMc.scaleX + 0.02;
            _iconMc.scaleY = _iconMc.scaleY + 0.02;
         }
         if(_lightMc.currentFrame > 13 && _lightMc.currentFrame <= 18)
         {
            _iconMc.x = _iconMc.x + 1;
            _iconMc.y = _iconMc.y + 1.8;
            _iconMc.scaleX = _iconMc.scaleX - 0.04;
            _iconMc.scaleY = _iconMc.scaleY - 0.04;
         }
         if(_lightMc.currentFrame == 11)
         {
            TweenLite.to(_frameMc,0.4,{"alpha":0});
            TweenLite.to(_titleTxt,0.4,{"alpha":0});
         }
         if(_lightMc.currentFrame == 18)
         {
            _loc2_ = this.localToGlobal(new Point(_iconMc.x,_iconMc.y));
            LayerManager.Instance.addToLayer(_iconMc,2);
            _iconMc.x = _loc2_.x;
            _iconMc.y = _loc2_.y;
            _loc3_ = NewOpenGuideManager.instance.getMovePos();
            TweenLite.to(_iconMc,1,{
               "x":_loc3_.x,
               "y":_loc3_.y,
               "scaleX":0.6,
               "scaleY":0.6,
               "alpha":0.5,
               "ease":Quad.easeOut,
               "onComplete":allPlayComplete
            });
         }
         if(_lightMc.currentFrame == _lightMc.totalFrames)
         {
            _lightMc.removeEventListener("enterFrame",enterFrameHandler2);
         }
      }
      
      private function allPlayComplete() : void
      {
         dispose();
         dispatchEvent(new Event("complete"));
      }
      
      public function refreshContent() : void
      {
         _titleStrIndexArray = NewOpenGuideManager.instance.getTitleStrIndexByLevel(PlayerManager.Instance.Self.Grade);
         _titleTxt.text = _titleStrIndexArray[1];
         _iconMc.gotoAndStop(_titleStrIndexArray[0]);
         if(_titleStrIndexArray[0] == 1)
         {
            NoviceDataManager.instance.saveNoviceData(460,PathManager.userName(),PathManager.solveRequestPath());
         }
         if(_titleStrIndexArray[0] == 2)
         {
            NoviceDataManager.instance.saveNoviceData(640,PathManager.userName(),PathManager.solveRequestPath());
         }
      }
      
      private function playOpenCartoon() : void
      {
         _titleTxt.x = -19;
         _titleTxt.y = 22;
         _titleTxt.scaleX = 0.3;
         _titleTxt.scaleY = 0.3;
         _titleTxt.alpha = 0;
         _iconMc.x = -11;
         _iconMc.y = -8;
         _iconMc.scaleX = 0.3;
         _iconMc.scaleY = 0.3;
         TweenLite.to(_titleTxt,0.5,{
            "x":-63,
            "y":51,
            "scaleX":1,
            "scaleY":1,
            "alpha":1
         });
         TweenLite.to(_iconMc,0.5,{
            "x":-37,
            "y":-28,
            "scaleX":1,
            "scaleY":1
         });
      }
      
      private function removeEvent() : void
      {
         if(_frameMc)
         {
            _frameMc.removeEventListener("enterFrame",enterFrameHandler);
         }
         if(_btnSprite)
         {
            _btnSprite.removeEventListener("click",clickHandler);
         }
      }
      
      public function dispose() : void
      {
         removeEvent();
         if(_lightMc)
         {
            _lightMc.removeEventListener("enterFrame",enterFrameHandler2);
            _lightMc.gotoAndStop(_lightMc.totalFrames);
         }
         if(_frameMc)
         {
            _frameMc.gotoAndStop(_frameMc.totalFrames);
         }
         if(_iconMc)
         {
            _iconMc.gotoAndStop(_iconMc.totalFrames);
         }
         if(_frameMc)
         {
            _frameMc.gotoAndStop(_frameMc.totalFrames);
         }
         ObjectUtils.disposeAllChildren(this);
         ObjectUtils.disposeObject(_iconMc);
         _lightMc = null;
         _frameMc = null;
         _titleTxt = null;
         _iconMc = null;
         _btnSprite = null;
         _titleStrIndexArray = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
