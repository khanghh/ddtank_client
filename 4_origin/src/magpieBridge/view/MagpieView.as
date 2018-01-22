package magpieBridge.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.events.PkgEvent;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.SocketManager;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.geom.Point;
   import magpieBridge.MagpieBridgeManager;
   import magpieBridge.event.MagpieBridgeEvent;
   
   public class MagpieView extends Sprite implements Disposeable
   {
       
      
      private var _magpieVec:Vector.<Bitmap>;
      
      private var _showMagpie:MovieClip;
      
      private var _togetherMovie:MovieClip;
      
      private var _playMeetFlag:Boolean;
      
      private var _packs:ScaleFrameImage;
      
      public function MagpieView()
      {
         super();
         _magpieVec = new Vector.<Bitmap>();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         var _loc2_:int = 0;
         var _loc1_:* = null;
         _loc2_ = 0;
         while(_loc2_ < 10)
         {
            _loc1_ = ComponentFactory.Instance.creat("asset.magpieBridge.magpie");
            _loc1_.scaleX = _loc2_ % 2 == 0?-1:1;
            _loc1_.visible = false;
            PositionUtils.setPos(_loc1_,"magpieBridgeView.magpiePos" + _loc2_);
            addChild(_loc1_);
            _magpieVec.push(_loc1_);
            _loc2_++;
         }
         _magpieVec.reverse();
         _showMagpie = ComponentFactory.Instance.creat("asset.magpieBridge.magpie2");
         _showMagpie.gotoAndStop(1);
         _showMagpie.addFrameScript(_showMagpie.totalFrames - 1,setMagpieNum);
         _showMagpie.visible = false;
         addChild(_showMagpie);
         _togetherMovie = ComponentFactory.Instance.creat("asset.magpieBridge.together");
         _togetherMovie.gotoAndStop(1);
         _togetherMovie.visible = false;
         _togetherMovie.addFrameScript(_togetherMovie.totalFrames - 1,hideTogetherMovie);
         addChild(_togetherMovie);
         setMagpieNum();
         _packs = ComponentFactory.Instance.creatComponentByStylename("magpieBridge.magpieView.packsImage");
         _packs.tipData = LanguageMgr.GetTranslation("magpieBridgeView.magpie.packs");
         addChild(_packs);
      }
      
      private function initEvent() : void
      {
         SocketManager.Instance.addEventListener(PkgEvent.format(276,12),__onPlayMeet);
      }
      
      protected function __onPlayMeet(param1:PkgEvent) : void
      {
         _playMeetFlag = true;
      }
      
      public function showMagpie() : void
      {
         PositionUtils.setPos(_showMagpie,getCurrentMagpiePos());
         _showMagpie.scaleX = MagpieBridgeManager.instance.magpieModel.MagpieNum % 2 == 0?-1:1;
         _showMagpie.visible = true;
         _showMagpie.gotoAndPlay(1);
      }
      
      private function setMagpieNum() : void
      {
         var _loc2_:int = 0;
         var _loc1_:int = MagpieBridgeManager.instance.magpieModel.MagpieNum;
         _loc1_ = Math.min(_loc1_,_magpieVec.length);
         _loc2_ = 0;
         while(_loc2_ < _loc1_)
         {
            _magpieVec[_loc2_].visible = true;
            _loc2_++;
         }
         _showMagpie.stop();
         _showMagpie.visible = false;
         if(_playMeetFlag && _loc1_ == 10)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("magpieBridgeView.magpieOverTxt"));
            PositionUtils.setPos(_togetherMovie,"magpieBridgeView.togetherPos");
            _togetherMovie.visible = true;
            _togetherMovie.gotoAndPlay(1);
         }
         else
         {
            dispatchEvent(new MagpieBridgeEvent("setBtnEnable"));
         }
      }
      
      private function hideTogetherMovie() : void
      {
         _playMeetFlag = false;
         _togetherMovie.gotoAndStop(1);
         _togetherMovie.visible = false;
         MagpieBridgeManager.instance.magpieModel.MagpieNum = 0;
         resetMagpieState();
         dispatchEvent(new MagpieBridgeEvent("setBtnEnable"));
      }
      
      private function resetMagpieState() : void
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < _magpieVec.length)
         {
            _magpieVec[_loc1_].visible = false;
            _loc1_++;
         }
      }
      
      public function getCurrentMagpiePos(param1:Boolean = false) : Point
      {
         var _loc2_:* = null;
         var _loc3_:int = 0;
         _loc3_ = 0;
         while(_loc3_ < _magpieVec.length)
         {
            if(!_magpieVec[_loc3_].visible)
            {
               if(param1 && _loc3_ % 2 != 0)
               {
                  _loc2_ = new Point(_magpieVec[_loc3_].x - _magpieVec[_loc3_].width,_magpieVec[_loc3_].y);
               }
               else
               {
                  _loc2_ = new Point(_magpieVec[_loc3_].x,_magpieVec[_loc3_].y);
               }
               break;
            }
            _loc3_++;
         }
         return _loc2_;
      }
      
      public function dispose() : void
      {
         var _loc1_:int = 0;
         removeEvent();
         _loc1_ = 0;
         while(_loc1_ < _magpieVec.length)
         {
            _magpieVec[_loc1_].bitmapData.dispose();
            _magpieVec[_loc1_] = null;
            _loc1_++;
         }
         _magpieVec = null;
         ObjectUtils.disposeObject(_showMagpie);
         _showMagpie = null;
         ObjectUtils.disposeObject(_togetherMovie);
         _togetherMovie = null;
         ObjectUtils.disposeObject(_packs);
         _packs = null;
      }
      
      private function removeEvent() : void
      {
         SocketManager.Instance.removeEventListener(PkgEvent.format(276,12),__onPlayMeet);
      }
   }
}
