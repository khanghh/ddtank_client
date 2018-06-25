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
         var i:int = 0;
         var magpie:* = null;
         for(i = 0; i < 10; )
         {
            magpie = ComponentFactory.Instance.creat("asset.magpieBridge.magpie");
            magpie.scaleX = i % 2 == 0?-1:1;
            magpie.visible = false;
            PositionUtils.setPos(magpie,"magpieBridgeView.magpiePos" + i);
            addChild(magpie);
            _magpieVec.push(magpie);
            i++;
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
      
      protected function __onPlayMeet(event:PkgEvent) : void
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
         var i:int = 0;
         var num:int = MagpieBridgeManager.instance.magpieModel.MagpieNum;
         num = Math.min(num,_magpieVec.length);
         for(i = 0; i < num; )
         {
            _magpieVec[i].visible = true;
            i++;
         }
         _showMagpie.stop();
         _showMagpie.visible = false;
         if(_playMeetFlag && num == 10)
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
         var i:int = 0;
         for(i = 0; i < _magpieVec.length; )
         {
            _magpieVec[i].visible = false;
            i++;
         }
      }
      
      public function getCurrentMagpiePos(transFlag:Boolean = false) : Point
      {
         var point:* = null;
         var i:int = 0;
         for(i = 0; i < _magpieVec.length; )
         {
            if(!_magpieVec[i].visible)
            {
               if(transFlag && i % 2 != 0)
               {
                  point = new Point(_magpieVec[i].x - _magpieVec[i].width,_magpieVec[i].y);
               }
               else
               {
                  point = new Point(_magpieVec[i].x,_magpieVec[i].y);
               }
               break;
            }
            i++;
         }
         return point;
      }
      
      public function dispose() : void
      {
         var i:int = 0;
         removeEvent();
         for(i = 0; i < _magpieVec.length; )
         {
            _magpieVec[i].bitmapData.dispose();
            _magpieVec[i] = null;
            i++;
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
