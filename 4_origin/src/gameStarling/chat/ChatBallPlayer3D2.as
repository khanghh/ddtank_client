package gameStarling.chat
{
   import bones.BoneMovieFactory;
   import bones.loader.BonesLoaderEvent;
   import bones.loader.BonesLoaderManager;
   import com.pickgliss.utils.StarlingObjectUtils;
   import flash.geom.Point;
   import times.utils.timerManager.TimerManager;
   
   public class ChatBallPlayer3D2 extends ChatBallBase3D
   {
       
      
      private var _currentPaopaoType:int = 0;
      
      private var _field2:ChatBallTextAreaBuff3D;
      
      public function ChatBallPlayer3D2()
      {
         super();
         init();
      }
      
      private function init() : void
      {
         _field = new ChatBallTextAreaPlayer3D();
         _field2 = new ChatBallTextAreaBuff3D();
      }
      
      override protected function get field() : ChatBallTextAreaBase3D
      {
         if(_currentPaopaoType != 9)
         {
            return _field;
         }
         return _field2;
      }
      
      override public function setText(s:String, paopaoType:int = 0) : void
      {
         clear();
         var temp:int = this.globalToLocal(new Point(500,10)).x;
         field.x = temp < 0?0:temp;
         field.text = s;
         if(_currentPaopaoType != paopaoType || paopao == null)
         {
            _currentPaopaoType = paopaoType;
            if(!BoneMovieFactory.instance.hasBoneMovie(getChatBallName()))
            {
               BonesLoaderManager.instance.removeEventListener("complete",__onLoaderComplete);
               BonesLoaderManager.instance.addEventListener("complete",__onLoaderComplete);
               BonesLoaderManager.instance.startLoader(getChatBallName());
            }
            else
            {
               newPaopao();
            }
         }
         waitShow();
      }
      
      private function __onLoaderComplete(e:BonesLoaderEvent) : void
      {
         if(e.vo.styleName == getChatBallName())
         {
            BonesLoaderManager.instance.removeEventListener("complete",__onLoaderComplete);
            newPaopao();
            waitShow();
         }
      }
      
      private function waitShow() : void
      {
         if(BoneMovieFactory.instance.hasBoneMovie(getChatBallName()))
         {
            if(_currentPaopaoType == 9)
            {
               _popupTimer = TimerManager.getInstance().addTimerJuggler(2700,1);
            }
            else
            {
               _popupTimer = TimerManager.getInstance().addTimerJuggler(4000,1);
            }
            fitSize(field);
            show();
         }
      }
      
      override public function show() : void
      {
         super.show();
         beginPopDelay();
      }
      
      override public function set width(value:Number) : void
      {
         .super.width = value;
      }
      
      private function newPaopao() : void
      {
         StarlingObjectUtils.disposeObject(_chatballBackground);
         _chatballBackground = new ChatBallBackground3D(getChatBallName());
         addChildAt(_chatballBackground,0);
      }
      
      private function getChatBallName() : String
      {
         return "ChatBall1600" + _currentPaopaoType;
      }
      
      override public function dispose() : void
      {
         BonesLoaderManager.instance.removeEventListener("complete",__onLoaderComplete);
         StarlingObjectUtils.disposeObject(_field2);
         _field2 = null;
         super.dispose();
      }
   }
}
